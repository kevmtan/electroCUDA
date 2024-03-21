//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwt_types.h
//
// Code generation for function 'ec_cwt'
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

struct emxArray_cell_wrap_0_1x65534 {
  cell_wrap_0 data[65534];
  int32_T size[2];
};

struct emxArray_real_T {
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct b_ec_cwt {
  real_T cpu_x_data[9735];
  real_T cpu_xt_data[9735];
  real_T cpu_fx_data[9735];
  real_T cpu_dv4_data[9735];
};

struct ec_cwt_api {
  emxArray_cell_wrap_0_1x65534 y;
};

struct ec_cwtStackData {
  b_ec_cwt f0;
  ec_cwt_api f1;
};

// End of code generation (ec_cwt_types.h)
