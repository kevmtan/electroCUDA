//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp_types.h
//
// Code generation for function 'ec_wt_fp'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"
#include <cstddef>

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

struct emxArray_creal32_T {
  creal32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct cell_wrap_0 {
  emxArray_creal32_T *f1;
};

struct emxArray_cell_wrap_0 {
  cell_wrap_0 *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_real_T {
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

namespace coder {
struct cwtfilterbank {
  real_T VoicesPerOctave;
  char_T Wavelet[5];
  real_T SamplingFrequency;
  real_T SignalLength;
  real_T FrequencyLimits[2];
  real_T TimeBandwidth;
  real_T WaveletParameters[2];
  char_T Boundary[10];
  emxArray_real_T *Scales;
  emxArray_real_T *PsiDFT;
  emxArray_real_T *WaveletCenterFrequencies;
  real32_T sigvar;
  real_T Beta;
  real_T Gamma;
  real_T SignalPad;
  emxArray_real_T *Omega;
  real_T CutOff;
};

} // namespace coder
struct emxArray_uint32_T {
  uint32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
struct ResampleParser {
  int32_T dim;
  real_T p;
  real_T q;
  real_T inputSize[2];
  boolean_T isRowVectorInput;
  emxArray_real32_T *filter;
  emxArray_real32_T *filterWithPadding;
  real_T filterDelay;
  emxArray_creal32_T *x;
};

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder
struct emxArray_int32_T {
  int32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_ptrdiff_t {
  ptrdiff_t *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_char_T {
  char_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

// End of code generation (ec_wt_fp_types.h)
