//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle_mexutil.h
//
// Code generation for function 'ec_CWTsingle_mexutil'
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

// Function Declarations
real_T d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId);

real_T emlrt_marshallIn(const mxArray *a__output_of_length_,
                        const char_T *identifier);

real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId);

// End of code generation (ec_CWTsingle_mexutil.h)
