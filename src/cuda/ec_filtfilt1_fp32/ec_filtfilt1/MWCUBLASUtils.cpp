// Copyright 2020 The MathWorks, Inc.

#include "MWCUBLASUtils.hpp"

static cublasHandle_t cublasGlobalHandle = NULL;

cublasHandle_t getCublasGlobalHandle() {
  return cublasGlobalHandle;
}

void cublasEnsureInitialization(cublasPointerMode_t pointerMode) {
    if (cublasGlobalHandle == NULL) {
        cublasCreate(&cublasGlobalHandle);
        cublasSetPointerMode(cublasGlobalHandle, pointerMode);
    }
}

void cublasEnsureDestruction(void) {
    if (cublasGlobalHandle != NULL) {
        cublasDestroy(cublasGlobalHandle);
        cublasGlobalHandle = NULL;
    }
}
