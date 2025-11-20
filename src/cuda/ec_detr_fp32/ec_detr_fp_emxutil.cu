//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_fp_emxutil.cu
//
// Code generation for function 'ec_detr_fp_emxutil'
//

// Include files
#include "ec_detr_fp_emxutil.h"
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <algorithm>
#include <cstddef>

// Function Definitions
void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_boolean_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_boolean_T_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA(
        "#loop#emxEnsureCapacity_boolean_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(boolean_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<boolean_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<boolean_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_creal32_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_creal32_T_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA(
        "#loop#emxEnsureCapacity_creal32_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(creal32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<creal32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<creal32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_int32_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_int32_T_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA("#loop#emxEnsureCapacity_int32_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(int32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<int32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<int32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_ptrdiff_t#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_ptrdiff_t_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA(
        "#loop#emxEnsureCapacity_ptrdiff_t_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(ptrdiff_t));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<ptrdiff_t *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<ptrdiff_t *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_real32_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_real32_T_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA("#loop#emxEnsureCapacity_real32_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(real32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<real32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<real32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_real_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_real_T_loop_0", __LINE__,
                   (emxArray->numDimensions - 1) + 1, "");
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  profileLoopEnd();
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    nvtxRangePushA("#loop#emxEnsureCapacity_real_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(real_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<real_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<real_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxFree_boolean_T(emxArray_boolean_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_boolean_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_boolean_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<boolean_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_boolean_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxFree_creal32_T(emxArray_creal32_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_creal32_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_creal32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<creal32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_creal32_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxFree_int32_T(emxArray_int32_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_int32_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_int32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<int32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_int32_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_ptrdiff_t#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_ptrdiff_t *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<ptrdiff_t *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_ptrdiff_t *>(nullptr);
  }
  nvtxRangePop();
}

void emxFree_real32_T(emxArray_real32_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_real32_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_real32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<real32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_real32_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxFree_real_T(emxArray_real_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_real_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_real_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<real_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_real_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_boolean_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_boolean_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_boolean_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_boolean_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray,
        (void *)&emxFree_boolean_T, nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<boolean_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_boolean_T_loop_0", __LINE__,
                   (numDimensions - 1) + 1, "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_creal32_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_creal32_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_creal32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_creal32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray,
        (void *)&emxFree_creal32_T, nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<creal32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_creal32_T_loop_0", __LINE__,
                   (numDimensions - 1) + 1, "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_int32_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_int32_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_int32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_int32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_int32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<int32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_int32_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_ptrdiff_t *emxArray;
  nvtxRangePushA("#fcn#emxInit_ptrdiff_t#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_ptrdiff_t *>(
      emlrtMallocEmxArray(sizeof(emxArray_ptrdiff_t)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray,
        (void *)&emxFree_ptrdiff_t, nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<ptrdiff_t *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_ptrdiff_t_loop_0", __LINE__,
                   (numDimensions - 1) + 1, "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real32_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_real32_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_real32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_real32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_real32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<real32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_real32_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_real_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_real_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_real_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_real_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<real_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_real_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

// End of code generation (ec_detr_fp_emxutil.cu)
