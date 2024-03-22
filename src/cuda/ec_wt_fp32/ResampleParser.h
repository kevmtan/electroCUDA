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
struct emxArray_creal32_T;

namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
struct ResampleParser;

}
} // namespace internal
} // namespace b_signal
} // namespace coder

// Function Declarations
namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
void c_ResampleParser_createFilterAn(int32_T obj_dim, real_T obj_p,
                                     real_T obj_q,
                                     const real_T obj_inputSize[2],
                                     boolean_T obj_isRowVectorInput,
                                     const emxArray_creal32_T *obj_x,
                                     ResampleParser *obj);

}
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (ResampleParser.h)
