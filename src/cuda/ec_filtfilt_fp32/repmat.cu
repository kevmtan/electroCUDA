//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// repmat.cu
//
// Code generation for function 'repmat'
//

// Include files
#include "repmat.h"
#include "filtfilt_data.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtMCInfo c_emlrtMCI{
    53,                                                              // lineNo
    5,                                                               // colNo
    "repmat",                                                        // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/elmat/repmat.m" // pName
};

static emlrtRTEInfo gc_emlrtRTEI{
    65,                                                              // lineNo
    28,                                                              // colNo
    "repmat",                                                        // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/elmat/repmat.m" // pName
};

// Function Declarations
static void b_error(const mxArray *m, emlrtMCInfo *location);

// Function Definitions
static void b_error(const mxArray *m, emlrtMCInfo *location)
{
  const mxArray *pArray;
  nvtxRangePushA("#fcn#b_error#" MW_AT_LOCATION);
  pArray = m;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 1, &pArray, "error",
                        true, location);
  nvtxRangePop();
}

//
//
namespace coder {
void repmat(const emxArray_real32_T *a, real_T varargin_1, emxArray_real32_T *b)
{
  static const int32_T iv[2]{1, 15};
  static const char_T u[15]{'M', 'A', 'T', 'L', 'A', 'B', ':', 'p',
                            'm', 'a', 'x', 's', 'i', 'z', 'e'};
  const mxArray *m;
  const mxArray *y;
  int32_T ncols;
  int32_T ntilerows;
  int32_T outsize_idx_0;
  nvtxRangePushA("#fcn#repmat#" MW_AT_LOCATION);
  outsize_idx_0 = a->size[0] * static_cast<int32_T>(varargin_1);
  if (!(outsize_idx_0 ==
        static_cast<real_T>(a->size[0]) *
            static_cast<real_T>(static_cast<int32_T>(varargin_1)))) {
    y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 15, m, &u[0]);
    emlrtAssign(&y, m);
    nvtxMarkA("#b_error#" MW_AT_LINE);
    b_error(y, &c_emlrtMCI);
  }
  ncols = b->size[0] * b->size[1];
  b->size[0] = outsize_idx_0;
  b->size[1] = a->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(b, ncols, &gc_emlrtRTEI);
  outsize_idx_0 = a->size[0];
  ncols = a->size[1];
  ntilerows = static_cast<int32_T>(varargin_1);
  profileLoopStart("repmat_loop_0", __LINE__, (ncols - 1) + 1, "");
  for (int32_T jcol{0}; jcol < ncols; jcol++) {
    int32_T iacol;
    int32_T ibmat;
    iacol = jcol * outsize_idx_0;
    ibmat = jcol * (outsize_idx_0 * static_cast<int32_T>(varargin_1));
    profileLoopStart("repmat_loop_1", __LINE__, (ntilerows - 1) + 1, "");
    for (int32_T itilerow{0}; itilerow < ntilerows; itilerow++) {
      int32_T ibcol;
      ibcol = ibmat + itilerow * outsize_idx_0;
      profileLoopStart("repmat_loop_2", __LINE__, (outsize_idx_0 - 1) + 1, "");
      for (int32_T k{0}; k < outsize_idx_0; k++) {
        b->data[ibcol + k] = a->data[iacol + k];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxRangePop();
}

} // namespace coder

// End of code generation (repmat.cu)
