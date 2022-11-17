//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_CWTdouble_api.cu
//
// Code generation for function '_coder_ec_CWTdouble_api'
//

// Include files
#include "_coder_ec_CWTdouble_api.h"
#include "ec_CWTdouble.h"
#include "ec_CWTdouble_data.h"
#include "ec_CWTdouble_emxutil.h"
#include "ec_CWTdouble_mexutil.h"
#include "ec_CWTdouble_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo v_emlrtRTEI{
    1,                         // lineNo
    1,                         // colNo
    "_coder_ec_CWTdouble_api", // fName
    ""                         // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret);

static real_T (*b_emlrt_marshallIn(const mxArray *freqLims,
                                   const char_T *identifier))[2];

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);

static boolean_T c_emlrt_marshallIn(const mxArray *doAvg,
                                    const char_T *identifier);

static boolean_T c_emlrt_marshallIn(const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static real_T (*e_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2];

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
                             emxArray_real_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real_T *y);

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);

static boolean_T f_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret)
{
  static const int32_T dims[1]{-1};
  int32_T iv[1];
  int32_T i;
  const boolean_T bv[1]{true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0];
  i = ret->size[0];
  ret->size[0] = iv[0];
  emxEnsureCapacity_real_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static real_T (*b_emlrt_marshallIn(const mxArray *freqLims,
                                   const char_T *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(freqLims), &thisId);
  emlrtDestroyArray(&freqLims);
  return y;
}

static real_T (*b_emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2]
{
  real_T(*y)[2];
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
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

static boolean_T c_emlrt_marshallIn(const mxArray *doAvg,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  boolean_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = c_emlrt_marshallIn(emlrtAlias(doAvg), &thisId);
  emlrtDestroyArray(&doAvg);
  return y;
}

static boolean_T c_emlrt_marshallIn(const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2]
{
  static const int32_T dims[2]{1, 2};
  real_T(*ret)[2];
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  ret = (real_T(*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
                             emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(x), &thisId, y);
  emlrtDestroyArray(&x);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static boolean_T f_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  boolean_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

void ec_CWTdouble_api(const mxArray *const prhs[5], int32_T nlhs,
                      const mxArray *plhs[3])
{
  emxArray_real_T *coi;
  emxArray_real_T *freqs;
  emxArray_real_T *wt;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_2;
  real_T(*freqLims)[2];
  real_T freqsPerOctave;
  real_T fs;
  boolean_T doAvg;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);
  // Marshall function inputs
  emxInit_real_T(&x, 1, &v_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  freqLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "freqLims");
  doAvg = c_emlrt_marshallIn(emlrtAliasP(prhs[3]), "doAvg");
  freqsPerOctave = emlrt_marshallIn(emlrtAliasP(prhs[4]), "freqsPerOctave");
  // Invoke the target function
  emxInit_real_T(&wt, 2, &v_emlrtRTEI, true);
  emxInit_real_T(&freqs, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&coi, 1, &v_emlrtRTEI, true);
  ec_CWTdouble(x, fs, *freqLims, doAvg, freqsPerOctave, wt, freqs, coi);
  emxFree_real_T(&x);
  // Marshall function outputs
  wt->canFreeData = false;
  plhs[0] = emlrt_marshallOut(wt);
  emxFree_real_T(&wt);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = b_emlrt_marshallOut(freqs);
  }
  emxFree_real_T(&freqs);
  if (nlhs > 2) {
    coi->canFreeData = false;
    plhs[2] = b_emlrt_marshallOut(coi);
  }
  emxFree_real_T(&coi);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_ec_CWTdouble_api.cu)
