// Copyright 2020-2021 The MathWorks, Inc.

#include "MWErrorCodeUtils.hpp"

namespace {
    const char* cublasGetErrorNameImpl(int errCode) {
        cublasStatus_t errCodeEnum = static_cast<cublasStatus_t>(errCode);

        switch (errCodeEnum) {
        case CUBLAS_STATUS_SUCCESS:
            return "CUBLAS_STATUS_SUCCESS";
        case CUBLAS_STATUS_NOT_INITIALIZED:
            return "CUBLAS_STATUS_NOT_INITIALIZED";
        case CUBLAS_STATUS_ALLOC_FAILED:
            return "CUBLAS_STATUS_ALLOC_FAILED";
        case CUBLAS_STATUS_INVALID_VALUE:
            return "CUBLAS_STATUS_INVALID_VALUE";
        case CUBLAS_STATUS_ARCH_MISMATCH:
            return "CUBLAS_STATUS_ARCH_MISMATCH";
        case CUBLAS_STATUS_MAPPING_ERROR:
            return "CUBLAS_STATUS_MAPPING_ERROR";
        case CUBLAS_STATUS_EXECUTION_FAILED:
            return "CUBLAS_STATUS_EXECUTION_FAILED";
        case CUBLAS_STATUS_INTERNAL_ERROR:
            return "CUBLAS_STATUS_INTERNAL_ERROR";
        case CUBLAS_STATUS_NOT_SUPPORTED:
            return "CUBLAS_STATUS_NOT_SUPPORTED";
        case CUBLAS_STATUS_LICENSE_ERROR:
            return "CUBLAS_STATUS_LICENSE_ERROR";
        default:
            return "unrecognized error code";
        }
    }

    const char* cublasGetErrorStringImpl(int errCode) {
        cublasStatus_t errCodeEnum = static_cast<cublasStatus_t>(errCode);

        switch (errCodeEnum) {
        case CUBLAS_STATUS_SUCCESS:
            return "the operation completed successfully";
        case CUBLAS_STATUS_NOT_INITIALIZED:
            return "the cuBLAS library was not initialized";
        case CUBLAS_STATUS_ALLOC_FAILED:
            return "resource allocation failed inside the cuBLAS library";
        case CUBLAS_STATUS_INVALID_VALUE:
            return "an unsupported value or parameter was passed to the function";
        case CUBLAS_STATUS_ARCH_MISMATCH:
            return "the function requires a feature absent from the device architecture";
        case CUBLAS_STATUS_MAPPING_ERROR:
            return "an access to GPU memory space failed";
        case CUBLAS_STATUS_EXECUTION_FAILED:
            return "the GPU program failed to execute";
        case CUBLAS_STATUS_INTERNAL_ERROR:
            return "an internal cuBLAS operation failed";
        case CUBLAS_STATUS_NOT_SUPPORTED:
            return "the functionality requested is not supported";
        case CUBLAS_STATUS_LICENSE_ERROR:
            return "the functionality requested requires some license and an "
                "error was detected when trying to check the current licensing";
        default:
            return "unrecognized error code";
        }
    }

    const char* cusolverGetErrorNameImpl(int errCode) {
        cusolverStatus_t errCodeEnum = static_cast<cusolverStatus_t>(errCode);

        switch (errCodeEnum) {
        case CUSOLVER_STATUS_SUCCESS:
            return "CUSOLVER_STATUS_SUCCESS";
        case CUSOLVER_STATUS_NOT_INITIALIZED:
            return "CUSOLVER_STATUS_NOT_INITIALIZED";
        case CUSOLVER_STATUS_ALLOC_FAILED:
            return "CUSOLVER_STATUS_ALLOC_FAILED";
        case CUSOLVER_STATUS_INVALID_VALUE:
            return "CUSOLVER_STATUS_INVALID_VALUE";
        case CUSOLVER_STATUS_ARCH_MISMATCH:
            return "CUSOLVER_STATUS_ARCH_MISMATCH";
        case CUSOLVER_STATUS_EXECUTION_FAILED:
            return "CUSOLVER_STATUS_EXECUTION_FAILED";
        case CUSOLVER_STATUS_INTERNAL_ERROR:
            return "CUSOLVER_STATUS_INTERNAL_ERROR";
        case CUSOLVER_STATUS_MATRIX_TYPE_NOT_SUPPORTED:
            return "CUSOLVER_STATUS_MATRIX_TYPE_NOT_SUPPORTED";
        default:
            return "unrecognized error code";
        }
    }

    const char* cusolverGetErrorStringImpl(int errCode) {
        cusolverStatus_t errCodeEnum = static_cast<cusolverStatus_t>(errCode);

        switch (errCodeEnum) {
        case CUSOLVER_STATUS_SUCCESS:
            return "the operation completed successfully";
        case CUSOLVER_STATUS_NOT_INITIALIZED:
            return "the cuSolver library was not initialized";
        case CUSOLVER_STATUS_ALLOC_FAILED:
            return "resource allocation failed inside the cuSolver library";
        case CUSOLVER_STATUS_INVALID_VALUE:
            return "an unsupported value or parameter was passed to the function";
        case CUSOLVER_STATUS_ARCH_MISMATCH:
            return "the function requires a feature absent from the device architecture";
        case CUSOLVER_STATUS_EXECUTION_FAILED:
            return "the GPU program failed to execute";
        case CUSOLVER_STATUS_INTERNAL_ERROR:
            return "an internal cuSolver operation failed";
        case CUSOLVER_STATUS_MATRIX_TYPE_NOT_SUPPORTED:
            return "the matrix type is not supported by this function";
        default:
            return "unrecognized error code";
        }
    }

    const char* cufftGetErrorNameImpl(int errCode) {
        cufftResult_t errCodeEnum = static_cast<cufftResult_t>(errCode);

        switch (errCodeEnum) {
        case CUFFT_SUCCESS:
            return "CUFFT_SUCCESS";
        case CUFFT_INVALID_PLAN:
            return "CUFFT_INVALID_PLAN";
        case CUFFT_ALLOC_FAILED:
            return "CUFFT_ALLOC_FAILED";
        case CUFFT_INVALID_TYPE:
            return "CUFFT_INVALID_TYPE";
        case CUFFT_INVALID_VALUE:
            return "CUFFT_INVALID_VALUE";
        case CUFFT_INTERNAL_ERROR:
            return "CUFFT_INTERNAL_ERROR";
        case CUFFT_EXEC_FAILED:
            return "CUFFT_EXEC_FAILED";
        case CUFFT_SETUP_FAILED:
            return "CUFFT_SETUP_FAILED";
        case CUFFT_INVALID_SIZE:
            return "CUFFT_INVALID_SIZE";
        case CUFFT_UNALIGNED_DATA:
            return "CUFFT_UNALIGNED_DATA";
        case CUFFT_INCOMPLETE_PARAMETER_LIST:
            return "CUFFT_INCOMPLETE_PARAMETER_LIST";
        case CUFFT_INVALID_DEVICE:
            return "CUFFT_INVALID_DEVICE";
        case CUFFT_PARSE_ERROR:
            return "CUFFT_PARSE_ERROR";
        case CUFFT_NO_WORKSPACE:
            return "CUFFT_NO_WORKSPACE";
        case CUFFT_NOT_IMPLEMENTED:
            return "CUFFT_NOT_IMPLEMENTED";
        case CUFFT_LICENSE_ERROR:
            return "CUFFT_LICENSE_ERROR";
        case CUFFT_NOT_SUPPORTED:
            return "CUFFT_NOT_SUPPORTED";
        default:
            return "unrecognized error code";
        }
    }

    const char* cufftGetErrorStringImpl(int errCode) {
        cufftResult_t errCodeEnum = static_cast<cufftResult_t>(errCode);

        switch (errCodeEnum) {
        case CUFFT_SUCCESS:
            return "the cuFFT operation was successful";
        case CUFFT_INVALID_PLAN:
            return "cuFFT was passed an invalid plan handle";
        case CUFFT_ALLOC_FAILED:
            return "cuFFT failed to allocate GPU or CPU memory";
        case CUFFT_INVALID_TYPE:
            return "no longer used";
        case CUFFT_INVALID_VALUE:
            return "user specified an invalid pointer or parameter";
        case CUFFT_INTERNAL_ERROR:
            return "driver or internal cuFFT library error";
        case CUFFT_EXEC_FAILED:
            return "failed to execute an FFT on the GPU";
        case CUFFT_SETUP_FAILED:
            return "the cuFFT library failed to initialize";
        case CUFFT_INVALID_SIZE:
            return "user specified an invalid transform size";
        case CUFFT_UNALIGNED_DATA:
            return "no longer used";
        case CUFFT_INCOMPLETE_PARAMETER_LIST:
            return "missing parameters in call";
        case CUFFT_INVALID_DEVICE:
            return "execution of a plan was on different GPU than plan creation";
        case CUFFT_PARSE_ERROR:
            return "internal plan database error";
        case CUFFT_NO_WORKSPACE:
            return "no workspace has been provided prior to plan execution";
        case CUFFT_NOT_IMPLEMENTED:
            return "function does not implement functionality for parameters given";
        case CUFFT_LICENSE_ERROR:
            return "used in previous versions";
        case CUFFT_NOT_SUPPORTED:
            return "operation is not supported for parameters given";
        default:
            return "unrecognized error code";
        }
    }
}


void cublasGetErrorName(int errCode, const char** errName) {
    *errName = cublasGetErrorNameImpl(errCode);
}

void cublasGetErrorString(int errCode, const char** errString) {
    *errString = cublasGetErrorStringImpl(errCode);
}

void cusolverGetErrorName(int errCode, const char** errName) {
    *errName = cusolverGetErrorNameImpl(errCode);
}

void cusolverGetErrorString(int errCode, const char** errString) {
    *errString = cusolverGetErrorStringImpl(errCode);
}

void cufftGetErrorName(int errCode, const char** errName) {
    *errName = cufftGetErrorNameImpl(errCode);
}

void cufftGetErrorString(int errCode, const char** errString) {
    *errString = cufftGetErrorStringImpl(errCode);
}
