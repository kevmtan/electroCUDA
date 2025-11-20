//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// eig.h
//
// Code generation for function 'eig'
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
struct emxArray_real32_T;

struct emxArray_creal32_T;

// Function Declarations
namespace coder {
void eig(const emxArray_real32_T *A, emxArray_creal32_T *V,
         emxArray_creal32_T *D);

}

// End of code generation (eig.h)
