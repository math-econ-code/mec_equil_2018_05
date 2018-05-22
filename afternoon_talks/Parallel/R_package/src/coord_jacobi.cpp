/*
 * Coordinate descent - Jacobi method
 */

#include "coord_jacobi.hpp"

arma::mat
coord_jacobi(uint n_x, double lb, double ub, double err_tol, uint max_iter)
{
    uint n_xx = n_x*n_x;

    arma::vec seq_vec = arma::linspace(0.1,1.0,n_x);

    arma::vec n_vec(n_xx);
    n_vec.fill(1.0);

    //

    arma::mat XYZ_mat = make_grid(seq_vec);

    arma::vec m_vec = XYZ_mat.col(0) % XYZ_mat.col(1);

    arma::mat U_mat = arma::zeros(n_xx,n_xx);
    arma::mat C_mat = arma::zeros(n_xx,n_xx);

    for (uint i=0; i < n_xx; i++)
    {
        arma::uvec tmp_inds = arma::find( dist_fn(XYZ_mat,XYZ_mat.row(i)) >= (1.0/n_x - 1e-08) );

        arma::rowvec U_i = U_mat.row(i);
        U_i(tmp_inds).fill(-10.0);
        U_mat.row(i) = U_i;

        //

        C_mat.row(i) = arma::trans( arma::pow(dist_fn(XYZ_mat,XYZ_mat.row(i)),2) );
    }

    //

    arma::vec prices = arma::zeros(n_xx,1);

    //

    jacobi_zeroin_data_t root_data;

    root_data.n_vec = n_vec;
    root_data.m_vec = m_vec;

    root_data.U_mat = U_mat;
    root_data.C_mat = C_mat;

    uint iter = 0;
    // uint max_iter = 1000;

    double err_val = 1.0;
    // double err_tol = 1e-08;

    arma::vec prices_up = prices;

    clocktime_t begin_time = tic();

    while (err_val > err_tol && iter < max_iter)
    {
        iter++;

        root_data.prices = prices;

        #pragma omp parallel for firstprivate(root_data)
        for (uint j=0; j < n_xx; j++)
        {
            root_data.j = j;
            prices_up(j) = zeroin(lb,ub,root_fn,&root_data,1E-08,1000);
        }

        err_val = (arma::abs(prices_up - prices)).max() / (1.0 + (arma::abs(prices)).max());

        prices = prices_up;

        std::cout << "Iteration = " << iter << ". error = " << err_val << std::endl;
    }

    tictoc(begin_time);

    //

    return prices;
}
