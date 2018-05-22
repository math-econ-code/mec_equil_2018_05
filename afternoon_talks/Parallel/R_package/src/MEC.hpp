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

#ifndef _MEC_HPP
#define _MEC_HPP

#include "coord_jacobi.hpp"

RcppExport SEXP coord_jacobi_R(SEXP n_x_R, SEXP lb_R, SEXP ub_R, SEXP err_tol_R, SEXP max_iter_R);


#endif
