//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// scaleSpectrum.h
//
// Code generation for function 'scaleSpectrum'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Type Declarations
namespace coder {
struct cwtfilterbank;

}
struct emxArray_real_T;

// Function Declarations
namespace coder {
void cwtfilterbank_scaleSpectrum(cwtfilterbank *self, const emxArray_real_T *x,
                                 emxArray_real_T *cpu_savgp,
                                 boolean_T *savgp_outdatedOnCpu,
                                 emxArray_real_T *gpu_savgp,
                                 boolean_T *savgp_outdatedOnGpu);

}

// End of code generation (scaleSpectrum.h)
