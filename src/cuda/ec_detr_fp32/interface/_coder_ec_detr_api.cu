//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_detr_api.cu
//
// Code generation for function '_coder_ec_detr_api'
//

// Include files
#include "_coder_ec_detr_api.h"
#include "ec_detr.h"
#include "ec_detr_data.h"
#include "ec_detr_emxutil.h"
#include "ec_detr_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo tb_emlrtRTEI{
    1,                    // lineNo
    1,                    // colNo
    "_coder_ec_detr_api", // fName
    ""                    // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static real32_T *b_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId,
                                    int32_T ret_size[2]);

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static real32_T *emlrt_marshallIn(const mxArray *b_nullptr,
                                  const char_T *identifier, int32_T y_size[2]);

static real32_T *emlrt_marshallIn(const mxArray *u,
                                  const emlrtMsgIdentifier *parentId,
                                  int32_T y_size[2]);

static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y);

static const mxArray *emlrt_marshallOut(const real_T u_data[],
                                        const int32_T u_size[2]);

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

static real32_T *b_emlrt_marshallIn(const mxArray *src,
                                    const emlrtMsgIdentifier *msgId,
                                    int32_T ret_size[2])
{
  static const int32_T dims[2]{1, 99};
  int32_T iv[2];
  real32_T *ret_data;
  boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_data = static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret_data;
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

static real32_T *emlrt_marshallIn(const mxArray *b_nullptr,
                                  const char_T *identifier, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *y_data;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y_data = emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y_size);
  emlrtDestroyArray(&b_nullptr);
  return y_data;
}

static real32_T *emlrt_marshallIn(const mxArray *u,
                                  const emlrtMsgIdentifier *parentId,
                                  int32_T y_size[2])
{
  real32_T *y_data;
  y_data = b_emlrt_marshallIn(emlrtAlias(u), parentId, y_size);
  emlrtDestroyArray(&u);
  return y_data;
}

static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y)
{
  emlrtMxSetData((mxArray *)y, &u->data[0]);
  emlrtSetDimensions((mxArray *)y, &u->size[0], 2);
}

static const mxArray *emlrt_marshallOut(const real_T u_data[],
                                        const int32_T u_size[2])
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, &u_size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

void ec_detr_api(const mxArray *const prhs[5], int32_T nlhs,
                 const mxArray *plhs[3])
{
  emxArray_real32_T *w;
  emxArray_real32_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
  real_T(*olPct_data)[99];
  int32_T itr_size[2];
  int32_T olPct_size[2];
  int32_T ord_size[2];
  int32_T thr_size[2];
  real32_T(*itr_data)[99];
  real32_T(*ord_data)[99];
  real32_T(*thr_data)[99];
  olPct_data = (real_T(*)[99])mxMalloc(sizeof(real_T[99]));
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs_copy_idx_1 = emlrtProtectR2012b(prhs[1], 1, true, -1);
  // Marshall function inputs
  emxInit_real32_T(&x, 2, &tb_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  emxInit_real32_T(&w, 2, &tb_emlrtRTEI, true);
  w->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_1), "w", w);
  *(real32_T **)&ord_data =
      emlrt_marshallIn(emlrtAlias(prhs[2]), "ord", ord_size);
  *(real32_T **)&thr_data =
      emlrt_marshallIn(emlrtAlias(prhs[3]), "thr", thr_size);
  *(real32_T **)&itr_data =
      emlrt_marshallIn(emlrtAlias(prhs[4]), "itr", itr_size);
  // Invoke the target function
  ec_detr(x, w, *ord_data, ord_size, *thr_data, thr_size, *itr_data, itr_size,
          *olPct_data, olPct_size);
  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real32_T(&x);
  plhs[0] = prhs_copy_idx_0;
  if (nlhs > 1) {
    w->canFreeData = false;
    emlrt_marshallOut(w, prhs_copy_idx_1);
    plhs[1] = prhs_copy_idx_1;
  }
  emxFree_real32_T(&w);
  if (nlhs > 2) {
    plhs[2] = emlrt_marshallOut(*olPct_data, olPct_size);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_ec_detr_api.cu)
