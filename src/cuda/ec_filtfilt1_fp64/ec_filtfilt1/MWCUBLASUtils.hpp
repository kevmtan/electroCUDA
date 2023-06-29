// Copyright 2020 The MathWorks, Inc.

#ifndef MW_CUBLAS_UTILS_HPP
#define MW_CUBLAS_UTILS_HPP

#include "cublas_v2.h"

cublasHandle_t getCublasGlobalHandle();

void cublasEnsureInitialization(cublasPointerMode_t pointerMode);

void cublasEnsureDestruction();

#endif // #ifndef MW_CUBLAS_UTILS_HPP
