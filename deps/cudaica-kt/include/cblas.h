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

#ifndef __CBLAS_HH__
#define __CBLAS_HH__

#ifdef __cplusplus
extern "C" {
#endif

extern real ddot_(int*, real*, int*, real*, int*);
extern int idamax_(int*, real*, int*);
extern int ilaenv_(int*, char*, char*, int*, int*, int*, int*);
extern void dscal_(int*, real*, real*, int*);
extern void dcopy_(int*, real*, int*, real*, int*);
extern void dswap_(int*, real*, int*, real*, int*);
extern void daxpy_(int*, real*, real*, int*, real*, int*);
extern void dgemv_(char*, int*, int*, real*, real*, int*, real*, int*, real*, real*, int*);
extern void dgemm_(char*, char*, int*, int*, int*, real*, real*, int*, real*, int*, real*, real*, int*);
extern void dsymm_(char*, char*, int*, int*, real*, real*, int*, real*, int*, real*, real*, int*);
extern void dsyrk_(char*, char*, int*, int*, real*, real*, int*, real*, real*, int*);
extern void dsyev_(char*, char*, int*, real*, int*, real*, real*, int*, int*);
extern void dgesv_(int*, int*, real*, int*, int*, real*, int*, int*);
extern void dgetri_(int*, real*, int*, int*, real*, int*, int*);
extern void dgetrf_(int*, int*, real*, int*, int*, int*);

#ifdef __cplusplus
}
#endif
#endif
