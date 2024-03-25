//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_wt_fp_api.cu
//
// Code generation for function '_coder_ec_wt_fp_api'
//

// Include files
#include "_coder_ec_wt_fp_api.h"
#include "ec_wt_fp.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtRTEInfo ee_emlrtRTEI{
    1,                     // lineNo
    1,                     // colNo
    "_coder_ec_wt_fp_api", // fName
    ""                     // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr,
                                   const char_T *identifier))[2];

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static boolean_T c_emlrt_marshallIn(const mxArray *b_nullptr,
                                    const char_T *identifier);

static boolean_T c_emlrt_marshallIn(const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static real_T (*e_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2];

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);

static boolean_T f_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2]{-1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{true, true};
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real32_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
  nvtxRangePop();
}

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr,
                                   const char_T *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2];
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  y = b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  nvtxRangePop();
  return y;
}

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2]
{
  real_T(*y)[2];
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#e_emlrt_marshallIn#" MW_AT_LINE);
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  nvtxRangePop();
  return y;
}

static boolean_T c_emlrt_marshallIn(const mxArray *b_nullptr,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  boolean_T y;
  nvtxRangePushA("#fcn#c_emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#c_emlrt_marshallIn#" MW_AT_LINE);
  y = c_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  nvtxRangePop();
  return y;
}

static boolean_T c_emlrt_marshallIn(const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  nvtxRangePushA("#fcn#c_emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#f_emlrt_marshallIn#" MW_AT_LINE);
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  nvtxRangePop();
  return y;
}

static real_T (*e_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2]
{
  static const int32_T dims[2]{1, 2};
  real_T(*ret)[2];
  int32_T iv[2];
  boolean_T bv[2]{false, false};
  nvtxRangePushA("#fcn#e_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (real_T(*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  nvtxRangePop();
  return ret;
}

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
  nvtxRangePop();
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y)
{
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
  nvtxRangePop();
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  static const int32_T iv[3]{0, 0, 0};
  const mxArray *m;
  const mxArray *y;
  nvtxRangePushA("#fcn#emlrt_marshallOut#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateNumericArray(3, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 3);
  emlrtAssign(&y, m);
  nvtxRangePop();
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[1]{0};
  const mxArray *m;
  const mxArray *y;
  nvtxRangePushA("#fcn#emlrt_marshallOut#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateNumericArray(1, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 1);
  emlrtAssign(&y, m);
  nvtxRangePop();
  return y;
}

static boolean_T f_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  boolean_T ret;
  nvtxRangePushA("#fcn#f_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  nvtxRangePop();
  return ret;
}

void ec_wt_fp_api(const mxArray *const prhs[7], int32_T nlhs,
                  const mxArray *plhs[2])
{
  emxArray_real32_T *x;
  emxArray_real32_T *y;
  emxArray_real_T *freqs;
  const mxArray *prhs_copy_idx_2;
  real_T(*fLims)[2];
  real_T ds;
  real_T fVoices;
  real_T fs;
  boolean_T doAvg;
  boolean_T doPwr;
  nvtxRangePushA("#fcn#ec_wt_fp_api#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);
  // Marshall function inputs
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&x, 2, &ee_emlrtRTEI, true);
  x->canFreeData = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  fVoices = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fVoices");
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  ds = emlrt_marshallIn(emlrtAliasP(prhs[4]), "ds");
  nvtxMarkA("#c_emlrt_marshallIn#" MW_AT_LINE);
  doAvg = c_emlrt_marshallIn(emlrtAliasP(prhs[5]), "doAvg");
  nvtxMarkA("#c_emlrt_marshallIn#" MW_AT_LINE);
  doPwr = c_emlrt_marshallIn(emlrtAliasP(prhs[6]), "doPwr");
  // Invoke the target function
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&y, 3, &ee_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&freqs, 1, &ee_emlrtRTEI, true);
  nvtxMarkA("#ec_wt_fp#" MW_AT_LINE);
  ec_wt_fp(x, fs, *fLims, fVoices, ds, doAvg, doPwr, y, freqs);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&x);
  // Marshall function outputs
  y->canFreeData = false;
  nvtxMarkA("#emlrt_marshallOut#" MW_AT_LINE);
  plhs[0] = emlrt_marshallOut(y);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&y);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    nvtxMarkA("#emlrt_marshallOut#" MW_AT_LINE);
    plhs[1] = emlrt_marshallOut(freqs);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

// End of code generation (_coder_ec_wt_fp_api.cu)
