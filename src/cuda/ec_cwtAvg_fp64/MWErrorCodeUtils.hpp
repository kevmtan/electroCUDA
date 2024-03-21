// Copyright 2020-2021 The MathWorks, Inc.

#ifndef MW_ERROR_CODE_UTILS_HPP
#define MW_ERROR_CODE_UTILS_HPP

#include "cublas_v2.h"
#include "cusolverDn.h"
#include "cufft.h"

void cublasGetErrorName(int errCode, const char** errName);

void cublasGetErrorString(int errCode, const char** errString);

void cusolverGetErrorName(int errCode, const char** errName);

void cusolverGetErrorString(int errCode, const char** errString);

void cufftGetErrorName(int errCode, const char** errName);

void cufftGetErrorString(int errCode, const char** errString);

#endif // #ifndef MW_ERROR_CODE_UTILS_HPP
