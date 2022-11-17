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

#ifndef __ERROR_H__
#define __ERROR_H__



#define SUCCESS 0

#define ERRORNODEVICEMEM 	-1				//No more memory on device
#define ERRORNOPARAM 		-2				//Parameter error
#define ERRORINVALIDPARAM	-3				//Parameter is invalid
#define ERRORINVALIDCONFIG	-4				//Config file is invalid
#define ERRORNOFILE			-5				//Error opening file

#define HANDLE_ERROR( err ) (HandleError( err, __FILE__, __LINE__ ))
#define CHECK_ERROR() (HandleError(cudaGetLastError(), __FILE__, __LINE__))

#define PRINT_ERR(err, err2) \
		if ((err) == (err2)) { \
			fprintf(stderr, "ERROR::%s (%x) in %s at line %d\n", err2##_STR, (err), __FILE__, __LINE__ ); \
		}

#define HANDLE_CUBLAS_ERROR( errn ) \
	if ((errn) != 0) {\
		PRINT_ERR(errn, CUBLAS_STATUS_NOT_INITIALIZED) \
		else PRINT_ERR(errn, CUBLAS_STATUS_ALLOC_FAILED) \
		else PRINT_ERR(errn, CUBLAS_STATUS_INVALID_VALUE) \
		else PRINT_ERR(errn, CUBLAS_STATUS_ARCH_MISMATCH) \
		else PRINT_ERR(errn, CUBLAS_STATUS_MAPPING_ERROR) \
		else PRINT_ERR(errn, CUBLAS_STATUS_EXECUTION_FAILED) \
		else PRINT_ERR(errn, CUBLAS_STATUS_INTERNAL_ERROR) \
		fprintf(stderr, "ERROR::%s (%x) in %s at line %d\n", "UNKNOWN", errn, __FILE__, __LINE__ ); \
		exit( EXIT_FAILURE ); \
   }

#ifdef __cplusplus
extern "C" {
#endif

void HandleError( cudaError_t err, const char *file, int line );
void ResetError(void);

#ifdef __cplusplus
}
#endif

#endif
