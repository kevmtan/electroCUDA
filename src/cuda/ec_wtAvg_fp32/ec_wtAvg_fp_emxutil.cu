//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtAvg_fp_emxutil.cu
//
// Code generation for function 'ec_wtAvg_fp_emxutil'
//

// Include files
#include "ec_wtAvg_fp_emxutil.h"
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <algorithm>

// Function Definitions
void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_char_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_char_T_loop_0", __LINE__,
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
    nvtxRangePushA("#loop#emxEnsureCapacity_char_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(char_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<char_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<char_T *>(newData);
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

void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_uint32_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_uint32_T_loop_0", __LINE__,
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
    nvtxRangePushA("#loop#emxEnsureCapacity_uint32_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(uint32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<uint32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<uint32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  nvtxRangePop();
}

void emxFreeStruct_cwtfilterbank(coder::cwtfilterbank *pStruct)
{
  nvtxRangePushA("#fcn#emxFreeStruct_cwtfilterbank#" MW_AT_LOCATION);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&pStruct->Scales);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&pStruct->PsiDFT);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&pStruct->WaveletCenterFrequencies);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&pStruct->Omega);
  nvtxRangePop();
}

void emxFree_char_T(emxArray_char_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_char_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_char_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<char_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_char_T *>(nullptr);
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

void emxFree_uint32_T(emxArray_uint32_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_uint32_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_uint32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<uint32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_uint32_T *>(nullptr);
  }
  nvtxRangePop();
}

void emxInitStruct_cwtfilterbank(coder::cwtfilterbank *pStruct,
                                 const emlrtRTEInfo *srcLocation,
                                 boolean_T doPush)
{
  nvtxRangePushA("#fcn#emxInitStruct_cwtfilterbank#" MW_AT_LOCATION);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&pStruct->Scales, 2, srcLocation, doPush);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&pStruct->PsiDFT, 2, srcLocation, doPush);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&pStruct->WaveletCenterFrequencies, 1, srcLocation, doPush);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&pStruct->Omega, 2, srcLocation, doPush);
  nvtxRangePop();
}

void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_char_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_char_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_char_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_char_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_char_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<char_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_char_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
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

void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_uint32_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_uint32_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_uint32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_uint32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_uint32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<uint32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_uint32_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
  nvtxRangePop();
}

// End of code generation (ec_wtAvg_fp_emxutil.cu)
