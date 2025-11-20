//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_internal_types.h
//
// Code generation for function 'filtfilt'
//

#pragma once

// Include files
#include "filtfilt_types.h"
#include "rtwtypes.h"
#include "emlrt.h"

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Type Definitions
struct rtBoundsCheckInfo {
  int32_T iFirst;
  int32_T iLast;
  int32_T lineNo;
  int32_T colNo;
  const char_T *aName;
  const char_T *fName;
  const char_T *pName;
  int32_T checkKind;
};

struct rtDesignRangeCheckInfo {
  int32_T lineNo;
  int32_T colNo;
  const char_T *fName;
  const char_T *pName;
};

// End of code generation (filtfilt_internal_types.h)
