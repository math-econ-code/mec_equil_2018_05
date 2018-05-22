/*################################################################################
  ##
  ##   Copyright (C) 2018 Keith O'Hara
  ##
  ##   This file is part of the R package MEC.
  ##
  ##   The R package MEC is free software: you can redistribute it and/or modify
  ##   it under the terms of the GNU General Public License as published by
  ##   the Free Software Foundation, either version 2 of the License, or
  ##   (at your option) any later version.
  ##
  ##   The R package MEC is distributed in the hope that it will be useful,
  ##   but WITHOUT ANY WARRANTY; without even the implied warranty of
  ##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ##   GNU General Public License for more details.
  ##
  ##   You should have received a copy of the GNU General Public License
  ##   along with MEC. If not, see <http://www.gnu.org/licenses/>.
  ##
  ################################################################################*/

#include "MEC.hpp"

using namespace Rcpp;

SEXP coord_jacobi_R(SEXP n_x_R, SEXP lb_R, SEXP ub_R, SEXP err_tol_R, SEXP max_iter_R)
{
    try {
        uint n_x = as<int>(n_x_R);

        double lb = as<double>(lb_R);
        double ub = as<double>(ub_R);

        double err_tol = as<double>(err_tol_R);
        uint max_iter = as<int>(max_iter_R);

        arma::vec prices = coord_jacobi(n_x,lb,ub,err_tol,max_iter);

        return Rcpp::wrap(prices);
    } catch( std::exception &ex ) {
        forward_exception_to_r( ex );
    } catch(...) {
        ::Rf_error( "MEC: C++ exception (unknown reason)" );
    }
    return R_NilValue;
}
