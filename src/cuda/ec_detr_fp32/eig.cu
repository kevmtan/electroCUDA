//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// eig.cu
//
// Code generation for function 'eig'
//

// Include files
#include "eig.h"
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_emxutil.h"
#include "ec_detr_fp_mexutil.h"
#include "ec_detr_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "lapacke.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstddef>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo e_emlrtRTEI{
    56,                                                            // lineNo
    24,                                                            // colNo
    "eig",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    60,                                                            // lineNo
    28,                                                            // colNo
    "eig",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    85,                                                            // lineNo
    9,                                                             // colNo
    "eig",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    1,         // lineNo
    30,        // colNo
    "xsyheev", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
    "xsyheev.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    89,                                                            // lineNo
    13,                                                            // colNo
    "eig",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m" // pName
};

static emlrtRTEInfo
    j_emlrtRTEI{
        40,      // lineNo
        37,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo k_emlrtRTEI{
    47,        // lineNo
    20,        // colNo
    "xsyheev", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
    "xsyheev.m" // pName
};

static emlrtRTEInfo
    l_emlrtRTEI{
        1,        // lineNo
        27,       // colNo
        "xgehrd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgehrd.m" // pName
    };

static emlrtRTEInfo
    m_emlrtRTEI{
        99,      // lineNo
        24,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo n_emlrtRTEI{
    42,                                                              // lineNo
    9,                                                               // colNo
    "schur",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    62,        // lineNo
    9,         // colNo
    "xsyheev", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
    "xsyheev.m" // pName
};

static emlrtRTEInfo
    p_emlrtRTEI{
        102,     // lineNo
        21,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    q_emlrtRTEI{
        76,       // lineNo
        22,       // colNo
        "xgehrd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgehrd.m" // pName
    };

static emlrtRTEInfo r_emlrtRTEI{
    28,                     // lineNo
    9,                      // colNo
    "eigHermitianStandard", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/"
    "eigHermitianStandard.m" // pName
};

static emlrtRTEInfo
    s_emlrtRTEI{
        131,     // lineNo
        29,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo t_emlrtRTEI{
    69,                                                              // lineNo
    13,                                                              // colNo
    "schur",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    63,        // lineNo
    9,         // colNo
    "xsyheev", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
    "xsyheev.m" // pName
};

static emlrtRTEInfo
    v_emlrtRTEI{
        132,     // lineNo
        29,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo w_emlrtRTEI{
    46,                                                              // lineNo
    9,                                                               // colNo
    "schur",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    33,                     // lineNo
    5,                      // colNo
    "eigHermitianStandard", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/"
    "eigHermitianStandard.m" // pName
};

static emlrtRTEInfo
    y_emlrtRTEI{
        86,       // lineNo
        9,        // colNo
        "xgehrd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgehrd.m" // pName
    };

static emlrtRTEInfo
    ab_emlrtRTEI{
        134,     // lineNo
        35,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    bb_emlrtRTEI{
        87,       // lineNo
        9,        // colNo
        "xgehrd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgehrd.m" // pName
    };

static emlrtRTEInfo cb_emlrtRTEI{
    23,                             // lineNo
    9,                              // colNo
    "eigRealSkewSymmetricStandard", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/"
    "eigRealSkewSymmetricStandard.m" // pName
};

static emlrtRTEInfo
    db_emlrtRTEI{
        111,      // lineNo
        29,       // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

static emlrtRTEInfo
    eb_emlrtRTEI{
        112,      // lineNo
        29,       // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

static emlrtRTEInfo
    fb_emlrtRTEI{
        160,     // lineNo
        13,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo gb_emlrtRTEI{
    24,                             // lineNo
    9,                              // colNo
    "eigRealSkewSymmetricStandard", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/"
    "eigRealSkewSymmetricStandard.m" // pName
};

static emlrtRTEInfo
    hb_emlrtRTEI{
        168,     // lineNo
        16,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    ib_emlrtRTEI{
        129,      // lineNo
        9,        // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

static emlrtRTEInfo
    jb_emlrtRTEI{
        161,     // lineNo
        13,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo kb_emlrtRTEI{
    27,            // lineNo
    13,            // colNo
    "eigStandard", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/"
    "eigStandard.m" // pName
};

static emlrtRTEInfo
    lb_emlrtRTEI{
        130,      // lineNo
        9,        // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

static emlrtRTEInfo mb_emlrtRTEI{
    1,                                                             // lineNo
    20,                                                            // colNo
    "eig",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m" // pName
};

static emlrtRTEInfo
    nb_emlrtRTEI{
        99,      // lineNo
        1,       // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    ob_emlrtRTEI{
        131,     // lineNo
        5,       // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    pb_emlrtRTEI{
        132,     // lineNo
        5,       // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    qb_emlrtRTEI{
        134,     // lineNo
        10,      // colNo
        "xgeev", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeev.m" // pName
    };

static emlrtRTEInfo
    rb_emlrtRTEI{
        111,      // lineNo
        9,        // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

static emlrtRTEInfo
    sb_emlrtRTEI{
        112,      // lineNo
        9,        // colNo
        "xhseqr", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xhseqr.m" // pName
    };

// Function Definitions
//
//
namespace coder {
void eig(const emxArray_real32_T *A, emxArray_creal32_T *V,
         emxArray_creal32_T *D)
{
  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  emxArray_creal32_T *b_W;
  emxArray_real32_T *U;
  emxArray_real32_T *W;
  emxArray_real32_T *b_A;
  emxArray_real32_T *c_A;
  emxArray_real32_T *d_A;
  emxArray_real32_T *scale;
  emxArray_real32_T *tau;
  emxArray_real32_T *vright;
  emxArray_real32_T *wi;
  emxArray_real32_T *wimag;
  emxArray_real32_T *wr;
  emxArray_real32_T *wreal;
  int32_T j;
  int32_T n;
  real32_T abnrm;
  real32_T rconde;
  real32_T rcondv;
  real32_T vleft;
  nvtxRangePushA("#fcn#eig#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  n = A->size[0];
  j = V->size[0] * V->size[1];
  V->size[0] = A->size[0];
  V->size[1] = A->size[0];
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(V, j, &e_emlrtRTEI);
  j = D->size[0] * D->size[1];
  D->size[0] = A->size[0];
  D->size[1] = A->size[0];
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(D, j, &f_emlrtRTEI);
  if ((A->size[0] != 0) && (A->size[1] != 0)) {
    int32_T istart;
    int32_T nx;
    boolean_T p;
    nx = A->size[0] * A->size[1];
    p = true;
    profileLoopStart("eig_loop_0", __LINE__, (nx - 1) + 1, "");
    for (istart = 0; istart < nx; istart++) {
      if ((!p) ||
          (std::isinf(A->data[istart]) || std::isnan(A->data[istart]))) {
        p = false;
      }
    }
    profileLoopEnd();
    if (!p) {
      nx = A->size[0];
      istart = A->size[0];
      j = V->size[0] * V->size[1];
      V->size[0] = A->size[0];
      V->size[1] = A->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(V, j, &g_emlrtRTEI);
      profileLoopStart("eig_loop_1", __LINE__, (nx * istart - 1) + 1, "");
      for (j = 0; j < nx * istart; j++) {
        V->data[j].re = rtNaNF;
        V->data[j].im = 0.0F;
      }
      profileLoopEnd();
      nx = A->size[0];
      istart = A->size[0];
      j = D->size[0] * D->size[1];
      D->size[0] = A->size[0];
      D->size[1] = A->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(D, j, &i_emlrtRTEI);
      if (nx * istart - 1 >= 0) {
        std::memset(&D->data[0], 0,
                    static_cast<uint32_T>(nx * istart) * sizeof(creal32_T));
      }
      profileLoopStart("eig_loop_5", __LINE__, (n - 1) + 1, "");
      for (istart = 0; istart < n; istart++) {
        D->data[istart + D->size[0] * istart].re = rtNaNF;
        D->data[istart + D->size[0] * istart].im = 0.0F;
      }
      profileLoopEnd();
    } else {
      int32_T exitg1;
      boolean_T exitg2;
      p = (A->size[0] == A->size[1]);
      if (p) {
        j = 0;
        exitg2 = false;
        nvtxRangePushA("#loop#eig_whileloop_4##" MW_AT_LINE);
        while ((!exitg2) && (j <= A->size[1] - 1)) {
          istart = 0;
          nvtxRangePushA("#loop#eig_whileloop_5##" MW_AT_LINE);
          do {
            exitg1 = 0;
            if (istart <= j) {
              if (!(A->data[istart + A->size[0] * j] ==
                    A->data[j + A->size[0] * istart])) {
                p = false;
                exitg1 = 1;
              } else {
                istart++;
              }
            } else {
              j++;
              exitg1 = 2;
            }
          } while (exitg1 == 0);
          nvtxRangePop();
          if (exitg1 == 1) {
            exitg2 = true;
          }
        }
        nvtxRangePop();
      }
      if (p) {
        ptrdiff_t info_t;
        n = A->size[0];
        nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
        emxInit_real32_T(&b_A, 2, &mb_emlrtRTEI, true);
        j = b_A->size[0] * b_A->size[1];
        b_A->size[0] = A->size[0];
        b_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_A, j, &h_emlrtRTEI);
        profileLoopStart("eig_loop_3", __LINE__,
                         (A->size[0] * A->size[1] - 1) + 1, "");
        for (j = 0; j < A->size[0] * A->size[1]; j++) {
          b_A->data[j] = A->data[j];
        }
        ptrdiff_t n_t;
        profileLoopEnd();
        n_t = (ptrdiff_t)b_A->size[0];
        nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
        emxInit_real32_T(&W, 1, &mb_emlrtRTEI, true);
        j = W->size[0];
        W->size[0] = b_A->size[0];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(W, j, &k_emlrtRTEI);
        info_t =
            LAPACKE_ssyev(102, 'V', 'L', n_t, &b_A->data[0], n_t, &W->data[0]);
        if ((int32_T)info_t < 0) {
          nx = W->size[0];
          j = W->size[0];
          W->size[0] = nx;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(W, j, &o_emlrtRTEI);
          profileLoopStart("eig_loop_8", __LINE__, (nx - 1) + 1, "");
          for (j = 0; j < nx; j++) {
            W->data[j] = rtNaNF;
          }
          profileLoopEnd();
          nx = b_A->size[0];
          istart = b_A->size[1];
          j = b_A->size[0] * b_A->size[1];
          b_A->size[0] = nx;
          b_A->size[1] = istart;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(b_A, j, &u_emlrtRTEI);
          profileLoopStart("eig_loop_15", __LINE__, (nx * istart - 1) + 1, "");
          for (j = 0; j < nx * istart; j++) {
            b_A->data[j] = rtNaNF;
          }
          profileLoopEnd();
        }
        j = D->size[0] * D->size[1];
        D->size[0] = A->size[0];
        D->size[1] = A->size[0];
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(D, j, &r_emlrtRTEI);
        profileLoopStart("eig_loop_9", __LINE__,
                         (A->size[0] * A->size[0] - 1) + 1, "");
        for (j = 0; j < A->size[0] * A->size[0]; j++) {
          D->data[j].re = 0.0F;
          D->data[j].im = 0.0F;
        }
        profileLoopEnd();
        profileLoopStart("eig_loop_11", __LINE__, (n - 1) + 1, "");
        for (istart = 0; istart < n; istart++) {
          D->data[istart + D->size[0] * istart].re = W->data[istart];
          D->data[istart + D->size[0] * istart].im = 0.0F;
        }
        profileLoopEnd();
        nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
        emxFree_real32_T(&W);
        j = V->size[0] * V->size[1];
        V->size[0] = b_A->size[0];
        V->size[1] = b_A->size[1];
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(V, j, &x_emlrtRTEI);
        profileLoopStart("eig_loop_17", __LINE__,
                         (b_A->size[0] * b_A->size[1] - 1) + 1, "");
        for (j = 0; j < b_A->size[0] * b_A->size[1]; j++) {
          V->data[j].re = b_A->data[j];
          V->data[j].im = 0.0F;
        }
        profileLoopEnd();
        nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
        emxFree_real32_T(&b_A);
      } else {
        p = (A->size[0] == A->size[1]);
        if (p) {
          j = 0;
          exitg2 = false;
          nvtxRangePushA("#loop#eig_whileloop_2##" MW_AT_LINE);
          while ((!exitg2) && (j <= A->size[1] - 1)) {
            istart = 0;
            nvtxRangePushA("#loop#eig_whileloop_3##" MW_AT_LINE);
            do {
              exitg1 = 0;
              if (istart <= j) {
                if (!(A->data[istart + A->size[0] * j] ==
                      -A->data[j + A->size[0] * istart])) {
                  p = false;
                  exitg1 = 1;
                } else {
                  istart++;
                }
              } else {
                j++;
                exitg1 = 2;
              }
            } while (exitg1 == 0);
            nvtxRangePop();
            if (exitg1 == 1) {
              exitg2 = true;
            }
          }
          nvtxRangePop();
        }
        if (p) {
          nx = A->size[0] * A->size[1];
          profileLoopStart("eig_loop_2", __LINE__, (nx - 1) + 1, "");
          for (istart = 0; istart < nx; istart++) {
            if ((!p) ||
                (std::isinf(A->data[istart]) || std::isnan(A->data[istart]))) {
              p = false;
            }
          }
          profileLoopEnd();
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&d_A, 2, &mb_emlrtRTEI, true);
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&U, 2, &mb_emlrtRTEI, true);
          if (!p) {
            uint32_T dv_idx_0;
            uint32_T dv_idx_1;
            dv_idx_0 = static_cast<uint32_T>(A->size[0]);
            dv_idx_1 = static_cast<uint32_T>(A->size[1]);
            j = U->size[0] * U->size[1];
            U->size[0] = A->size[0];
            U->size[1] = A->size[1];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(U, j, &n_emlrtRTEI);
            profileLoopStart("eig_loop_7", __LINE__,
                             (static_cast<int32_T>(dv_idx_0) *
                                  static_cast<int32_T>(dv_idx_1) -
                              1) +
                                 1,
                             "");
            for (j = 0; j < static_cast<int32_T>(dv_idx_0) *
                                static_cast<int32_T>(dv_idx_1);
                 j++) {
              U->data[j] = rtNaNF;
            }
            profileLoopEnd();
            nx = A->size[0];
            if (A->size[0] > 1) {
              istart = 2;
              if (A->size[0] - 2 < A->size[1] - 1) {
                n = A->size[0] - 1;
              } else {
                n = A->size[1];
              }
              profileLoopStart("eig_loop_10", __LINE__, (n - 1) + 1, "");
              for (j = 0; j < n; j++) {
                int64_T b;
                nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
                b = computeEndIdx(static_cast<int64_T>(istart),
                                  static_cast<int64_T>(nx), 1L);
                profileLoopStart("eig_loop_14", __LINE__, b + 1L, "");
                for (int64_T i{0L}; i <= b; i++) {
                  U->data[(static_cast<int32_T>(istart + i) + U->size[0] * j) -
                          1] = 0.0F;
                }
                profileLoopEnd();
                istart++;
              }
              profileLoopEnd();
            }
            dv_idx_0 = static_cast<uint32_T>(A->size[0]);
            dv_idx_1 = static_cast<uint32_T>(A->size[1]);
            j = d_A->size[0] * d_A->size[1];
            d_A->size[0] = A->size[0];
            d_A->size[1] = A->size[1];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(d_A, j, &w_emlrtRTEI);
            profileLoopStart("eig_loop_13", __LINE__,
                             (static_cast<int32_T>(dv_idx_0) *
                                  static_cast<int32_T>(dv_idx_1) -
                              1) +
                                 1,
                             "");
            for (j = 0; j < static_cast<int32_T>(dv_idx_0) *
                                static_cast<int32_T>(dv_idx_1);
                 j++) {
              d_A->data[j] = rtNaNF;
            }
            profileLoopEnd();
          } else {
            ptrdiff_t b_n_t;
            ptrdiff_t e_info_t;
            j = d_A->size[0] * d_A->size[1];
            d_A->size[0] = A->size[0];
            d_A->size[1] = A->size[1];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(d_A, j, &l_emlrtRTEI);
            profileLoopStart("eig_loop_6", __LINE__,
                             (A->size[0] * A->size[1] - 1) + 1, "");
            for (j = 0; j < A->size[0] * A->size[1]; j++) {
              d_A->data[j] = A->data[j];
            }
            profileLoopEnd();
            nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
            emxInit_real32_T(&tau, 1, &mb_emlrtRTEI, true);
            j = tau->size[0];
            tau->size[0] = d_A->size[0] - 1;
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(tau, j, &q_emlrtRTEI);
            if (d_A->size[0] > 1) {
              ptrdiff_t b_info_t;
              b_info_t =
                  LAPACKE_sgehrd(102, (ptrdiff_t)d_A->size[0], (ptrdiff_t)1,
                                 (ptrdiff_t)d_A->size[0], &d_A->data[0],
                                 (ptrdiff_t)d_A->size[0], &tau->data[0]);
              if ((int32_T)b_info_t != 0) {
                nx = d_A->size[0];
                istart = d_A->size[1];
                j = d_A->size[0] * d_A->size[1];
                d_A->size[0] = nx;
                d_A->size[1] = istart;
                nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
                emxEnsureCapacity_real32_T(d_A, j, &y_emlrtRTEI);
                profileLoopStart("eig_loop_16", __LINE__, (nx * istart - 1) + 1,
                                 "");
                for (j = 0; j < nx * istart; j++) {
                  d_A->data[j] = rtNaNF;
                }
                profileLoopEnd();
                nx = tau->size[0];
                j = tau->size[0];
                tau->size[0] = nx;
                nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
                emxEnsureCapacity_real32_T(tau, j, &bb_emlrtRTEI);
                profileLoopStart("eig_loop_19", __LINE__, (nx - 1) + 1, "");
                for (j = 0; j < nx; j++) {
                  tau->data[j] = rtNaNF;
                }
                profileLoopEnd();
              }
            }
            j = U->size[0] * U->size[1];
            U->size[0] = d_A->size[0];
            U->size[1] = d_A->size[1];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(U, j, &t_emlrtRTEI);
            profileLoopStart("eig_loop_12", __LINE__,
                             (d_A->size[0] * d_A->size[1] - 1) + 1, "");
            for (j = 0; j < d_A->size[0] * d_A->size[1]; j++) {
              U->data[j] = d_A->data[j];
            }
            profileLoopEnd();
            if (A->size[0] == 1) {
              U->data[0] = 1.0F;
            } else {
              ptrdiff_t c_info_t;
              c_info_t =
                  LAPACKE_sorghr(102, (ptrdiff_t)A->size[0], (ptrdiff_t)1,
                                 (ptrdiff_t)A->size[0], &U->data[0],
                                 (ptrdiff_t)A->size[0], &tau->data[0]);
              if ((int32_T)c_info_t != 0) {
                nx = U->size[0];
                istart = U->size[1];
                j = U->size[0] * U->size[1];
                U->size[0] = nx;
                U->size[1] = istart;
                nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
                emxEnsureCapacity_real32_T(U, j, &t_emlrtRTEI);
                profileLoopStart("eig_loop_20", __LINE__, (nx * istart - 1) + 1,
                                 "");
                for (j = 0; j < nx * istart; j++) {
                  U->data[j] = rtNaNF;
                }
                profileLoopEnd();
              }
            }
            nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
            emxFree_real32_T(&tau);
            b_n_t = (ptrdiff_t)d_A->size[0];
            nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
            emxInit_real32_T(&wr, 2, &rb_emlrtRTEI, true);
            j = wr->size[0] * wr->size[1];
            wr->size[0] = 1;
            wr->size[1] = d_A->size[0];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(wr, j, &db_emlrtRTEI);
            nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
            emxInit_real32_T(&wi, 2, &sb_emlrtRTEI, true);
            j = wi->size[0] * wi->size[1];
            wi->size[0] = 1;
            wi->size[1] = d_A->size[0];
            nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
            emxEnsureCapacity_real32_T(wi, j, &eb_emlrtRTEI);
            if (d_A->size[0] <= 1) {
              n = 1;
            } else {
              n = d_A->size[0];
            }
            e_info_t = LAPACKE_shseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                                      (ptrdiff_t)d_A->size[0], &d_A->data[0],
                                      b_n_t, &wr->data[0], &wi->data[0],
                                      &U->data[0], (ptrdiff_t)n);
            nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
            emxFree_real32_T(&wi);
            nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
            emxFree_real32_T(&wr);
            if ((int32_T)e_info_t < 0) {
              nx = d_A->size[0];
              istart = d_A->size[1];
              j = d_A->size[0] * d_A->size[1];
              d_A->size[0] = nx;
              d_A->size[1] = istart;
              nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
              emxEnsureCapacity_real32_T(d_A, j, &ib_emlrtRTEI);
              profileLoopStart("eig_loop_29", __LINE__, (nx * istart - 1) + 1,
                               "");
              for (j = 0; j < nx * istart; j++) {
                d_A->data[j] = rtNaNF;
              }
              profileLoopEnd();
              nx = U->size[0];
              istart = U->size[1];
              j = U->size[0] * U->size[1];
              U->size[0] = nx;
              U->size[1] = istart;
              nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
              emxEnsureCapacity_real32_T(U, j, &lb_emlrtRTEI);
              profileLoopStart("eig_loop_32", __LINE__, (nx * istart - 1) + 1,
                               "");
              for (j = 0; j < nx * istart; j++) {
                U->data[j] = rtNaNF;
              }
              profileLoopEnd();
            }
          }
          n = d_A->size[0];
          j = D->size[0] * D->size[1];
          D->size[0] = d_A->size[0];
          D->size[1] = d_A->size[0];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(D, j, &cb_emlrtRTEI);
          profileLoopStart("eig_loop_18", __LINE__,
                           (d_A->size[0] * d_A->size[0] - 1) + 1, "");
          for (j = 0; j < d_A->size[0] * d_A->size[0]; j++) {
            D->data[j].re = 0.0F;
            D->data[j].im = 0.0F;
          }
          profileLoopEnd();
          istart = 1;
          nvtxRangePushA("#loop#eig_whileloop_1##" MW_AT_LINE);
          while (istart <= n) {
            if ((istart != n) &&
                (d_A->data[istart + d_A->size[0] * (istart - 1)] != 0.0F)) {
              vleft = std::abs(d_A->data[istart + d_A->size[0] * (istart - 1)]);
              D->data[(istart + D->size[0] * (istart - 1)) - 1].re = 0.0F;
              D->data[(istart + D->size[0] * (istart - 1)) - 1].im = vleft;
              D->data[istart + D->size[0] * istart].re = 0.0F;
              D->data[istart + D->size[0] * istart].im = -vleft;
              istart += 2;
            } else {
              istart++;
            }
          }
          nvtxRangePop();
          j = V->size[0] * V->size[1];
          V->size[0] = U->size[0];
          V->size[1] = U->size[1];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(V, j, &gb_emlrtRTEI);
          profileLoopStart("eig_loop_22", __LINE__,
                           (U->size[0] * U->size[1] - 1) + 1, "");
          for (j = 0; j < U->size[0] * U->size[1]; j++) {
            V->data[j].re = U->data[j];
            V->data[j].im = 0.0F;
          }
          profileLoopEnd();
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&U);
          j = 1;
          n = d_A->size[0];
          nvtxRangePushA("#loop#eig_whileloop_0##" MW_AT_LINE);
          while (j <= n) {
            if ((j != n) && (d_A->data[j + d_A->size[0] * (j - 1)] != 0.0F)) {
              if (d_A->data[j + d_A->size[0] * (j - 1)] < 0.0F) {
                nx = 1;
              } else {
                nx = -1;
              }
              profileLoopStart("eig_loop_28", __LINE__, (n - 1) + 1, "");
              for (istart = 0; istart < n; istart++) {
                vleft = V->data[istart + V->size[0] * (j - 1)].re;
                abnrm = static_cast<real32_T>(nx) *
                        V->data[istart + V->size[0] * j].re;
                if (abnrm == 0.0F) {
                  V->data[istart + V->size[0] * (j - 1)].re =
                      vleft / 1.41421354F;
                  V->data[istart + V->size[0] * (j - 1)].im = 0.0F;
                } else if (vleft == 0.0F) {
                  V->data[istart + V->size[0] * (j - 1)].re = 0.0F;
                  V->data[istart + V->size[0] * (j - 1)].im =
                      abnrm / 1.41421354F;
                } else {
                  V->data[istart + V->size[0] * (j - 1)].re =
                      vleft / 1.41421354F;
                  V->data[istart + V->size[0] * (j - 1)].im =
                      abnrm / 1.41421354F;
                }
                V->data[istart + V->size[0] * j].re =
                    V->data[istart + V->size[0] * (j - 1)].re;
                V->data[istart + V->size[0] * j].im =
                    -V->data[istart + V->size[0] * (j - 1)].im;
              }
              profileLoopEnd();
              j += 2;
            } else {
              j++;
            }
          }
          nvtxRangePop();
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&d_A);
        } else {
          ptrdiff_t d_info_t;
          n = A->size[0];
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&c_A, 2, &j_emlrtRTEI, true);
          j = c_A->size[0] * c_A->size[1];
          c_A->size[0] = A->size[0];
          c_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_A, j, &j_emlrtRTEI);
          profileLoopStart("eig_loop_4", __LINE__,
                           (A->size[0] * A->size[1] - 1) + 1, "");
          for (j = 0; j < A->size[0] * A->size[1]; j++) {
            c_A->data[j] = A->data[j];
          }
          profileLoopEnd();
          nx = A->size[1] - 1;
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&scale, 1, &nb_emlrtRTEI, true);
          j = scale->size[0];
          scale->size[0] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(scale, j, &m_emlrtRTEI);
          nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
          emxInit_creal32_T(&b_W, 1, &mb_emlrtRTEI, true);
          j = b_W->size[0];
          b_W->size[0] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(b_W, j, &p_emlrtRTEI);
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&wreal, 1, &ob_emlrtRTEI, true);
          j = wreal->size[0];
          wreal->size[0] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(wreal, j, &s_emlrtRTEI);
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&wimag, 1, &pb_emlrtRTEI, true);
          j = wimag->size[0];
          wimag->size[0] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(wimag, j, &v_emlrtRTEI);
          nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
          emxInit_real32_T(&vright, 2, &qb_emlrtRTEI, true);
          j = vright->size[0] * vright->size[1];
          vright->size[0] = A->size[1];
          vright->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(vright, j, &ab_emlrtRTEI);
          d_info_t = LAPACKE_sgeevx(
              102, 'B', 'N', 'V', 'N', (ptrdiff_t)A->size[1], &c_A->data[0],
              (ptrdiff_t)A->size[0], &wreal->data[0], &wimag->data[0], &vleft,
              (ptrdiff_t)1, &vright->data[0], (ptrdiff_t)A->size[1], &ilo_t,
              &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&scale);
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&c_A);
          if ((int32_T)d_info_t < 0) {
            j = b_W->size[0];
            b_W->size[0] = A->size[1];
            nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
            emxEnsureCapacity_creal32_T(b_W, j, &fb_emlrtRTEI);
            profileLoopStart("eig_loop_23", __LINE__, (A->size[1] - 1) + 1, "");
            for (j = 0; j < A->size[1]; j++) {
              b_W->data[j].re = rtNaNF;
              b_W->data[j].im = 0.0F;
            }
            profileLoopEnd();
            nx = A->size[1];
            istart = A->size[1];
            j = V->size[0] * V->size[1];
            V->size[0] = A->size[1];
            V->size[1] = A->size[1];
            nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
            emxEnsureCapacity_creal32_T(V, j, &jb_emlrtRTEI);
            profileLoopStart("eig_loop_26", __LINE__, (nx * istart - 1) + 1,
                             "");
            for (j = 0; j < nx * istart; j++) {
              V->data[j].re = rtNaNF;
              V->data[j].im = 0.0F;
            }
            profileLoopEnd();
          } else {
            profileLoopStart("eig_loop_21", __LINE__, nx + 1, "");
            for (istart = 0; istart <= nx; istart++) {
              b_W->data[istart].re = wreal->data[istart];
              b_W->data[istart].im = wimag->data[istart];
            }
            profileLoopEnd();
            j = V->size[0] * V->size[1];
            V->size[0] = vright->size[0];
            V->size[1] = vright->size[1];
            nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
            emxEnsureCapacity_creal32_T(V, j, &hb_emlrtRTEI);
            profileLoopStart("eig_loop_24", __LINE__,
                             (vright->size[0] * vright->size[1] - 1) + 1, "");
            for (j = 0; j < vright->size[0] * vright->size[1]; j++) {
              V->data[j].re = vright->data[j];
              V->data[j].im = 0.0F;
            }
            profileLoopEnd();
            profileLoopStart("eig_loop_25", __LINE__, (nx - 1) + 1, "");
            for (istart = 0; istart < nx; istart++) {
              if ((wimag->data[istart] > 0.0F) &&
                  (wimag->data[istart + 1] < 0.0F)) {
                profileLoopStart("eig_loop_27", __LINE__, nx + 1, "");
                for (j = 0; j <= nx; j++) {
                  vleft = V->data[j + V->size[0] * istart].re;
                  abnrm = V->data[j + V->size[0] * (istart + 1)].re;
                  V->data[j + V->size[0] * istart].im = abnrm;
                  V->data[j + V->size[0] * (istart + 1)].re = vleft;
                  V->data[j + V->size[0] * (istart + 1)].im = -abnrm;
                }
                profileLoopEnd();
              }
            }
            profileLoopEnd();
          }
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&vright);
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&wimag);
          nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
          emxFree_real32_T(&wreal);
          j = D->size[0] * D->size[1];
          D->size[0] = A->size[0];
          D->size[1] = A->size[0];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(D, j, &kb_emlrtRTEI);
          profileLoopStart("eig_loop_30", __LINE__,
                           (A->size[0] * A->size[0] - 1) + 1, "");
          for (j = 0; j < A->size[0] * A->size[0]; j++) {
            D->data[j].re = 0.0F;
            D->data[j].im = 0.0F;
          }
          profileLoopEnd();
          profileLoopStart("eig_loop_31", __LINE__, (n - 1) + 1, "");
          for (istart = 0; istart < n; istart++) {
            D->data[istart + D->size[0] * istart] = b_W->data[istart];
          }
          profileLoopEnd();
          nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
          emxFree_creal32_T(&b_W);
        }
      }
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (eig.cu)
