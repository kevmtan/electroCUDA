//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_filtfilt1_api.cu
//
// Code generation for function '_coder_ec_filtfilt1_api'
//

// Include files
#include "_coder_ec_filtfilt1_api.h"
#include "ec_filtfilt1.h"
#include "ec_filtfilt1_data.h"
#include "ec_filtfilt1_emxutil.h"
#include "ec_filtfilt1_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo p_emlrtRTEI{
    1,                         // lineNo
    1,                         // colNo
    "_coder_ec_filtfilt1_api", // fName
    ""                         // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *b_nullptr,
                               const char_T *identifier, emxArray_real32_T *y);

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y);

static real32_T b_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static real32_T emlrt_marshallIn(const mxArray *b_nullptr,
                                 const char_T *identifier);

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *b_nullptr,
                               const char_T *identifier, emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y)
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real32_T b_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real32_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2]{-1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{true, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real32_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[1]{-1};
  int32_T iv[1];
  int32_T i;
  boolean_T bv[1]{true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 1U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0];
  i = ret->size[0];
  ret->size[0] = iv[0];
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real32_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real32_T emlrt_marshallIn(const mxArray *b_nullptr,
                                 const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real32_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

void ec_filtfilt1_api(const mxArray *const prhs[6], const mxArray *plhs[1])
{
  emxArray_real32_T *a;
  emxArray_real32_T *b;
  emxArray_real32_T *x;
  emxArray_real32_T *y;
  emxArray_real32_T *z;
  real32_T L;
  real32_T nf;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  // Marshall function inputs
  emxInit_real32_T(&x, 2, &p_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  emxInit_real32_T(&b, 1, &p_emlrtRTEI, true);
  b->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "b", b);
  emxInit_real32_T(&a, 1, &p_emlrtRTEI, true);
  a->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[2]), "a", a);
  emxInit_real32_T(&z, 1, &p_emlrtRTEI, true);
  z->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[3]), "z", z);
  nf = emlrt_marshallIn(emlrtAliasP(prhs[4]), "nf");
  L = emlrt_marshallIn(emlrtAliasP(prhs[5]), "L");
  // Invoke the target function
  emxInit_real32_T(&y, 2, &p_emlrtRTEI, true);
  ec_filtfilt1(x, b, a, z, nf, L, y);
  emxFree_real32_T(&z);
  emxFree_real32_T(&a);
  emxFree_real32_T(&b);
  emxFree_real32_T(&x);
  // Marshall function outputs
  y->canFreeData = false;
  plhs[0] = emlrt_marshallOut(y);
  emxFree_real32_T(&y);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_ec_filtfilt1_api.cu)
