//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwtfilterbank.h
//
// Code generation for function 'cwtfilterbank'
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

// Function Declarations
namespace coder {
cwtfilterbank *cwtfilterbank_cwtfilterbank(cwtfilterbank *self,
                                           real_T varargin_2,
                                           const real_T varargin_6[2],
                                           real_T varargin_8,
                                           real_T varargin_10);

}

// End of code generation (cwtfilterbank.h)
