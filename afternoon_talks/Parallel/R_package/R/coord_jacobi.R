################################################################################
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
################################################################################

coord_jacobi <- function(n_x, bounds=c(0,2), err_tol=1E-08, max_iter=1000)
{
    res <- .Call("coord_jacobi_R", n_x,bounds[1],bounds[2],err_tol,max_iter, PACKAGE = "MEC")

    return(res)
}
