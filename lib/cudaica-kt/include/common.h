/*
 *	Copyright (C) 2011, Federico Raimondo (fraimondo@dc.uba.ar)
 *
 *	This file is part of Cudaica.
 *
 *  Cudaica is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 *
 *  Cudaica is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Cudaica.  If not, see <http://www.gnu.org/licenses/>.
 */


#ifndef __COMMON_H__
#define __COMMON_H__


#ifdef __cplusplus
extern "C" {
#endif

__global__ void zeroMatrix(real* data, size_t pitch);

__global__ void eye(real* data, size_t pitch);

void 		printVector(real* data, natural size);
void 		dev_printVector(real* data, natural size, natural max);
void 		dev_matwriteInt(char *fname, int rows, int cols, int *mat, size_t pitch);
void 		dev_matwriteNat(char *fname, int rows, int cols, natural *mat, size_t pitch);
void 		dev_matreadInt(char *fname, int rows, int cols, int *mat, size_t pitch);
void 		dev_matwrite(char *fname, int rows, int cols, real *mat, size_t pitch);
void 		dev_matread(char *fname, int rows, int cols, real *mat, size_t pitch);

real 		dsum_(integer *n, real *dx, integer *incx);
#ifdef __cplusplus
}
#endif

#endif
