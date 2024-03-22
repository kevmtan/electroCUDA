//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_emxutil.cu
//
// Code generation for function 'ec_detr_emxutil'
//

// Include files
#include "ec_detr_emxutil.h"
#include "ec_detr_data.h"
#include "ec_detr_types.h"
#include "rt_nonfinite.h"
#include <algorithm>
#include <cstddef>

// Function Definitions
void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
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
}

void emxFree_boolean_T(emxArray_boolean_T **pEmxArray)
{
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
}

void emxFree_creal32_T(emxArray_creal32_T **pEmxArray)
{
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
}

void emxFree_int32_T(emxArray_int32_T **pEmxArray)
{
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
}

void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray)
{
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
}

void emxFree_real32_T(emxArray_real32_T **pEmxArray)
{
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
}

void emxFree_real_T(emxArray_real_T **pEmxArray)
{
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
}

void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_boolean_T *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_creal32_T *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_int32_T *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_ptrdiff_t *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real32_T *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real_T *emxArray;
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
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

// End of code generation (ec_detr_emxutil.cu)
