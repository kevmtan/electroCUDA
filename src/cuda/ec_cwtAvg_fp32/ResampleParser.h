//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ResampleParser.h
//
// Code generation for function 'ResampleParser'
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

// Function Declarations
namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
void c_ResampleParser_createFilterAn(const real_T *obj_p, const real_T *obj_q,
                                     emxArray_real32_T *obj_filter,
                                     emxArray_real32_T *obj_filterWithPadding,
                                     real_T *obj_filterDelay,
                                     const emxArray_real32_T *obj_x);

}
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (ResampleParser.h)
