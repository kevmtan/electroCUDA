//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_wtcc_api.cu
//
// Code generation for function '_coder_ec_wtcc_api'
//

// Include files
#include "_coder_ec_wtcc_api.h"
#include "ec_wtcc.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo kg_emlrtRTEI{
    1,                    // lineNo
    1,                    // colNo
    "_coder_ec_wtcc_api", // fName
    ""                    // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_uint16_T *ret);

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr,
                                   const char_T *identifier))[2];

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static real_T (*d_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2];

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_uint16_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_uint16_T *y);

static const mxArray *emlrt_marshallOut(const emxArray_cell_wrap_0 *u);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
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

static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_uint16_T *ret)
{
  static const int32_T dims[2]{65534, 2};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{true, false};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "uint16", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_uint16_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<uint16_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr,
                                   const char_T *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2]
{
  real_T(*y)[2];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*d_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2]
{
  static const int32_T dims[2]{1, 2};
  real_T(*ret)[2];
  int32_T iv[2];
  boolean_T bv[2]{false, false};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (real_T(*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
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
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_uint16_T *y)
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
                             emxArray_uint16_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const emxArray_cell_wrap_0 *u)
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  int32_T iv[2];
  int32_T n;
  real32_T *pData;
  y = nullptr;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(2, &u->size[0]));
  n = u->size[1];
  for (int32_T i{0}; i < n; i++) {
    int32_T i1;
    int32_T loopUpperBound;
    b_y = nullptr;
    iv[0] = u->data[i].f1->size[0];
    iv[1] = u->data[i].f1->size[1];
    m = emlrtCreateNumericArray(2, &iv[0], mxSINGLE_CLASS, mxREAL);
    pData = static_cast<real32_T *>(emlrtMxGetData(m));
    i1 = 0;
    loopUpperBound = u->data[i].f1->size[1];
    for (int32_T b_i{0}; b_i < loopUpperBound; b_i++) {
      int32_T b_loopUpperBound;
      b_loopUpperBound = u->data[i].f1->size[0];
      for (int32_T c_i{0}; c_i < b_loopUpperBound; c_i++) {
        pData[i1 + c_i] =
            u->data[i].f1->data[c_i + u->data[i].f1->size[0] * b_i];
      }
      if (u->data[i].f1->size[0] - 1 >= 0) {
        i1 += u->data[i].f1->size[0];
      }
    }
    emlrtAssign(&b_y, m);
    emlrtSetCell(y, i, b_y);
  }
  return y;
}

void ec_wtcc_api(const mxArray *const prhs[6], int32_T nlhs,
                 const mxArray *plhs[2])
{
  emxArray_cell_wrap_0 *xx;
  emxArray_cell_wrap_0 *yy;
  emxArray_real32_T *x;
  emxArray_uint16_T *c;
  const mxArray *prhs_copy_idx_3;
  const mxArray *prhs_copy_idx_5;
  real_T(*ds)[2];
  real_T(*fLims)[2];
  real_T fVoices;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_3 = emlrtProtectR2012b(prhs[3], 3, false, -1);
  prhs_copy_idx_5 = emlrtProtectR2012b(prhs[5], 5, false, -1);
  // Marshall function inputs
  emxInit_real32_T(&x, 2, &kg_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  emxInit_uint16_T(&c, 2, &kg_emlrtRTEI, true);
  c->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[1]), "c", c);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[2]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_3), "fLims");
  fVoices = emlrt_marshallIn(emlrtAliasP(prhs[4]), "fVoices");
  ds = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_5), "ds");
  // Invoke the target function
  emxInit_cell_wrap_0(&xx, 2, &kg_emlrtRTEI, true);
  emxInit_cell_wrap_0(&yy, 2, &kg_emlrtRTEI, true);
  ec_wtcc(x, c, fs, *fLims, fVoices, *ds, xx, yy);
  emxFree_real32_T(&x);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(xx);
  emxFree_cell_wrap_0(&xx);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(yy);
  }
  emxFree_cell_wrap_0(&yy);
  emxFree_uint16_T(&c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_ec_wtcc_api.cu)
