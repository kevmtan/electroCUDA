//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_cwtAvg_api.cu
//
// Code generation for function '_coder_ec_cwtAvg_api'
//

// Include files
#include "_coder_ec_cwtAvg_api.h"
#include "ec_cwtAvg.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo nf_emlrtRTEI{
    1,                      // lineNo
    1,                      // colNo
    "_coder_ec_cwtAvg_api", // fName
    ""                      // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret);

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr,
                                   const char_T *identifier))[2];

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static real_T (*d_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2];

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real_T *y);

static const mxArray *emlrt_marshallOut(const emxArray_cell_wrap_0 *u);

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret)
{
  static const int32_T dims[2]{-1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{true, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real_T *>(emlrtMxGetData(src));
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
                             emxArray_real_T *y)
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
                             emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const emxArray_cell_wrap_0 *u)
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T iv[2];
  int32_T n;
  y = nullptr;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(2, &u->size[0]));
  n = u->size[1];
  for (int32_T i{0}; i < n; i++) {
    int32_T b_i;
    int32_T i1;
    b_y = nullptr;
    iv[0] = u->data[i].f1->size[0];
    iv[1] = u->data[i].f1->size[1];
    m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
    pData = emlrtMxGetPr(m);
    i1 = 0;
    b_i = 0;
    while (b_i < u->data[i].f1->size[1]) {
      int32_T loopUpperBound;
      loopUpperBound = u->data[i].f1->size[0];
      for (b_i = 0; b_i < loopUpperBound; b_i++) {
        pData[i1 + b_i] = u->data[i].f1->data[b_i];
      }
      if (u->data[i].f1->size[0] - 1 >= 0) {
        i1 += u->data[i].f1->size[0];
      }
      b_i = 1;
    }
    emlrtAssign(&b_y, m);
    emlrtSetCell(y, i, b_y);
  }
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[1]{0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(1, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 1);
  emlrtAssign(&y, m);
  return y;
}

void ec_cwtAvg_api(const mxArray *const prhs[5], int32_T nlhs,
                   const mxArray *plhs[2])
{
  emxArray_cell_wrap_0 *y;
  emxArray_real_T *freqs;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_2;
  const mxArray *prhs_copy_idx_4;
  real_T(*ds)[2];
  real_T(*fLims)[2];
  real_T fVoices;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);
  prhs_copy_idx_4 = emlrtProtectR2012b(prhs[4], 4, false, -1);
  // Marshall function inputs
  emxInit_real_T(&x, 2, &nf_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fVoices = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fVoices");
  ds = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_4), "ds");
  // Invoke the target function
  emxInit_cell_wrap_0(&y, 2, &nf_emlrtRTEI, true);
  emxInit_real_T(&freqs, 1, &nf_emlrtRTEI, true);
  ec_cwtAvg(x, fs, *fLims, fVoices, *ds, y, freqs);
  emxFree_real_T(&x);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(y);
  emxFree_cell_wrap_0(&y);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = emlrt_marshallOut(freqs);
  }
  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_ec_cwtAvg_api.cu)
