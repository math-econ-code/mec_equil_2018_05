/*
 * Coordinate descent - Jacobi method
 */

#ifndef _JACOBI_HPP
#define _JACOBI_HPP

#include <RcppArmadillo.h>

#include "zeroin.hpp"
#include "tictoc.hpp"
#include "main_fns.hpp"

arma::mat coord_jacobi(uint n_x, double lb, double ub, double err_tol, uint max_iter);

#endif
