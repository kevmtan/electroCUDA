//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_types.h
//
// Code generation for function 'ec_filtfilt'
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
struct emxArray_real_T {
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct b_ec_filtfilt {
  real_T zi_data[134217727];
  real_T outBuff_data[134217727];
  int32_T counts_data[134217727];
};

struct ec_filtfiltStackData {
  b_ec_filtfilt f0;
};

// End of code generation (ec_filtfilt_types.h)
