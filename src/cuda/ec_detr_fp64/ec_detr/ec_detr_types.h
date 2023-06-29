//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
//
// ec_detr_types.h
//
// Code generation for function 'ec_detr'
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

// End of code generation (ec_detr_types.h)
