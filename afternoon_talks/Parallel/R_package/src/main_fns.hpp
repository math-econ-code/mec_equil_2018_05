//
//
//

inline
arma::mat
make_grid(const arma::vec& x)
{
    arma::uword n_x = x.n_elem;

    arma::mat X(n_x*n_x,2);

    X.col(0) = arma::repmat(x,n_x,1);

    for (arma::uword i=0; i < n_x; i++)
    {
        X(arma::span(i*n_x,(i+1)*n_x-1),1).fill(x(i));
    }

    return(X);
}

inline
arma::vec
dist_fn(const arma::mat& X, const arma::rowvec& Y_vec)
{
    return arma::sqrt(arma::sum( arma::pow(X-arma::repmat(Y_vec,X.n_rows,1),2) , 1));
}

inline
double
demand_fn_j(const arma::vec& prices, const arma::mat& U_mat, const arma::vec& n_vec, uint j)
{
    uint n_xx = U_mat.n_rows;

    double ret_val = arma::accu( n_vec % arma::exp(U_mat.col(j) - prices(j)) \
                     / (1.0 + arma::sum(arma::exp(U_mat - arma::repmat(prices.t(),n_xx,1)),1)) );

    return ret_val;
}

inline
double
supply_fn_j(const arma::vec& prices, const arma::mat& C_mat, const arma::vec& m_vec, uint j)
{
    uint n_xx = C_mat.n_rows;

    double ret_val = arma::accu( m_vec % arma::exp(prices(j) - C_mat.col(j)) \
                     / (1.0 + arma::sum(arma::exp(arma::repmat(prices.t(),n_xx,1) - C_mat),1)) );

    return ret_val;
}

//

struct jacobi_zeroin_data_t
{
    uint j;

    arma::vec prices;

    arma::vec n_vec;
    arma::vec m_vec;

    arma::mat U_mat;
    arma::mat C_mat;
};

inline
double
root_fn(double x, void* opt_data)
{
    jacobi_zeroin_data_t* d = reinterpret_cast<jacobi_zeroin_data_t*>(opt_data);

    arma::vec prices = d->prices;
    prices(d->j) = x;

    return - demand_fn_j(prices,d->U_mat,d->n_vec,d->j) + supply_fn_j(prices,d->C_mat,d->m_vec,d->j);
}
