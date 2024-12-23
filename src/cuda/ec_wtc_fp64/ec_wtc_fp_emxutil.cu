//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtc_fp_emxutil.cu
//
// Code generation for function 'ec_wtc_fp_emxutil'
//

// Include files
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <algorithm>
#include <cstddef>

// Function Definitions
int64_T b_computeEndIdx(int64_T start, int64_T end, int64_T stride)
{
  int64_T newEnd;
  nvtxRangePushA("#fcn#b_computeEndIdx#" MW_AT_LOCATION);
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  nvtxRangePop();
  return newEnd;
}

void emxEnsureCapacity_cell_wrap_0(emxArray_cell_wrap_0 *emxArray,
                                   int32_T oldNumel,
                                   const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_cell_wrap_0#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_cell_wrap_0_loop_0", __LINE__,
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
        "#loop#emxEnsureCapacity_cell_wrap_0_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(cell_wrap_0));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<cell_wrap_0 *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<cell_wrap_0 *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
  if (oldNumel > newNumel) {
    nvtxMarkA("#emxTrim_cell_wrap_0#" MW_AT_LINE);
    emxTrim_cell_wrap_0(emxArray, newNumel, oldNumel);
  } else if (oldNumel < newNumel) {
    nvtxMarkA("#emxExpand_cell_wrap_0#" MW_AT_LINE);
    emxExpand_cell_wrap_0(emxArray, oldNumel, newNumel, srcLocation);
  }
  nvtxRangePop();
}

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

void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_creal_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_creal_T_loop_0", __LINE__,
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
    nvtxRangePushA("#loop#emxEnsureCapacity_creal_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(creal_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<creal_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<creal_T *>(newData);
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

void emxEnsureCapacity_uint16_T(emxArray_uint16_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  nvtxRangePushA("#fcn#emxEnsureCapacity_uint16_T#" MW_AT_LOCATION);
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  profileLoopStart("emxEnsureCapacity_uint16_T_loop_0", __LINE__,
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
    nvtxRangePushA("#loop#emxEnsureCapacity_uint16_T_whileloop_0##" MW_AT_LINE);
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    nvtxRangePop();
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(uint16_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<uint16_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<uint16_T *>(newData);
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

void emxExpand_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T fromIndex,
                           int32_T toIndex, const emlrtRTEInfo *srcLocation)
{
  int64_T b;
  nvtxRangePushA("#fcn#emxExpand_cell_wrap_0#" MW_AT_LOCATION);
  nvtxMarkA("#b_computeEndIdx#" MW_AT_LINE);
  b = b_computeEndIdx(static_cast<int64_T>(fromIndex),
                      static_cast<int64_T>(toIndex - 1), 1L);
  profileLoopStart("emxExpand_cell_wrap_0_loop_0", __LINE__, b + 1L, "");
  for (int64_T i{0L}; i <= b; i++) {
    nvtxMarkA("#emxInitStruct_cell_wrap_0#" MW_AT_LINE);
    emxInitStruct_cell_wrap_0(
        &emxArray->data[static_cast<int32_T>(fromIndex + i)], srcLocation,
        false);
  }
  profileLoopEnd();
  nvtxRangePop();
}

void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct)
{
  nvtxRangePushA("#fcn#emxFreeStruct_cell_wrap_0#" MW_AT_LOCATION);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&pStruct->f1);
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

void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_cell_wrap_0#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_cell_wrap_0 *>(nullptr)) {
    if ((*pEmxArray)->data != static_cast<cell_wrap_0 *>(nullptr)) {
      int32_T numEl;
      numEl = 1;
      profileLoopStart("emxFree_cell_wrap_0_loop_0", __LINE__,
                       ((*pEmxArray)->numDimensions - 1) + 1, "");
      for (int32_T i{0}; i < (*pEmxArray)->numDimensions; i++) {
        numEl *= (*pEmxArray)->size[i];
      }
      profileLoopEnd();
      profileLoopStart("emxFree_cell_wrap_0_loop_1", __LINE__, (numEl - 1) + 1,
                       "");
      for (int32_T i{0}; i < numEl; i++) {
        nvtxMarkA("#emxFreeStruct_cell_wrap_0#" MW_AT_LINE);
        emxFreeStruct_cell_wrap_0(&(*pEmxArray)->data[i]);
      }
      profileLoopEnd();
      if ((*pEmxArray)->canFreeData) {
        emlrtFreeMex((*pEmxArray)->data);
      }
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_cell_wrap_0 *>(nullptr);
  }
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

void emxFree_creal_T(emxArray_creal_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_creal_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_creal_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<creal_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_creal_T *>(nullptr);
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

void emxFree_uint16_T(emxArray_uint16_T **pEmxArray)
{
  nvtxRangePushA("#fcn#emxFree_uint16_T#" MW_AT_LOCATION);
  if (*pEmxArray != static_cast<emxArray_uint16_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<uint16_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_uint16_T *>(nullptr);
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

void emxInitStruct_cell_wrap_0(cell_wrap_0 *pStruct,
                               const emlrtRTEInfo *srcLocation,
                               boolean_T doPush)
{
  nvtxRangePushA("#fcn#emxInitStruct_cell_wrap_0#" MW_AT_LOCATION);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&pStruct->f1, 2, srcLocation, doPush);
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

void emxInit_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray,
                         int32_T numDimensions, const emlrtRTEInfo *srcLocation,
                         boolean_T doPush)
{
  emxArray_cell_wrap_0 *emxArray;
  nvtxRangePushA("#fcn#emxInit_cell_wrap_0#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_cell_wrap_0 *>(
      emlrtMallocEmxArray(sizeof(emxArray_cell_wrap_0)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray,
        (void *)&emxFree_cell_wrap_0, nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<cell_wrap_0 *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_cell_wrap_0_loop_0", __LINE__,
                   (numDimensions - 1) + 1, "");
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
  profileLoopEnd();
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

void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_creal_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_creal_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_creal_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_creal_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_creal_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<creal_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_creal_T_loop_0", __LINE__, (numDimensions - 1) + 1,
                   "");
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

void emxInit_uint16_T(emxArray_uint16_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_uint16_T *emxArray;
  nvtxRangePushA("#fcn#emxInit_uint16_T#" MW_AT_LOCATION);
  *pEmxArray = static_cast<emxArray_uint16_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_uint16_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_uint16_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<uint16_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  profileLoopStart("emxInit_uint16_T_loop_0", __LINE__, (numDimensions - 1) + 1,
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

void emxTrim_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T fromIndex,
                         int32_T toIndex)
{
  int64_T b;
  nvtxRangePushA("#fcn#emxTrim_cell_wrap_0#" MW_AT_LOCATION);
  nvtxMarkA("#b_computeEndIdx#" MW_AT_LINE);
  b = b_computeEndIdx(static_cast<int64_T>(fromIndex),
                      static_cast<int64_T>(toIndex - 1), 1L);
  profileLoopStart("emxTrim_cell_wrap_0_loop_0", __LINE__, b + 1L, "");
  for (int64_T i{0L}; i <= b; i++) {
    nvtxMarkA("#emxFreeStruct_cell_wrap_0#" MW_AT_LINE);
    emxFreeStruct_cell_wrap_0(
        &emxArray->data[static_cast<int32_T>(fromIndex + i)]);
  }
  profileLoopEnd();
  nvtxRangePop();
}

// End of code generation (ec_wtc_fp_emxutil.cu)
