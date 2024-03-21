//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtcc_types.h
//
// Code generation for function 'ec_wtcc'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Type Definitions
struct emxArray_real32_T {
  real32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct cell_wrap_0 {
  emxArray_real32_T *f1;
};

struct b_ec_wtcc {
  real_T cpu_x_data[9735];
  real_T cpu_xt_data[9735];
  real_T cpu_fx_data[9735];
  real_T cpu_dv2_data[9735];
  real_T b_cpu_fx_data[9735];
};

struct ec_wtccStackData {
  b_ec_wtcc f0;
};

// End of code generation (ec_wtcc_types.h)
