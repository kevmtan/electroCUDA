//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt.cu
//
// Code generation for function 'filtfilt'
//

// Include files
#include "filtfilt.h"
#include "bsxfun.h"
#include "fillIn.h"
#include "filter.h"
#include "filtfilt_data.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_mexutil.h"
#include "filtfilt_types.h"
#include "introsort.h"
#include "repmat.h"
#include "rt_nonfinite.h"
#include "sparse.h"
#include "warning.h"
#include "MWCUBLASUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cs.h"
#include "makeCXSparseMatrix.h"
#include "nvtx3/nvToolsExt.h"
#include "solve_from_lu.h"
#include "solve_from_qr.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtMCInfo d_emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

static emlrtRTEInfo emlrtRTEI{
    123,                                                        // lineNo
    10,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    166,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    353,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    420,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    179,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo
    f_emlrtRTEI{
        76,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo g_emlrtRTEI{
    184,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    150,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    179,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    423,                                                        // lineNo
    36,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    356,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    304,                                                        // lineNo
    16,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    424,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    357,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    424,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    357,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    307,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    424,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    181,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    307,                                                        // lineNo
    28,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    425,                                                        // lineNo
    23,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    425,                                                        // lineNo
    31,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    358,                                                        // lineNo
    23,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    308,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    358,                                                        // lineNo
    31,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    308,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo bb_emlrtRTEI{
    358,                                                        // lineNo
    39,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo cb_emlrtRTEI{
    309,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo db_emlrtRTEI{
    426,                                                        // lineNo
    38,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo eb_emlrtRTEI{
    309,                                                        // lineNo
    28,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fb_emlrtRTEI{
    427,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo gb_emlrtRTEI{
    427,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo hb_emlrtRTEI{
    309,                                                        // lineNo
    36,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ib_emlrtRTEI{
    359,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo jb_emlrtRTEI{
    429,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo kb_emlrtRTEI{
    360,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo lb_emlrtRTEI{
    429,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo mb_emlrtRTEI{
    360,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo nb_emlrtRTEI{
    429,                                                        // lineNo
    37,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ob_emlrtRTEI{
    429,                                                        // lineNo
    53,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo pb_emlrtRTEI{
    373,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo qb_emlrtRTEI{
    430,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo rb_emlrtRTEI{
    373,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo sb_emlrtRTEI{
    430,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo tb_emlrtRTEI{
    430,                                                        // lineNo
    34,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ub_emlrtRTEI{
    374,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo vb_emlrtRTEI{
    432,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo wb_emlrtRTEI{
    374,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo xb_emlrtRTEI{
    390,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo yb_emlrtRTEI{
    1,                                                          // lineNo
    14,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ac_emlrtRTEI{
    300,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo bc_emlrtRTEI{
    416,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo cc_emlrtRTEI{
    423,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo dc_emlrtRTEI{
    304,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ec_emlrtRTEI{
    427,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fc_emlrtRTEI{
    360,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo gc_emlrtRTEI{
    430,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo hc_emlrtRTEI{
    374,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ic_emlrtRTEI{
    426,                                                        // lineNo
    10,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo kc_emlrtRTEI{
    713,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo lc_emlrtRTEI{
    223,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo mc_emlrtRTEI{
    224,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo nc_emlrtRTEI{
    716,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo oc_emlrtRTEI{
    54,                                                               // lineNo
    9,                                                                // colNo
    "div",                                                            // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/div.m" // pName
};

static emlrtRTEInfo pc_emlrtRTEI{
    231,                                                        // lineNo
    25,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo qc_emlrtRTEI{
    232,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo rc_emlrtRTEI{
    245,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo sc_emlrtRTEI{
    246,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo tc_emlrtRTEI{
    249,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    250,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
    1647,     // lineNo
    27,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo wc_emlrtRTEI{
    125,      // lineNo
    44,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo xc_emlrtRTEI{
    1676,     // lineNo
    5,        // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo yc_emlrtRTEI{
    13,                                                                // lineNo
    1,                                                                 // colNo
    "sparse",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/sparfun/sparse.m" // pName
};

static emlrtRTEInfo ad_emlrtRTEI{
    261,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo
    bd_emlrtRTEI{
        388,           // lineNo
        38,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo
    cd_emlrtRTEI{
        405,           // lineNo
        46,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo
    dd_emlrtRTEI{
        399,           // lineNo
        46,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo ed_emlrtRTEI{
    232,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    261,                                                        // lineNo
    19,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    119,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo hd_emlrtRTEI{
    120,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    125,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo
    jd_emlrtRTEI{
        457,           // lineNo
        63,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo
    kd_emlrtRTEI{
        394,           // lineNo
        25,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo ld_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

static emlrtRTEInfo md_emlrtRTEI{
    733,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    738,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo od_emlrtRTEI{
    731,                                                        // lineNo
    15,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ae_emlrtRTEI{
    505,                                                        // lineNo
    12,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo be_emlrtRTEI{
    661,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ce_emlrtRTEI{
    672,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo de_emlrtRTEI{
    667,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ee_emlrtRTEI{
    656,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fe_emlrtRTEI{
    550,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ge_emlrtRTEI{
    673,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo he_emlrtRTEI{
    551,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ie_emlrtRTEI{
    657,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo je_emlrtRTEI{
    452,                                                        // lineNo
    8,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[14]);

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location);

static void binary_expand_op_1(emxArray_real_T *in1, real_T in2, int32_T in3,
                               const emxArray_real_T *in4, int32_T in5,
                               const emxArray_real_T *in6);

namespace coder {
static void filtfiltParser(const emxArray_real_T *ctf,
                           const emxArray_real_T *varargin_1,
                           emxArray_real_T *B, emxArray_real_T *A,
                           real_T *numStage, real_T *P, real_T *Q,
                           boolean_T *isNumNonempty, boolean_T *isDenNonempty);

static void findEffectiveFilterLen(emxArray_real_T *coef, real_T effLen_data[],
                                   int32_T effLen_size[1]);

static void getCoeffsAndInitialConditions(const emxArray_real_T *num,
                                          const emxArray_real_T *den,
                                          real_T numStage, real_T P, real_T Q,
                                          emxArray_real_T *B,
                                          emxArray_real_T *A,
                                          emxArray_real_T *zi, real_T *Letr);

} // namespace coder
static int32_T div_s32(int32_T numerator, int32_T denominator);

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[14]);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[14]);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[14])
{
  static const int32_T dims[2]{1, 14};
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 14);
  emlrtDestroyArray(&src);
  nvtxRangePop();
}

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  const mxArray *m3;
  nvtxRangePushA("#fcn#b_sprintf#" MW_AT_LOCATION);
  pArrays[0] = m1;
  pArrays[1] = m2;
  m3 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
                             "sprintf", true, location);
  nvtxRangePop();
  return m3;
}

static void binary_expand_op_1(emxArray_real_T *in1, real_T in2, int32_T in3,
                               const emxArray_real_T *in4, int32_T in5,
                               const emxArray_real_T *in6)
{
  emxArray_real_T *b_in4;
  int32_T i;
  int32_T in6_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  nvtxRangePushA("#fcn#binary_expand_op_1#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in6_idx_0 = in6->size[0];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_in4, 2, &oc_emlrtRTEI, true);
  i = b_in4->size[0] * b_in4->size[1];
  if (in6_idx_0 == 1) {
    b_in4->size[0] = in4->size[0];
  } else {
    b_in4->size[0] = in6_idx_0;
  }
  b_in4->size[1] = in5 + 1;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_in4, i, &oc_emlrtRTEI);
  stride_0_0 = (in4->size[0] != 1);
  stride_1_0 = (in6_idx_0 != 1);
  profileLoopStart("binary_expand_op_1_loop_0", __LINE__, in5 + 1, "");
  for (i = 0; i <= in5; i++) {
    int32_T b;
    if (in6_idx_0 == 1) {
      b = in4->size[0];
    } else {
      b = in6_idx_0;
    }
    profileLoopStart("binary_expand_op_1_loop_2", __LINE__, (b - 1) + 1, "");
    for (int32_T i1{0}; i1 < b; i1++) {
      b_in4->data[i1 + b_in4->size[0] * i] =
          in4->data[i1 * stride_0_0 + in4->size[0] * i] /
          in6->data[i1 * stride_1_0];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  in6_idx_0 = static_cast<int32_T>(in2);
  profileLoopStart("binary_expand_op_1_loop_1", __LINE__, (in3 - 1) + 1, "");
  for (i = 0; i < in3; i++) {
    profileLoopStart("binary_expand_op_1_loop_3", __LINE__, (in6_idx_0 - 1) + 1,
                     "");
    for (int32_T i1{0}; i1 < in6_idx_0; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          b_in4->data[i1 + static_cast<int32_T>(in2) * i];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_in4);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
namespace coder {
static void filtfiltParser(const emxArray_real_T *ctf,
                           const emxArray_real_T *varargin_1,
                           emxArray_real_T *B, emxArray_real_T *A,
                           real_T *numStage, real_T *P, real_T *Q,
                           boolean_T *isNumNonempty, boolean_T *isDenNonempty)
{
  emxArray_real_T *NUM;
  int32_T b_numStage;
  int32_T numSV;
  int32_T u0;
  int32_T u1;
  boolean_T guard1;
  boolean_T guard2;
  boolean_T isDenNonemptyVector;
  boolean_T isDenVector;
  boolean_T isNumVector;
  nvtxRangePushA("#fcn#filtfiltParser#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  *isNumNonempty = ((ctf->size[0] != 0) && (ctf->size[1] != 0));
  *isDenNonempty = ((varargin_1->size[0] != 0) && (varargin_1->size[1] != 0));
  isNumVector = ((ctf->size[0] == 1) || (ctf->size[1] == 1));
  isDenVector = ((varargin_1->size[0] == 1) || (varargin_1->size[1] == 1));
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&NUM, 2, &je_emlrtRTEI, true);
  u0 = NUM->size[0] * NUM->size[1];
  NUM->size[0] = ctf->size[0];
  NUM->size[1] = ctf->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(NUM, u0, &ae_emlrtRTEI);
  profileLoopStart("filtfiltParser_loop_0", __LINE__,
                   (ctf->size[0] * ctf->size[1] - 1) + 1, "");
  for (u0 = 0; u0 < ctf->size[0] * ctf->size[1]; u0++) {
    NUM->data[u0] = ctf->data[u0];
  }
  profileLoopEnd();
  b_numStage = ctf->size[0];
  if ((*isDenNonempty) && isDenVector) {
    isDenNonemptyVector = true;
  } else {
    isDenNonemptyVector = false;
  }
  if ((ctf->size[1] == 6) && (ctf->size[0] == 1) && isDenNonemptyVector) {
    if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0)) {
      numSV = 0;
    } else {
      u0 = varargin_1->size[0];
      numSV = varargin_1->size[1];
      if (u0 >= numSV) {
        numSV = u0;
      }
    }
    if (numSV <= 2) {
      if (ctf->data[3] == 1.0) {
        nvtxMarkA("#warning#" MW_AT_LINE);
        internal::warning();
      } else {
        nvtxMarkA("#b_warning#" MW_AT_LINE);
        internal::b_warning();
      }
    }
  }
  guard1 = false;
  guard2 = false;
  if ((*isNumNonempty) && isDenNonemptyVector && (ctf->size[1] == 6)) {
    if (ctf->size[0] > 1) {
      guard2 = true;
    } else if (ctf->data[3] == 1.0) {
      if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0)) {
        numSV = 0;
      } else {
        u0 = varargin_1->size[0];
        numSV = varargin_1->size[1];
        if (u0 >= numSV) {
          numSV = u0;
        }
      }
      if (numSV <= 2) {
        guard2 = true;
      } else {
        guard1 = true;
      }
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }
  if (guard2) {
    if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0)) {
      numSV = 0;
    } else {
      u0 = varargin_1->size[0];
      numSV = varargin_1->size[1];
      if (u0 >= numSV) {
        numSV = u0;
      }
    }
    if (static_cast<uint32_T>(numSV) ==
        static_cast<uint32_T>(ctf->size[0]) + 1U) {
      NUM->data[ctf->size[0] - 1] =
          varargin_1->data[ctf->size[0]] * ctf->data[ctf->size[0] - 1];
      NUM->data[(ctf->size[0] + NUM->size[0]) - 1] =
          varargin_1->data[ctf->size[0]] *
          ctf->data[(ctf->size[0] + ctf->size[0]) - 1];
      NUM->data[(ctf->size[0] + NUM->size[0] * 2) - 1] =
          varargin_1->data[ctf->size[0]] *
          ctf->data[(ctf->size[0] + ctf->size[0] * 2) - 1];
      numSV--;
    }
    profileLoopStart("filtfiltParser_loop_1", __LINE__, (numSV - 1) + 1, "");
    for (u0 = 0; u0 < numSV; u0++) {
      NUM->data[u0] *= varargin_1->data[u0];
      NUM->data[u0 + NUM->size[0]] *= varargin_1->data[u0];
      NUM->data[u0 + NUM->size[0] * 2] *= varargin_1->data[u0];
    }
    profileLoopEnd();
    u0 = B->size[0] * B->size[1];
    B->size[0] = NUM->size[0];
    B->size[1] = 3;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(B, u0, &fe_emlrtRTEI);
    u0 = A->size[0] * A->size[1];
    A->size[0] = NUM->size[0];
    A->size[1] = 3;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(A, u0, &he_emlrtRTEI);
    profileLoopStart("filtfiltParser_loop_7", __LINE__, 2 + 1, "");
    for (u0 = 0; u0 < 3; u0++) {
      profileLoopStart("filtfiltParser_loop_8", __LINE__,
                       (NUM->size[0] - 1) + 1, "");
      for (numSV = 0; numSV < NUM->size[0]; numSV++) {
        B->data[numSV + B->size[0] * u0] = NUM->data[numSV + NUM->size[0] * u0];
        A->data[numSV + A->size[0] * u0] =
            NUM->data[numSV + NUM->size[0] * (u0 + 3)];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    numSV = 3;
    u1 = 3;
  }
  if (guard1) {
    if (isNumVector && isDenVector) {
      if ((ctf->size[0] == 0) || (ctf->size[1] == 0)) {
        numSV = 0;
      } else {
        u0 = ctf->size[0];
        numSV = ctf->size[1];
        if (u0 >= numSV) {
          numSV = u0;
        }
      }
      if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0)) {
        u1 = 0;
      } else {
        u0 = varargin_1->size[0];
        u1 = varargin_1->size[1];
        if (u0 >= u1) {
          u1 = u0;
        }
      }
      b_numStage = 1;
      u0 = B->size[0] * B->size[1];
      B->size[0] = 1;
      B->size[1] = numSV;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(B, u0, &ee_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_5", __LINE__, (numSV - 1) + 1, "");
      for (u0 = 0; u0 < numSV; u0++) {
        B->data[u0] = ctf->data[u0];
      }
      profileLoopEnd();
      u0 = A->size[0] * A->size[1];
      A->size[0] = 1;
      A->size[1] = u1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(A, u0, &ie_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_9", __LINE__, (u1 - 1) + 1, "");
      for (u0 = 0; u0 < u1; u0++) {
        A->data[u0] = varargin_1->data[u0];
      }
      profileLoopEnd();
    } else if ((*isNumNonempty) && (!isNumVector) &&
               ((varargin_1->size[0] == 1) && (varargin_1->size[1] == 1))) {
      u0 = B->size[0] * B->size[1];
      B->size[0] = ctf->size[0];
      B->size[1] = ctf->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(B, u0, &be_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_2", __LINE__,
                       (ctf->size[0] * ctf->size[1] - 1) + 1, "");
      for (u0 = 0; u0 < ctf->size[0] * ctf->size[1]; u0++) {
        B->data[u0] = ctf->data[u0];
      }
      profileLoopEnd();
      numSV = ctf->size[1];
      b_numStage = ctf->size[0];
      u1 = 1;
      nvtxMarkA("#repmat#" MW_AT_LINE);
      repmat(varargin_1, static_cast<real_T>(ctf->size[0]), A);
    } else if ((*isDenNonempty) && (!isDenVector) &&
               ((ctf->size[0] == 1) && (ctf->size[1] == 1))) {
      u0 = A->size[0] * A->size[1];
      A->size[0] = varargin_1->size[0];
      A->size[1] = varargin_1->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(A, u0, &de_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_4", __LINE__,
                       (varargin_1->size[0] * varargin_1->size[1] - 1) + 1, "");
      for (u0 = 0; u0 < varargin_1->size[0] * varargin_1->size[1]; u0++) {
        A->data[u0] = varargin_1->data[u0];
      }
      profileLoopEnd();
      u1 = varargin_1->size[1];
      b_numStage = varargin_1->size[0];
      numSV = 1;
      nvtxMarkA("#repmat#" MW_AT_LINE);
      repmat(ctf, static_cast<real_T>(varargin_1->size[0]), B);
    } else {
      u0 = B->size[0] * B->size[1];
      B->size[0] = ctf->size[0];
      B->size[1] = ctf->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(B, u0, &ce_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_3", __LINE__,
                       (ctf->size[0] * ctf->size[1] - 1) + 1, "");
      for (u0 = 0; u0 < ctf->size[0] * ctf->size[1]; u0++) {
        B->data[u0] = ctf->data[u0];
      }
      profileLoopEnd();
      u0 = A->size[0] * A->size[1];
      A->size[0] = varargin_1->size[0];
      A->size[1] = varargin_1->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(A, u0, &ge_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_6", __LINE__,
                       (varargin_1->size[0] * varargin_1->size[1] - 1) + 1, "");
      for (u0 = 0; u0 < varargin_1->size[0] * varargin_1->size[1]; u0++) {
        A->data[u0] = varargin_1->data[u0];
      }
      profileLoopEnd();
      numSV = ctf->size[1];
      b_numStage = ctf->size[0];
      u1 = varargin_1->size[1];
    }
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&NUM);
  *numStage = b_numStage;
  *P = numSV;
  *Q = u1;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
static void findEffectiveFilterLen(emxArray_real_T *coef, real_T effLen_data[],
                                   int32_T effLen_size[1])
{
  emxArray_boolean_T *x;
  emxArray_real_T *varargin_1;
  real_T maxCoef;
  int32_T ii_data[1];
  int32_T idx;
  int32_T k;
  int32_T nx;
  boolean_T exitg1;
  nvtxRangePushA("#fcn#findEffectiveFilterLen#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nx = coef->size[1];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&varargin_1, 2, &od_emlrtRTEI, true);
  idx = varargin_1->size[0] * varargin_1->size[1];
  varargin_1->size[0] = 1;
  varargin_1->size[1] = coef->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(varargin_1, idx, &ld_emlrtRTEI);
  profileLoopStart("findEffectiveFilterLen_loop_0", __LINE__, (nx - 1) + 1, "");
  for (k = 0; k < nx; k++) {
    varargin_1->data[k] = std::abs(coef->data[k]);
  }
  profileLoopEnd();
  nx = varargin_1->size[1];
  maxCoef = varargin_1->data[0];
  profileLoopStart("findEffectiveFilterLen_loop_1", __LINE__, (nx - 2) + 1, "");
  for (idx = 0; idx <= nx - 2; idx++) {
    real_T d;
    boolean_T p;
    d = varargin_1->data[idx + 1];
    if (std::isnan(d)) {
      p = false;
    } else if (std::isnan(maxCoef)) {
      p = true;
    } else {
      p = (maxCoef < d);
    }
    if (p) {
      maxCoef = d;
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&varargin_1);
  if (maxCoef != 0.0) {
    idx = coef->size[1];
    nx = coef->size[0] * coef->size[1];
    coef->size[0] = 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(coef, nx, &md_emlrtRTEI);
    profileLoopStart("findEffectiveFilterLen_loop_2", __LINE__, (idx - 1) + 1,
                     "");
    for (nx = 0; nx < idx; nx++) {
      coef->data[nx] /= maxCoef;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_boolean_T#" MW_AT_LINE);
  emxInit_boolean_T(&x, 1, &nd_emlrtRTEI, true);
  idx = x->size[0];
  x->size[0] = coef->size[1];
  nvtxMarkA("#emxEnsureCapacity_boolean_T#" MW_AT_LINE);
  emxEnsureCapacity_boolean_T(x, idx, &nd_emlrtRTEI);
  profileLoopStart("findEffectiveFilterLen_loop_3", __LINE__,
                   (coef->size[1] - 1) + 1, "");
  for (idx = 0; idx < coef->size[1]; idx++) {
    x->data[idx] = (coef->data[idx] != 0.0);
  }
  profileLoopEnd();
  k = (x->size[0] >= 1);
  nx = x->size[0];
  idx = 0;
  exitg1 = false;
  nvtxRangePushA("#loop#findEffectiveFilterLen_whileloop_0##" MW_AT_LINE);
  while ((!exitg1) && (nx > 0)) {
    if (x->data[nx - 1]) {
      idx = 1;
      ii_data[0] = nx;
      exitg1 = true;
    } else {
      nx--;
    }
  }
  nvtxRangePop();
  nvtxMarkA("#emxFree_boolean_T#" MW_AT_LINE);
  emxFree_boolean_T(&x);
  if (k == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    k = (idx >= 1);
  }
  effLen_size[0] = k;
  profileLoopStart("findEffectiveFilterLen_loop_4", __LINE__, (k - 1) + 1, "");
  for (idx = 0; idx < k; idx++) {
    effLen_data[0] = ii_data[0];
  }
  profileLoopEnd();
  if (k == 0) {
    effLen_size[0] = 1;
    effLen_data[0] = 0.0;
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
static void getCoeffsAndInitialConditions(const emxArray_real_T *num,
                                          const emxArray_real_T *den,
                                          real_T numStage, real_T P, real_T Q,
                                          emxArray_real_T *B,
                                          emxArray_real_T *A,
                                          emxArray_real_T *zi, real_T *Letr)
{
  static const int32_T iv[2]{1, 6};
  static const char_T rfmt[6]{'%', '1', '4', '.', '6', 'e'};
  emxArray_int32_T *b_in_colidx;
  emxArray_int32_T *b_in_rowidx;
  emxArray_int32_T *b_t;
  emxArray_int32_T *c_in_colidx;
  emxArray_int32_T *c_in_rowidx;
  emxArray_int32_T *cidxInt;
  emxArray_int32_T *in_colidx;
  emxArray_int32_T *in_rowidx;
  emxArray_int32_T *ridxInt;
  emxArray_int32_T *sortedIndices;
  emxArray_int32_T *t;
  emxArray_int32_T *y_colidx;
  emxArray_int32_T *y_rowidx;
  emxArray_real_T *b_den;
  emxArray_real_T *b_in_d;
  emxArray_real_T *b_num;
  emxArray_real_T *b_outBuff;
  emxArray_real_T *c_den;
  emxArray_real_T *c_in_d;
  emxArray_real_T *c_num;
  emxArray_real_T *colIdx;
  emxArray_real_T *in_d;
  emxArray_real_T *outBuff;
  emxArray_real_T *rhs;
  emxArray_real_T *rowIdx;
  emxArray_real_T *vals;
  emxArray_real_T *y_d;
  emxArray_real_T *zik;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *y;
  real_T b_tmp_data[1];
  real_T tmp_data[1];
  real_T M;
  real_T ord;
  int32_T b_loop_ub;
  int32_T b_ns;
  int32_T c_ns;
  int32_T cptr;
  int32_T i;
  int32_T i10;
  int32_T i11;
  int32_T loop_ub;
  int32_T nc;
  int32_T numalloc{0};
  int32_T ny;
  int32_T thism;
  int32_T vlen;
  nvtxRangePushA("#fcn#getCoeffsAndInitialConditions#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  M = std::fmax(P, Q);
  ord = 0.0;
  ny = static_cast<int32_T>(numStage);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_num, 2, &kc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_den, 2, &nc_emlrtRTEI, true);
  profileLoopStart("getCoeffsAndInitialConditions_loop_0", __LINE__,
                   (ny - 1) + 1, "");
  for (int32_T ns{0}; ns < ny; ns++) {
    i = b_num->size[0] * b_num->size[1];
    b_num->size[0] = 1;
    b_num->size[1] = num->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b_num, i, &kc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_1", __LINE__,
                     (num->size[1] - 1) + 1, "");
    for (i = 0; i < num->size[1]; i++) {
      b_num->data[i] = num->data[ns + num->size[0] * i];
    }
    profileLoopEnd();
    i = b_den->size[0] * b_den->size[1];
    b_den->size[0] = 1;
    b_den->size[1] = den->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b_den, i, &nc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_3", __LINE__,
                     (den->size[1] - 1) + 1, "");
    for (i = 0; i < den->size[1]; i++) {
      b_den->data[i] = den->data[ns + den->size[0] * i];
    }
    int32_T tmp_size[1];
    profileLoopEnd();
    nvtxMarkA("#findEffectiveFilterLen#" MW_AT_LINE);
    findEffectiveFilterLen(b_num, tmp_data, tmp_size);
    nvtxMarkA("#findEffectiveFilterLen#" MW_AT_LINE);
    findEffectiveFilterLen(b_den, b_tmp_data, tmp_size);
    ord = (ord + std::fmax(tmp_data[0], b_tmp_data[0])) - 1.0;
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_den);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_num);
  i = B->size[0] * B->size[1];
  B->size[0] = static_cast<int32_T>(numStage);
  B->size[1] = static_cast<int32_T>(M);
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(B, i, &lc_emlrtRTEI);
  i = A->size[0] * A->size[1];
  A->size[0] = static_cast<int32_T>(numStage);
  A->size[1] = static_cast<int32_T>(M);
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(A, i, &mc_emlrtRTEI);
  profileLoopStart(
      "getCoeffsAndInitialConditions_loop_2", __LINE__,
      (static_cast<int32_T>(numStage) * static_cast<int32_T>(M) - 1) + 1, "");
  for (i = 0; i < static_cast<int32_T>(numStage) * static_cast<int32_T>(M);
       i++) {
    B->data[i] = 0.0;
    A->data[i] = 0.0;
  }
  profileLoopEnd();
  if (P < 1.0) {
    cptr = 0;
    ny = 0;
  } else {
    cptr = static_cast<int32_T>(P);
    ny = static_cast<int32_T>(P);
  }
  if (num->size[0] == den->size[0]) {
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_num, 2, &oc_emlrtRTEI, true);
    i = c_num->size[0] * c_num->size[1];
    c_num->size[0] = num->size[0];
    c_num->size[1] = cptr;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(c_num, i, &oc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_4", __LINE__,
                     (cptr - 1) + 1, "");
    for (i = 0; i < cptr; i++) {
      profileLoopStart("getCoeffsAndInitialConditions_loop_5", __LINE__,
                       (num->size[0] - 1) + 1, "");
      for (thism = 0; thism < num->size[0]; thism++) {
        c_num->data[thism + c_num->size[0] * i] =
            num->data[thism + num->size[0] * i] / den->data[thism];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    vlen = static_cast<int32_T>(numStage);
    profileLoopStart("getCoeffsAndInitialConditions_loop_6", __LINE__,
                     (ny - 1) + 1, "");
    for (i = 0; i < ny; i++) {
      profileLoopStart("getCoeffsAndInitialConditions_loop_8", __LINE__,
                       (vlen - 1) + 1, "");
      for (thism = 0; thism < vlen; thism++) {
        B->data[thism + B->size[0] * i] =
            c_num->data[thism + static_cast<int32_T>(numStage) * i];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c_num);
  } else {
    nvtxMarkA("#binary_expand_op_1#" MW_AT_LINE);
    binary_expand_op_1(B, numStage, ny, num, cptr - 1, den);
  }
  if (Q < 1.0) {
    cptr = 0;
  } else {
    cptr = static_cast<int32_T>(Q);
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_den, 2, &oc_emlrtRTEI, true);
  i = c_den->size[0] * c_den->size[1];
  c_den->size[0] = den->size[0];
  c_den->size[1] = cptr;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(c_den, i, &oc_emlrtRTEI);
  profileLoopStart("getCoeffsAndInitialConditions_loop_7", __LINE__,
                   (cptr - 1) + 1, "");
  for (i = 0; i < cptr; i++) {
    profileLoopStart("getCoeffsAndInitialConditions_loop_9", __LINE__,
                     (den->size[0] - 1) + 1, "");
    for (thism = 0; thism < den->size[0]; thism++) {
      c_den->data[thism + c_den->size[0] * i] =
          den->data[thism + den->size[0] * i] / den->data[thism];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  vlen = static_cast<int32_T>(numStage);
  if (Q < 1.0) {
    cptr = 0;
  } else {
    cptr = static_cast<int32_T>(Q);
  }
  profileLoopStart("getCoeffsAndInitialConditions_loop_10", __LINE__,
                   (cptr - 1) + 1, "");
  for (i = 0; i < cptr; i++) {
    profileLoopStart("getCoeffsAndInitialConditions_loop_11", __LINE__,
                     (vlen - 1) + 1, "");
    for (thism = 0; thism < vlen; thism++) {
      A->data[thism + A->size[0] * i] =
          c_den->data[thism + static_cast<int32_T>(numStage) * i];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_den);
  if (M > 1.0) {
    int32_T i7;
    int32_T i9;
    i = zi->size[0] * zi->size[1];
    zi->size[0] = static_cast<int32_T>(M - 1.0);
    zi->size[1] = static_cast<int32_T>(numStage);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(zi, i, &pc_emlrtRTEI);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&rhs, 1, &ed_emlrtRTEI, true);
    i = rhs->size[0];
    rhs->size[0] = static_cast<int32_T>(M - 1.0);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(rhs, i, &qc_emlrtRTEI);
    if (static_cast<int32_T>((M - 1.0) - 1.0) + 1 < 2) {
      ny = 0;
      vlen = -1;
    } else {
      ny = 1;
      vlen = static_cast<int32_T>((M - 1.0) - 1.0);
    }
    if (static_cast<real_T>(static_cast<int32_T>(M - 1.0)) - 1.0 < 1.0) {
      i7 = 1;
    } else {
      i7 = static_cast<int32_T>(M - 1.0);
    }
    if (static_cast<int32_T>((M - 1.0) - 1.0) < 1) {
      cptr = 0;
    } else {
      cptr = static_cast<int32_T>((M - 1.0) - 1.0);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&rowIdx, 2, &rc_emlrtRTEI, true);
    i = rowIdx->size[0] * rowIdx->size[1];
    rowIdx->size[0] = 1;
    rowIdx->size[1] =
        (((static_cast<int32_T>((M - 1.0) - 1.0) + vlen) - ny) + cptr) + 2;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(rowIdx, i, &rc_emlrtRTEI);
    thism = static_cast<int32_T>((M - 1.0) - 1.0);
    profileLoopStart("getCoeffsAndInitialConditions_loop_12", __LINE__,
                     thism + 1, "");
    for (i = 0; i <= thism; i++) {
      rowIdx->data[i] = static_cast<real_T>(i) + 1.0;
    }
    profileLoopEnd();
    thism = vlen - ny;
    profileLoopStart("getCoeffsAndInitialConditions_loop_13", __LINE__,
                     thism + 1, "");
    for (i = 0; i <= thism; i++) {
      rowIdx->data[(i + static_cast<int32_T>((M - 1.0) - 1.0)) + 1] =
          static_cast<real_T>(ny + i) + 1.0;
    }
    profileLoopEnd();
    profileLoopStart("getCoeffsAndInitialConditions_loop_14", __LINE__,
                     (cptr - 1) + 1, "");
    for (i = 0; i < cptr; i++) {
      rowIdx->data[(((i + static_cast<int32_T>((M - 1.0) - 1.0)) + vlen) - ny) +
                   2] = static_cast<real_T>(i) + 1.0;
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&colIdx, 2, &sc_emlrtRTEI, true);
    i = colIdx->size[0] * colIdx->size[1];
    colIdx->size[0] = 1;
    colIdx->size[1] =
        ((((static_cast<int32_T>(M - 1.0) + vlen) - ny) + vlen) - ny) + 2;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(colIdx, i, &sc_emlrtRTEI);
    thism = static_cast<int32_T>(M - 1.0);
    profileLoopStart("getCoeffsAndInitialConditions_loop_15", __LINE__,
                     (thism - 1) + 1, "");
    for (i = 0; i < thism; i++) {
      colIdx->data[i] = 1.0;
    }
    profileLoopEnd();
    thism = vlen - ny;
    profileLoopStart("getCoeffsAndInitialConditions_loop_16", __LINE__,
                     thism + 1, "");
    for (i = 0; i <= thism; i++) {
      colIdx->data[i + static_cast<int32_T>(M - 1.0)] =
          static_cast<real_T>(ny + i) + 1.0;
    }
    profileLoopEnd();
    thism = vlen - ny;
    profileLoopStart("getCoeffsAndInitialConditions_loop_17", __LINE__,
                     thism + 1, "");
    for (i = 0; i <= thism; i++) {
      colIdx->data[(((i + static_cast<int32_T>(M - 1.0)) + vlen) - ny) + 1] =
          static_cast<real_T>(ny + i) + 1.0;
    }
    profileLoopEnd();
    i9 = static_cast<int32_T>(numStage);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&y_d, 1, &fd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&y_colidx, 1, &fd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&y_rowidx, 1, &fd_emlrtRTEI, true);
    if (static_cast<int32_T>(numStage) - 1 >= 0) {
      if (M < 3.0) {
        i10 = 0;
        i11 = 0;
      } else {
        i10 = 2;
        i11 = static_cast<int32_T>(M);
      }
      loop_ub = i11 - i10;
      b_loop_ub = i7;
      nc = colIdx->size[1];
      b_ns = rowIdx->size[1];
      c_ns = colIdx->size[1];
      numalloc = colIdx->size[1];
      if (numalloc < 1) {
        numalloc = 1;
      }
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&vals, 2, &tc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&ridxInt, 1, &gd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cidxInt, 1, &hd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&sortedIndices, 1, &id_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&t, 1, &xc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_t, 1, &xc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&zik, 1, &ad_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&in_d, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&in_colidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&in_rowidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_in_d, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_in_colidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_in_rowidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_in_d, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&c_in_colidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&c_in_rowidx, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&outBuff, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_outBuff, 1, &kd_emlrtRTEI, true);
    profileLoopStart("getCoeffsAndInitialConditions_loop_18", __LINE__,
                     (i9 - 1) + 1, "");
    for (int32_T ns{0}; ns < i9; ns++) {
      i = vals->size[0] * vals->size[1];
      vals->size[0] = 1;
      vals->size[1] = (((i11 - i10) + i7) + i7) - 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(vals, i, &tc_emlrtRTEI);
      vals->data[0] = A->data[ns + A->size[0]] + 1.0;
      profileLoopStart("getCoeffsAndInitialConditions_loop_19", __LINE__,
                       (loop_ub - 1) + 1, "");
      for (i = 0; i < loop_ub; i++) {
        vals->data[i + 1] = A->data[ns + A->size[0] * (i10 + i)];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_20", __LINE__,
                       (b_loop_ub - 2) + 1, "");
      for (i = 0; i <= b_loop_ub - 2; i++) {
        vals->data[((i + i11) - i10) + 1] = 1.0;
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_21", __LINE__,
                       (b_loop_ub - 2) + 1, "");
      for (i = 0; i <= b_loop_ub - 2; i++) {
        vals->data[((i + i11) - i10) + i7] = -1.0;
      }
      profileLoopEnd();
      M = B->data[ns];
      cptr = rhs->size[0];
      i = rhs->size[0];
      rhs->size[0] = cptr;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(rhs, i, &uc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_22", __LINE__,
                       (cptr - 1) + 1, "");
      for (i = 0; i < cptr; i++) {
        rhs->data[i] = B->data[ns + B->size[0] * (i + 1)] -
                       M * A->data[ns + A->size[0] * (i + 1)];
      }
      profileLoopEnd();
      i = ridxInt->size[0];
      ridxInt->size[0] = rowIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(ridxInt, i, &vc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_23", __LINE__,
                       (b_ns - 1) + 1, "");
      for (vlen = 0; vlen < b_ns; vlen++) {
        ridxInt->data[vlen] = static_cast<int32_T>(rowIdx->data[vlen]);
      }
      profileLoopEnd();
      i = cidxInt->size[0];
      cidxInt->size[0] = colIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(cidxInt, i, &vc_emlrtRTEI);
      i = sortedIndices->size[0];
      sortedIndices->size[0] = colIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(sortedIndices, i, &wc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_24", __LINE__,
                       (c_ns - 1) + 1, "");
      for (vlen = 0; vlen < c_ns; vlen++) {
        cidxInt->data[vlen] = static_cast<int32_T>(colIdx->data[vlen]);
        sortedIndices->data[vlen] = vlen + 1;
      }
      profileLoopEnd();
      nvtxMarkA("#introsort#" MW_AT_LINE);
      internal::introsort(sortedIndices, cidxInt->size[0], cidxInt, ridxInt);
      ny = cidxInt->size[0];
      i = t->size[0];
      t->size[0] = cidxInt->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(t, i, &xc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_25", __LINE__,
                       (cidxInt->size[0] - 1) + 1, "");
      for (i = 0; i < cidxInt->size[0]; i++) {
        t->data[i] = cidxInt->data[i];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_26", __LINE__,
                       (ny - 1) + 1, "");
      for (vlen = 0; vlen < ny; vlen++) {
        cidxInt->data[vlen] = t->data[sortedIndices->data[vlen] - 1];
      }
      profileLoopEnd();
      ny = ridxInt->size[0];
      i = b_t->size[0];
      b_t->size[0] = ridxInt->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(b_t, i, &xc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_27", __LINE__,
                       (ridxInt->size[0] - 1) + 1, "");
      for (i = 0; i < ridxInt->size[0]; i++) {
        b_t->data[i] = ridxInt->data[i];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_28", __LINE__,
                       (ny - 1) + 1, "");
      for (vlen = 0; vlen < ny; vlen++) {
        ridxInt->data[vlen] = b_t->data[sortedIndices->data[vlen] - 1];
      }
      profileLoopEnd();
      vlen = ridxInt->size[0];
      thism = ridxInt->data[0];
      profileLoopStart("getCoeffsAndInitialConditions_loop_29", __LINE__,
                       (vlen - 2) + 1, "");
      for (ny = 0; ny <= vlen - 2; ny++) {
        if (thism < ridxInt->data[ny + 1]) {
          thism = ridxInt->data[ny + 1];
        }
      }
      profileLoopEnd();
      ny = cidxInt->data[cidxInt->size[0] - 1];
      i = y_d->size[0];
      y_d->size[0] = numalloc;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(y_d, i, &yc_emlrtRTEI);
      if (numalloc - 1 >= 0) {
        std::memset(&y_d->data[0], 0,
                    static_cast<uint32_T>(numalloc) * sizeof(real_T));
      }
      i = y_colidx->size[0];
      y_colidx->size[0] = cidxInt->data[cidxInt->size[0] - 1] + 1;
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(y_colidx, i, &yc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_30", __LINE__,
                       cidxInt->data[cidxInt->size[0] - 1] + 1, "");
      for (i = 0; i <= cidxInt->data[cidxInt->size[0] - 1]; i++) {
        y_colidx->data[i] = 0;
      }
      profileLoopEnd();
      y_colidx->data[0] = 1;
      i = y_rowidx->size[0];
      y_rowidx->size[0] = numalloc;
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(y_rowidx, i, &yc_emlrtRTEI);
      if (numalloc - 1 >= 0) {
        std::memset(&y_rowidx->data[0], 0,
                    static_cast<uint32_T>(numalloc) * sizeof(int32_T));
      }
      cptr = 0;
      profileLoopStart("getCoeffsAndInitialConditions_loop_31", __LINE__,
                       (ny - 1) + 1, "");
      for (vlen = 0; vlen < ny; vlen++) {
        nvtxRangePushA(
            "#loop#getCoeffsAndInitialConditions_whileloop_0##" MW_AT_LINE);
        while ((cptr + 1 <= nc) && (cidxInt->data[cptr] == vlen + 1)) {
          y_rowidx->data[cptr] = ridxInt->data[cptr];
          cptr++;
        }
        nvtxRangePop();
        y_colidx->data[vlen + 1] = cptr + 1;
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_32", __LINE__,
                       (nc - 1) + 1, "");
      for (vlen = 0; vlen < nc; vlen++) {
        y_d->data[vlen] = vals->data[sortedIndices->data[vlen] - 1];
      }
      profileLoopEnd();
      ny = cidxInt->data[cidxInt->size[0] - 1];
      nvtxMarkA("#sparse_fillIn#" MW_AT_LINE);
      sparse_fillIn(y_d, y_colidx, y_rowidx);
      if ((thism == 0) || (cidxInt->data[cidxInt->size[0] - 1] == 0)) {
        i = zik->size[0];
        zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(zik, i, &ad_emlrtRTEI);
        if (ny - 1 >= 0) {
          std::memset(&zik->data[0], 0,
                      static_cast<uint32_T>(ny) * sizeof(real_T));
        }
      } else if (rhs->size[0] == cidxInt->data[cidxInt->size[0] - 1]) {
        cs_di *b_cxA;
        cs_din *b_N;
        cs_dis *b_S;
        if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
          nvtxMarkA("#sparse_ctranspose#" MW_AT_LINE);
          sparse_ctranspose(y_d, y_colidx, y_rowidx, thism,
                            cidxInt->data[cidxInt->size[0] - 1], b_in_d,
                            b_in_colidx, b_in_rowidx, &cptr, &ny);
          b_cxA = makeCXSparseMatrix(
              b_in_colidx->data[b_in_colidx->size[0] - 1] - 1, ny, cptr,
              &b_in_colidx->data[0], &b_in_rowidx->data[0], &b_in_d->data[0]);
        } else {
          b_cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
                                     cidxInt->data[cidxInt->size[0] - 1], thism,
                                     &y_colidx->data[0], &y_rowidx->data[0],
                                     &y_d->data[0]);
        }
        b_S = cs_di_sqr(2, b_cxA, 0);
        b_N = cs_di_lu(b_cxA, b_S, 1);
        cs_di_spfree(b_cxA);
        if (b_N == nullptr) {
          cs_di *c_cxA;
          cs_din *c_N;
          cs_dis *c_S;
          nvtxMarkA("#c_warning#" MW_AT_LINE);
          internal::c_warning();
          cs_di_sfree(b_S);
          cs_di_nfree(b_N);
          if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
            nvtxMarkA("#sparse_ctranspose#" MW_AT_LINE);
            sparse_ctranspose(y_d, y_colidx, y_rowidx, thism,
                              cidxInt->data[cidxInt->size[0] - 1], c_in_d,
                              c_in_colidx, c_in_rowidx, &cptr, &ny);
            c_cxA = makeCXSparseMatrix(
                c_in_colidx->data[c_in_colidx->size[0] - 1] - 1, ny, cptr,
                &c_in_colidx->data[0], &c_in_rowidx->data[0], &c_in_d->data[0]);
          } else {
            c_cxA = makeCXSparseMatrix(
                y_colidx->data[y_colidx->size[0] - 1] - 1,
                cidxInt->data[cidxInt->size[0] - 1], thism, &y_colidx->data[0],
                &y_rowidx->data[0], &y_d->data[0]);
          }
          c_S = cs_di_sqr(2, c_cxA, 1);
          c_N = cs_di_qr(c_cxA, c_S);
          cs_di_spfree(c_cxA);
          qr_rank_di(c_N, &M);
          i = zik->size[0];
          zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(zik, i, &bd_emlrtRTEI);
          if (rhs->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
            i = b_outBuff->size[0];
            b_outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_outBuff, i, &dd_emlrtRTEI);
          } else {
            i = b_outBuff->size[0];
            b_outBuff->size[0] = rhs->size[0];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_outBuff, i, &cd_emlrtRTEI);
          }
          thism = rhs->size[0];
          profileLoopStart("getCoeffsAndInitialConditions_loop_37", __LINE__,
                           (thism - 1) + 1, "");
          for (i = 0; i < thism; i++) {
            b_outBuff->data[i] = rhs->data[i];
          }
          profileLoopEnd();
          solve_from_qr_di(c_N, c_S, (double *)&b_outBuff->data[0],
                           rhs->size[0], cidxInt->data[cidxInt->size[0] - 1]);
          cptr = cidxInt->data[cidxInt->size[0] - 1];
          profileLoopStart("getCoeffsAndInitialConditions_loop_38", __LINE__,
                           (cptr - 1) + 1, "");
          for (i = 0; i < cptr; i++) {
            zik->data[i] = b_outBuff->data[i];
          }
          profileLoopEnd();
          cs_di_sfree(c_S);
          cs_di_nfree(c_N);
        } else {
          i = zik->size[0];
          zik->size[0] = rhs->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(zik, i, &ad_emlrtRTEI);
          profileLoopStart("getCoeffsAndInitialConditions_loop_34", __LINE__,
                           (rhs->size[0] - 1) + 1, "");
          for (i = 0; i < rhs->size[0]; i++) {
            zik->data[i] = rhs->data[i];
          }
          profileLoopEnd();
          solve_from_lu_di(b_N, b_S, (double *)&zik->data[0], rhs->size[0]);
          cs_di_sfree(b_S);
          cs_di_nfree(b_N);
        }
      } else {
        cs_di *cxA;
        cs_din *N;
        cs_dis *S;
        if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
          nvtxMarkA("#sparse_ctranspose#" MW_AT_LINE);
          sparse_ctranspose(y_d, y_colidx, y_rowidx, thism,
                            cidxInt->data[cidxInt->size[0] - 1], in_d,
                            in_colidx, in_rowidx, &cptr, &ny);
          cxA = makeCXSparseMatrix(in_colidx->data[in_colidx->size[0] - 1] - 1,
                                   ny, cptr, &in_colidx->data[0],
                                   &in_rowidx->data[0], &in_d->data[0]);
        } else {
          cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
                                   cidxInt->data[cidxInt->size[0] - 1], thism,
                                   &y_colidx->data[0], &y_rowidx->data[0],
                                   &y_d->data[0]);
        }
        S = cs_di_sqr(2, cxA, 1);
        N = cs_di_qr(cxA, S);
        cs_di_spfree(cxA);
        cptr = qr_rank_di(N, &M);
        if (thism > cidxInt->data[cidxInt->size[0] - 1]) {
          thism = cidxInt->data[cidxInt->size[0] - 1];
        }
        if (cptr < thism) {
          char_T str[14];
          y = nullptr;
          m = emlrtCreateCharArray(2, &iv[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 6, m, &rfmt[0]);
          emlrtAssign(&y, m);
          b_y = nullptr;
          m1 = emlrtCreateDoubleScalar(M);
          emlrtAssign(&b_y, m1);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(y, b_y, &d_emlrtMCI),
                           "<output of sprintf>", str);
          nvtxMarkA("#warning#" MW_AT_LINE);
          internal::warning(cptr, str);
        }
        i = zik->size[0];
        zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(zik, i, &bd_emlrtRTEI);
        if (rhs->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
          i = outBuff->size[0];
          outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(outBuff, i, &dd_emlrtRTEI);
        } else {
          i = outBuff->size[0];
          outBuff->size[0] = rhs->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(outBuff, i, &cd_emlrtRTEI);
        }
        thism = rhs->size[0];
        profileLoopStart("getCoeffsAndInitialConditions_loop_35", __LINE__,
                         (thism - 1) + 1, "");
        for (i = 0; i < thism; i++) {
          outBuff->data[i] = rhs->data[i];
        }
        profileLoopEnd();
        solve_from_qr_di(N, S, (double *)&outBuff->data[0], rhs->size[0],
                         cidxInt->data[cidxInt->size[0] - 1]);
        cptr = cidxInt->data[cidxInt->size[0] - 1];
        profileLoopStart("getCoeffsAndInitialConditions_loop_36", __LINE__,
                         (cptr - 1) + 1, "");
        for (i = 0; i < cptr; i++) {
          zik->data[i] = outBuff->data[i];
        }
        profileLoopEnd();
        cs_di_sfree(S);
        cs_di_nfree(N);
      }
      cptr = zi->size[0];
      profileLoopStart("getCoeffsAndInitialConditions_loop_33", __LINE__,
                       (cptr - 1) + 1, "");
      for (i = 0; i < cptr; i++) {
        zi->data[i + zi->size[0] * ns] = zik->data[i];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_outBuff);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&outBuff);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&c_in_rowidx);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&c_in_colidx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c_in_d);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&b_in_rowidx);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&b_in_colidx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_in_d);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&in_rowidx);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&in_colidx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&in_d);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&zik);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&b_t);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&t);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&sortedIndices);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&cidxInt);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&ridxInt);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&y_rowidx);
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&y_colidx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&y_d);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&vals);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&colIdx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&rowIdx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&rhs);
  } else {
    zi->size[0] = 0;
    zi->size[1] = static_cast<int32_T>(numStage);
  }
  *Letr = std::fmax(1.0, 3.0 * ord);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

} // namespace coder
static int32_T div_s32(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  nvtxRangePushA("#fcn#div_s32#" MW_AT_LOCATION);
  if (denominator == 0) {
    emlrtDivisionByZeroErrorR2012b(nullptr, emlrtRootTLSGlobal);
  } else {
    uint32_T b;
    uint32_T tempAbsQuotient;
    if (numerator < 0) {
      tempAbsQuotient = ~static_cast<uint32_T>(numerator) + 1U;
    } else {
      tempAbsQuotient = static_cast<uint32_T>(numerator);
    }
    if (denominator < 0) {
      b = ~static_cast<uint32_T>(denominator) + 1U;
    } else {
      b = static_cast<uint32_T>(denominator);
    }
    tempAbsQuotient /= b;
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }
  nvtxRangePop();
  return quotient;
}

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[14])
{
  emlrtMsgIdentifier thisId;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
  nvtxRangePop();
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[14])
{
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
  nvtxRangePop();
}

//
//
namespace coder {
void filtfilt(const emxArray_real_T *ctf, const emxArray_real_T *varargin_1,
              const emxArray_real_T *varargin_2, emxArray_real_T *y)
{
  emxArray_real_T b_gpu_A;
  emxArray_real_T b_gpu_B;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_yc2;
  emxArray_real_T b_gpu_yc3;
  emxArray_real_T b_gpu_yc5;
  emxArray_real_T b_gpu_ytemp;
  emxArray_real_T b_gpu_zi;
  emxArray_real_T b_gpu_zo;
  emxArray_real_T c_gpu_A;
  emxArray_real_T c_gpu_B;
  emxArray_real_T c_gpu_xt;
  emxArray_real_T c_gpu_yc2;
  emxArray_real_T c_gpu_yc3;
  emxArray_real_T c_gpu_ytemp;
  emxArray_real_T c_gpu_zi;
  emxArray_real_T c_gpu_zo;
  emxArray_real_T d_gpu_A;
  emxArray_real_T d_gpu_B;
  emxArray_real_T d_gpu_yc2;
  emxArray_real_T d_gpu_yc3;
  emxArray_real_T d_gpu_zi;
  emxArray_real_T d_gpu_zo;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_B;
  emxArray_real_T e_gpu_zi;
  emxArray_real_T e_gpu_zo;
  emxArray_real_T f_gpu_A;
  emxArray_real_T f_gpu_B;
  emxArray_real_T f_gpu_zi;
  emxArray_real_T f_gpu_zo;
  emxArray_real_T g_gpu_A;
  emxArray_real_T g_gpu_B;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu__1;
  emxArray_real_T gpu__2;
  emxArray_real_T gpu__3;
  emxArray_real_T gpu__4;
  emxArray_real_T gpu_r2;
  emxArray_real_T gpu_xc1;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_yc2;
  emxArray_real_T gpu_yc3;
  emxArray_real_T gpu_yc5;
  emxArray_real_T gpu_ytemp;
  emxArray_real_T gpu_zi;
  emxArray_real_T gpu_zo;
  emxArray_real_T h_gpu_A;
  emxArray_real_T h_gpu_B;
  emxArray_real_T i_gpu_A;
  emxArray_real_T i_gpu_B;
  emxArray_real_T j_gpu_A;
  emxArray_real_T j_gpu_B;
  emxArray_real_T k_gpu_A;
  emxArray_real_T k_gpu_B;
  emxArray_real_T l_gpu_A;
  emxArray_real_T l_gpu_B;
  emxArray_real_T *A;
  emxArray_real_T *B;
  emxArray_real_T *X;
  emxArray_real_T *Y;
  emxArray_real_T *b_cpu_A;
  emxArray_real_T *b_cpu_B;
  emxArray_real_T *b_cpu_xt;
  emxArray_real_T *b_cpu_yc2;
  emxArray_real_T *b_cpu_yc3;
  emxArray_real_T *b_cpu_yc5;
  emxArray_real_T *b_cpu_ytemp;
  emxArray_real_T *b_cpu_zi;
  emxArray_real_T *b_cpu_zo;
  emxArray_real_T *b_xc1;
  emxArray_real_T *c_cpu_A;
  emxArray_real_T *c_cpu_B;
  emxArray_real_T *c_cpu_xt;
  emxArray_real_T *c_cpu_yc2;
  emxArray_real_T *c_cpu_yc3;
  emxArray_real_T *c_cpu_ytemp;
  emxArray_real_T *c_cpu_zi;
  emxArray_real_T *c_cpu_zo;
  emxArray_real_T *cpu_A;
  emxArray_real_T *cpu_B;
  emxArray_real_T *cpu__1;
  emxArray_real_T *cpu__2;
  emxArray_real_T *cpu__3;
  emxArray_real_T *cpu__4;
  emxArray_real_T *cpu_r2;
  emxArray_real_T *cpu_xc1;
  emxArray_real_T *cpu_xt;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_yc2;
  emxArray_real_T *cpu_yc3;
  emxArray_real_T *cpu_yc5;
  emxArray_real_T *cpu_ytemp;
  emxArray_real_T *cpu_zi;
  emxArray_real_T *cpu_zo;
  emxArray_real_T *d_cpu_A;
  emxArray_real_T *d_cpu_B;
  emxArray_real_T *d_cpu_yc2;
  emxArray_real_T *d_cpu_yc3;
  emxArray_real_T *d_cpu_zi;
  emxArray_real_T *d_cpu_zo;
  emxArray_real_T *den;
  emxArray_real_T *e_cpu_A;
  emxArray_real_T *e_cpu_B;
  emxArray_real_T *e_cpu_zi;
  emxArray_real_T *e_cpu_zo;
  emxArray_real_T *f_cpu_A;
  emxArray_real_T *f_cpu_B;
  emxArray_real_T *f_cpu_zi;
  emxArray_real_T *f_cpu_zo;
  emxArray_real_T *g_cpu_A;
  emxArray_real_T *g_cpu_B;
  emxArray_real_T *h_cpu_A;
  emxArray_real_T *h_cpu_B;
  emxArray_real_T *i_cpu_A;
  emxArray_real_T *i_cpu_B;
  emxArray_real_T *j_cpu_A;
  emxArray_real_T *j_cpu_B;
  emxArray_real_T *k_cpu_A;
  emxArray_real_T *k_cpu_B;
  emxArray_real_T *l_cpu_A;
  emxArray_real_T *l_cpu_B;
  emxArray_real_T *num;
  emxArray_real_T *r;
  emxArray_real_T *r1;
  emxArray_real_T *xc1;
  emxArray_real_T *xt;
  emxArray_real_T *ytemp;
  emxArray_real_T *zi;
  real_T Letr;
  real_T P;
  real_T Q;
  real_T numStage;
  int32_T i;
  boolean_T A_outdatedOnCpu;
  boolean_T A_outdatedOnGpu;
  boolean_T B_outdatedOnCpu;
  boolean_T B_outdatedOnGpu;
  boolean_T a__2_outdatedOnGpu;
  boolean_T a__4_outdatedOnGpu;
  boolean_T b_zo_outdatedOnCpu;
  boolean_T b_zo_outdatedOnGpu;
  boolean_T r2_outdatedOnCpu;
  boolean_T xIsRow;
  boolean_T xt_outdatedOnCpu;
  boolean_T xt_outdatedOnGpu;
  boolean_T yc2_outdatedOnCpu;
  boolean_T yc3_outdatedOnGpu;
  boolean_T yc5_outdatedOnCpu;
  boolean_T yc5_outdatedOnGpu;
  boolean_T zi_outdatedOnCpu;
  boolean_T zi_outdatedOnGpu;
  boolean_T zo_outdatedOnCpu;
  boolean_T zo_outdatedOnGpu;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#filtfilt#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_ytemp);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_r2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&g_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&g_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&l_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&l_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&f_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&f_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&f_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&k_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&k_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_xt);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&j_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&j_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_xt);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&i_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&i_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&h_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&h_gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yc5);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_yc5);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu__2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&f_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu__4);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_ytemp);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu__3);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_zo);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu__1);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_xt);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_xc1);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_ytemp);
  r2_outdatedOnCpu = false;
  yc3_outdatedOnGpu = false;
  b_zo_outdatedOnCpu = false;
  b_zo_outdatedOnGpu = false;
  yc2_outdatedOnCpu = false;
  yc5_outdatedOnCpu = false;
  zo_outdatedOnCpu = false;
  zo_outdatedOnGpu = false;
  yc5_outdatedOnGpu = false;
  a__2_outdatedOnGpu = false;
  xt_outdatedOnCpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&X, 3, &b_emlrtRTEI, true);
  i = X->size[0] * X->size[1] * X->size[2];
  X->size[0] = varargin_2->size[0];
  X->size[1] = varargin_2->size[1];
  X->size[2] = varargin_2->size[2];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(X, i, &emlrtRTEI);
  profileLoopStart(
      "filtfilt_loop_0", __LINE__,
      (varargin_2->size[0] * varargin_2->size[1] * varargin_2->size[2] - 1) + 1,
      "1675");
  for (i = 0;
       i < varargin_2->size[0] * varargin_2->size[1] * varargin_2->size[2];
       i++) {
    X->data[i] = varargin_2->data[i];
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&num, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&den, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#filtfiltParser#" MW_AT_LINE);
  filtfiltParser(ctf, varargin_1, num, den, &numStage, &P, &Q, &xIsRow,
                 &yc5_outdatedOnGpu);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&B, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&A, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&zi, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&Y, 1, &i_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_ytemp, 1, &ac_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_xc1, 2, &bc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&xt, 1, &k_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_xt, 2, &cc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu__1, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_zo, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu__3, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_zo, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yc2, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_zo, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_yc2, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_zo, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_ytemp, 1, &dc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yc3, 2, &ec_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_yc3, 1, &fc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu__4, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_zo, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu__2, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_zo, 1, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yc5, 2, &gc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_yc5, 1, &hc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&r, 2, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&xc1, 2, &j_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_B, 2, &m_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_A, 2, &o_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_zi, 2, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_B, 2, &u_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_A, 2, &v_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_B, 2, &n_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_A, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_xt, 1, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_zi, 1, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_B, 2, &w_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_A, 2, &y_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_y, 1, &bb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_B, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_A, 2, &t_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_zi, 1, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&ytemp, 1, &x_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_B, 2, &cb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_A, 2, &eb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_zi, 1, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&r1, 2, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_xc1, 2, &db_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&g_cpu_B, 2, &fb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&g_cpu_A, 2, &gb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&h_cpu_B, 2, &kb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&h_cpu_A, 2, &mb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_xt, 1, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&i_cpu_B, 2, &jb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&i_cpu_A, 2, &lb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_yc3, 2, &nb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_zi, 2, &ob_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&j_cpu_B, 2, &pb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&j_cpu_A, 2, &rb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_yc3, 1, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_zi, 1, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&k_cpu_B, 2, &qb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&k_cpu_A, 2, &sb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_yc2, 2, &tb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&l_cpu_B, 2, &ub_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&l_cpu_A, 2, &wb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_yc2, 1, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_r2, 2, &ic_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_ytemp, 1, &hb_emlrtRTEI, true);
  if ((!xIsRow) || (!yc5_outdatedOnGpu) ||
      ((X->size[0] == 0) || (X->size[1] == 0) || (X->size[2] == 0))) {
    y->size[0] = 0;
    y->size[1] = 0;
    y->size[2] = 1;
  } else {
    if ((X->size[2] == 1) && (X->size[0] == 1)) {
      i = X->size[0] * X->size[1] * X->size[2];
      X->size[0] = X->size[1];
      X->size[1] = 1;
      X->size[2] = 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(X, i, &b_emlrtRTEI);
    } else {
      xIsRow = false;
    }
    nvtxMarkA("#getCoeffsAndInitialConditions#" MW_AT_LINE);
    getCoeffsAndInitialConditions(num, den, numStage, P, Q, B, A, zi, &Letr);
    if (X->size[1] * X->size[2] == 1) {
      if (X->size[0] < 10000) {
        int32_T i1;
        yc5_outdatedOnGpu = false;
        a__2_outdatedOnGpu = false;
        i = Y->size[0];
        Y->size[0] = X->size[0];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(Y, i, &e_emlrtRTEI);
        profileLoopStart("filtfilt_loop_2", __LINE__, (X->size[0] - 1) + 1,
                         "1676");
        for (i = 0; i < X->size[0]; i++) {
          Y->data[i] = X->data[i];
        }
        profileLoopEnd();
        i1 = static_cast<int32_T>(numStage);
        profileLoopStart("filtfilt_loop_5", __LINE__, (i1 - 1) + 1, "1677");
        for (int32_T ii{0}; ii < i1; ii++) {
          int32_T b_loop_ub;
          int32_T i10;
          int32_T i8;
          int32_T loop_ub;
          numStage = static_cast<real_T>(Y->size[0]) - Letr;
          if (numStage > static_cast<real_T>(Y->size[0]) - 1.0) {
            loop_ub = 0;
            i8 = 1;
            i10 = -1;
          } else {
            loop_ub = Y->size[0] - 2;
            i8 = -1;
            i10 = static_cast<int32_T>(numStage) - 1;
          }
          numStage = 2.0 * Y->data[0];
          P = 2.0 * Y->data[Y->size[0] - 1];
          yc5_outdatedOnCpu = false;
          i = b_cpu_ytemp->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_cpu_ytemp->size[0] =
              (static_cast<int32_T>(Letr + 1.0) + Y->size[0]) +
              div_s32(i10 - loop_ub, i8);
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(b_cpu_ytemp, i, &l_emlrtRTEI);
          b_loop_ub = static_cast<int32_T>(Letr + 1.0) - 2;
          profileLoopStart("filtfilt_loop_11", __LINE__, b_loop_ub + 1, "1678");
          for (i = 0; i <= b_loop_ub; i++) {
            b_cpu_ytemp->data[i] =
                numStage - Y->data[(static_cast<int32_T>(Letr + 1.0) - i) - 1];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          b_loop_ub = Y->size[0];
          profileLoopStart("filtfilt_loop_14", __LINE__, (b_loop_ub - 1) + 1,
                           "1679");
          for (i = 0; i < b_loop_ub; i++) {
            b_cpu_ytemp->data[(i + static_cast<int32_T>(Letr + 1.0)) - 1] =
                Y->data[i];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_loop_ub = div_s32(i10 - loop_ub, i8);
          profileLoopStart("filtfilt_loop_15", __LINE__, b_loop_ub + 1, "1680");
          for (i = 0; i <= b_loop_ub; i++) {
            b_cpu_ytemp
                ->data[((i + static_cast<int32_T>(Letr + 1.0)) + Y->size[0]) -
                       1] = P - Y->data[loop_ub + i8 * i];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = e_cpu_B->size[0] * e_cpu_B->size[1];
          e_cpu_B->size[0] = 1;
          e_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(e_cpu_B, i, &q_emlrtRTEI);
          profileLoopStart("filtfilt_loop_19", __LINE__, (B->size[1] - 1) + 1,
                           "1681");
          for (i = 0; i < B->size[1]; i++) {
            e_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = e_cpu_A->size[0] * e_cpu_A->size[1];
          e_cpu_A->size[0] = 1;
          e_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(e_cpu_A, i, &t_emlrtRTEI);
          profileLoopStart("filtfilt_loop_22", __LINE__, (A->size[1] - 1) + 1,
                           "1682");
          for (i = 0; i < A->size[1]; i++) {
            e_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = c_cpu_zi->size[0];
          c_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(c_cpu_zi, i, &f_emlrtRTEI);
          profileLoopStart("filtfilt_loop_24", __LINE__, (zi->size[0] - 1) + 1,
                           "1683");
          for (i = 0; i < zi->size[0]; i++) {
            c_cpu_zi->data[i] =
                zi->data[i + zi->size[0] * ii] * b_cpu_ytemp->data[0];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#filter#" MW_AT_LINE);
          filter(e_cpu_B, &B_outdatedOnCpu, &gpu_B, &B_outdatedOnGpu, e_cpu_A,
                 &A_outdatedOnCpu, &gpu_A, &A_outdatedOnGpu, b_cpu_ytemp,
                 &gpu_ytemp, &yc5_outdatedOnCpu, c_cpu_zi, &zi_outdatedOnCpu,
                 &gpu_zi, &zi_outdatedOnGpu, cpu_ytemp, &yc5_outdatedOnGpu,
                 &b_gpu_ytemp, &a__2_outdatedOnGpu);
          loop_ub = cpu_ytemp->size[0] - 1;
          i = ytemp->size[0];
          ytemp->size[0] = cpu_ytemp->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(ytemp, i, &x_emlrtRTEI);
          profileLoopStart("filtfilt_loop_28", __LINE__, loop_ub + 1, "1684");
          for (i = 0; i <= loop_ub; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_ytemp, &b_gpu_ytemp);
            }
            yc5_outdatedOnGpu = false;
            ytemp->data[i] = cpu_ytemp->data[loop_ub - i];
          }
          profileLoopEnd();
          yc5_outdatedOnGpu = false;
          a__2_outdatedOnGpu = false;
          i = cpu_ytemp->size[0];
          cpu_ytemp->size[0] = ytemp->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(cpu_ytemp, i, &ab_emlrtRTEI);
          profileLoopStart("filtfilt_loop_30", __LINE__,
                           (ytemp->size[0] - 1) + 1, "1685");
          for (i = 0; i < ytemp->size[0]; i++) {
            cpu_ytemp->data[i] = ytemp->data[i];
            a__2_outdatedOnGpu = true;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = f_cpu_B->size[0] * f_cpu_B->size[1];
          f_cpu_B->size[0] = 1;
          f_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(f_cpu_B, i, &cb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_33", __LINE__, (B->size[1] - 1) + 1,
                           "1686");
          for (i = 0; i < B->size[1]; i++) {
            f_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = 1;
          f_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(f_cpu_A, i, &eb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_35", __LINE__, (A->size[1] - 1) + 1,
                           "1687");
          for (i = 0; i < A->size[1]; i++) {
            f_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = d_cpu_zi->size[0];
          d_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(d_cpu_zi, i, &f_emlrtRTEI);
          profileLoopStart("filtfilt_loop_39", __LINE__, (zi->size[0] - 1) + 1,
                           "1688");
          for (i = 0; i < zi->size[0]; i++) {
            d_cpu_zi->data[i] =
                zi->data[i + zi->size[0] * ii] * cpu_ytemp->data[0];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
          yc5_outdatedOnCpu = false;
          i = c_cpu_ytemp->size[0];
          c_cpu_ytemp->size[0] = cpu_ytemp->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(c_cpu_ytemp, i, &hb_emlrtRTEI);
          b_loop_ub = cpu_ytemp->size[0] - 1;
          profileLoopStart("filtfilt_loop_42", __LINE__, b_loop_ub + 1, "1689");
          for (i = 0; i <= b_loop_ub; i++) {
            c_cpu_ytemp->data[i] = cpu_ytemp->data[i];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#filter#" MW_AT_LINE);
          filter(f_cpu_B, &B_outdatedOnCpu, &b_gpu_B, &B_outdatedOnGpu, f_cpu_A,
                 &A_outdatedOnCpu, &b_gpu_A, &A_outdatedOnGpu, c_cpu_ytemp,
                 &c_gpu_ytemp, &yc5_outdatedOnCpu, d_cpu_zi, &zi_outdatedOnCpu,
                 &b_gpu_zi, &zi_outdatedOnGpu, cpu_ytemp, &yc5_outdatedOnGpu,
                 &b_gpu_ytemp, &a__2_outdatedOnGpu);
          numStage = static_cast<real_T>(cpu_ytemp->size[0]) - Letr;
          if (Letr + 1.0 > numStage) {
            loop_ub = 1;
            i8 = 1;
          } else {
            loop_ub = static_cast<int32_T>(numStage);
            i8 = -1;
          }
          i10 = Y->size[0];
          i = Y->size[0];
          Y->size[0] = i10;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(Y, i, &e_emlrtRTEI);
          profileLoopStart("filtfilt_loop_45", __LINE__, (i10 - 1) + 1, "1690");
          for (i = 0; i < i10; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_ytemp, &b_gpu_ytemp);
            }
            yc5_outdatedOnGpu = false;
            Y->data[i] = cpu_ytemp->data[(loop_ub + i8 * i) - 1];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        i = y->size[0] * y->size[1] * y->size[2];
        y->size[0] = Y->size[0];
        y->size[1] = 1;
        y->size[2] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, i, &i_emlrtRTEI);
        profileLoopStart("filtfilt_loop_8", __LINE__, (Y->size[0] - 1) + 1,
                         "1691");
        for (i = 0; i < Y->size[0]; i++) {
          y->data[i] = Y->data[i];
        }
        profileLoopEnd();
      } else {
        int32_T i1;
        i = y->size[0] * y->size[1] * y->size[2];
        y->size[0] = X->size[0];
        y->size[1] = X->size[1];
        y->size[2] = X->size[2];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, i, &c_emlrtRTEI);
        profileLoopStart("filtfilt_loop_1", __LINE__,
                         (X->size[0] * X->size[1] * X->size[2] - 1) + 1,
                         "1692");
        for (i = 0; i < X->size[0] * X->size[1] * X->size[2]; i++) {
          y->data[i] = X->data[i];
        }
        profileLoopEnd();
        i1 = static_cast<int32_T>(numStage);
        profileLoopStart("filtfilt_loop_4", __LINE__, (i1 - 1) + 1, "1693");
        for (int32_T ii{0}; ii < i1; ii++) {
          int32_T b_i1;
          int32_T b_loop_ub;
          int32_T i10;
          int32_T i8;
          int32_T loop_ub;
          numStage = 2.0 * y->data[0];
          i = static_cast<int32_T>(Letr + 1.0) - 1;
          b_i1 = xt->size[0];
          xt->size[0] = static_cast<int32_T>(Letr + 1.0) - 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(xt, b_i1, &k_emlrtRTEI);
          profileLoopStart("filtfilt_loop_7", __LINE__, (i - 1) + 1, "1694");
          for (b_i1 = 0; b_i1 < i; b_i1++) {
            xt->data[b_i1] =
                -y->data[(static_cast<int32_T>(Letr + 1.0) - b_i1) - 1] +
                numStage;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = c_cpu_B->size[0] * c_cpu_B->size[1];
          c_cpu_B->size[0] = 1;
          c_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(c_cpu_B, i, &n_emlrtRTEI);
          profileLoopStart("filtfilt_loop_12", __LINE__, (B->size[1] - 1) + 1,
                           "1695");
          for (i = 0; i < B->size[1]; i++) {
            c_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = 1;
          c_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(c_cpu_A, i, &p_emlrtRTEI);
          profileLoopStart("filtfilt_loop_16", __LINE__, (A->size[1] - 1) + 1,
                           "1696");
          for (i = 0; i < A->size[1]; i++) {
            c_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          xt_outdatedOnGpu = false;
          i = b_cpu_xt->size[0];
          b_cpu_xt->size[0] = xt->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(b_cpu_xt, i, &s_emlrtRTEI);
          profileLoopStart("filtfilt_loop_18", __LINE__, (xt->size[0] - 1) + 1,
                           "1697");
          for (i = 0; i < xt->size[0]; i++) {
            b_cpu_xt->data[i] = xt->data[i];
            xt_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = b_cpu_zi->size[0];
          b_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(b_cpu_zi, i, &f_emlrtRTEI);
          profileLoopStart("filtfilt_loop_21", __LINE__, (zi->size[0] - 1) + 1,
                           "1698");
          for (i = 0; i < zi->size[0]; i++) {
            b_cpu_zi->data[i] = zi->data[i + zi->size[0] * ii] * xt->data[0];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#b_filter#" MW_AT_LINE);
          b_filter(c_cpu_B, &B_outdatedOnCpu, &c_gpu_B, &B_outdatedOnGpu,
                   c_cpu_A, &A_outdatedOnCpu, &c_gpu_A, &A_outdatedOnGpu,
                   b_cpu_xt, &gpu_xt, &xt_outdatedOnGpu, b_cpu_zi,
                   &zi_outdatedOnCpu, &c_gpu_zi, &zi_outdatedOnGpu, cpu__1,
                   &yc5_outdatedOnGpu, &gpu__1, &a__2_outdatedOnGpu, cpu_zo,
                   &zo_outdatedOnCpu, &gpu_zo, &zo_outdatedOnGpu);
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = d_cpu_B->size[0] * d_cpu_B->size[1];
          d_cpu_B->size[0] = 1;
          d_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(d_cpu_B, i, &w_emlrtRTEI);
          profileLoopStart("filtfilt_loop_26", __LINE__, (B->size[1] - 1) + 1,
                           "1699");
          for (i = 0; i < B->size[1]; i++) {
            d_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = d_cpu_A->size[0] * d_cpu_A->size[1];
          d_cpu_A->size[0] = 1;
          d_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(d_cpu_A, i, &y_emlrtRTEI);
          profileLoopStart("filtfilt_loop_29", __LINE__, (A->size[1] - 1) + 1,
                           "1700");
          for (i = 0; i < A->size[1]; i++) {
            d_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          i = y->size[0];
          yc5_outdatedOnCpu = false;
          b_i1 = cpu_y->size[0];
          cpu_y->size[0] = y->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(cpu_y, b_i1, &bb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_32", __LINE__, (i - 1) + 1, "1701");
          for (b_i1 = 0; b_i1 < i; b_i1++) {
            cpu_y->data[b_i1] = y->data[b_i1];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#b_filter#" MW_AT_LINE);
          b_filter(d_cpu_B, &B_outdatedOnCpu, &d_gpu_B, &B_outdatedOnGpu,
                   d_cpu_A, &A_outdatedOnCpu, &d_gpu_A, &A_outdatedOnGpu, cpu_y,
                   &gpu_y, &yc5_outdatedOnCpu, cpu_zo, &zo_outdatedOnCpu,
                   &gpu_zo, &zo_outdatedOnGpu, b_cpu_yc2, &yc2_outdatedOnCpu,
                   &gpu_yc2, &a__2_outdatedOnGpu, d_cpu_zo, &b_zo_outdatedOnCpu,
                   &b_gpu_zo, &b_zo_outdatedOnGpu);
          numStage = static_cast<real_T>(y->size[0]) - Letr;
          if (numStage > static_cast<real_T>(y->size[0]) - 1.0) {
            loop_ub = 0;
            i8 = 1;
            i10 = -1;
          } else {
            loop_ub = y->size[0] - 2;
            i8 = -1;
            i10 = static_cast<int32_T>(numStage) - 1;
          }
          numStage = 2.0 * y->data[y->size[0] - 1];
          i = xt->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          xt->size[0] = div_s32(i10 - loop_ub, i8) + 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(xt, i, &ib_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_34", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1702");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i10 - loop_ub, i8); i++) {
            xt->data[i] = -y->data[loop_ub + i8 * i] + numStage;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = h_cpu_B->size[0] * h_cpu_B->size[1];
          h_cpu_B->size[0] = 1;
          h_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(h_cpu_B, i, &kb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_38", __LINE__, (B->size[1] - 1) + 1,
                           "1703");
          for (i = 0; i < B->size[1]; i++) {
            h_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = h_cpu_A->size[0] * h_cpu_A->size[1];
          h_cpu_A->size[0] = 1;
          h_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(h_cpu_A, i, &mb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_41", __LINE__, (A->size[1] - 1) + 1,
                           "1704");
          for (i = 0; i < A->size[1]; i++) {
            h_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          xt_outdatedOnGpu = false;
          i = c_cpu_xt->size[0];
          c_cpu_xt->size[0] = xt->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(c_cpu_xt, i, &s_emlrtRTEI);
          profileLoopStart("filtfilt_loop_44", __LINE__, (xt->size[0] - 1) + 1,
                           "1705");
          for (i = 0; i < xt->size[0]; i++) {
            c_cpu_xt->data[i] = xt->data[i];
            xt_outdatedOnGpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#filter#" MW_AT_LINE);
          filter(h_cpu_B, &B_outdatedOnCpu, &e_gpu_B, &B_outdatedOnGpu, h_cpu_A,
                 &A_outdatedOnCpu, &e_gpu_A, &A_outdatedOnGpu, c_cpu_xt,
                 &b_gpu_xt, &xt_outdatedOnGpu, d_cpu_zo, &b_zo_outdatedOnCpu,
                 &b_gpu_zo, &b_zo_outdatedOnGpu, b_cpu_yc3, &yc5_outdatedOnGpu,
                 &gpu_yc3, &yc3_outdatedOnGpu);
          if (b_cpu_yc3->size[0] < 1) {
            loop_ub = 0;
            i8 = 1;
            i10 = -1;
          } else {
            loop_ub = b_cpu_yc3->size[0] - 1;
            i8 = -1;
            i10 = 0;
          }
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = j_cpu_B->size[0] * j_cpu_B->size[1];
          j_cpu_B->size[0] = 1;
          j_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(j_cpu_B, i, &pb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_46", __LINE__, (B->size[1] - 1) + 1,
                           "1706");
          for (i = 0; i < B->size[1]; i++) {
            j_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = j_cpu_A->size[0] * j_cpu_A->size[1];
          j_cpu_A->size[0] = 1;
          j_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(j_cpu_A, i, &rb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_48", __LINE__, (A->size[1] - 1) + 1,
                           "1707");
          for (i = 0; i < A->size[1]; i++) {
            j_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          yc5_outdatedOnCpu = false;
          yc3_outdatedOnGpu = false;
          i = d_cpu_yc3->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          d_cpu_yc3->size[0] = div_s32(i10 - loop_ub, i8) + 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(d_cpu_yc3, i, &s_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_50", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1708");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i10 - loop_ub, i8); i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_yc3, &gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            d_cpu_yc3->data[i] = b_cpu_yc3->data[loop_ub + i8 * i];
            yc3_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = f_cpu_zi->size[0];
          f_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(f_cpu_zi, i, &f_emlrtRTEI);
          profileLoopStart("filtfilt_loop_52", __LINE__, (zi->size[0] - 1) + 1,
                           "1709");
          for (i = 0; i < zi->size[0]; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_yc3, &gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            f_cpu_zi->data[i] = zi->data[i + zi->size[0] * ii] *
                                b_cpu_yc3->data[b_cpu_yc3->size[0] - 1];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#b_filter#" MW_AT_LINE);
          b_filter(j_cpu_B, &B_outdatedOnCpu, &f_gpu_B, &B_outdatedOnGpu,
                   j_cpu_A, &A_outdatedOnCpu, &f_gpu_A, &A_outdatedOnGpu,
                   d_cpu_yc3, &b_gpu_yc3, &yc3_outdatedOnGpu, f_cpu_zi,
                   &zi_outdatedOnCpu, &d_gpu_zi, &zi_outdatedOnGpu, cpu__2,
                   &yc5_outdatedOnGpu, &gpu__2, &a__2_outdatedOnGpu, f_cpu_zo,
                   &b_zo_outdatedOnCpu, &c_gpu_zo, &b_zo_outdatedOnGpu);
          if (b_cpu_yc2->size[0] < 1) {
            loop_ub = 0;
            i8 = 1;
            i10 = -1;
          } else {
            loop_ub = b_cpu_yc2->size[0] - 1;
            i8 = -1;
            i10 = 0;
          }
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = l_cpu_B->size[0] * l_cpu_B->size[1];
          l_cpu_B->size[0] = 1;
          l_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(l_cpu_B, i, &ub_emlrtRTEI);
          profileLoopStart("filtfilt_loop_56", __LINE__, (B->size[1] - 1) + 1,
                           "1710");
          for (i = 0; i < B->size[1]; i++) {
            l_cpu_B->data[i] = B->data[ii + B->size[0] * i];
            B_outdatedOnGpu = true;
          }
          profileLoopEnd();
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = false;
          i = l_cpu_A->size[0] * l_cpu_A->size[1];
          l_cpu_A->size[0] = 1;
          l_cpu_A->size[1] = A->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(l_cpu_A, i, &wb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_58", __LINE__, (A->size[1] - 1) + 1,
                           "1711");
          for (i = 0; i < A->size[1]; i++) {
            l_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          a__2_outdatedOnGpu = false;
          i = d_cpu_yc2->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          d_cpu_yc2->size[0] = div_s32(i10 - loop_ub, i8) + 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(d_cpu_yc2, i, &s_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_59", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1712");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i10 - loop_ub, i8); i++) {
            if (yc2_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_yc2, &gpu_yc2);
            }
            yc2_outdatedOnCpu = false;
            d_cpu_yc2->data[i] = b_cpu_yc2->data[loop_ub + i8 * i];
            a__2_outdatedOnGpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#filter#" MW_AT_LINE);
          filter(l_cpu_B, &B_outdatedOnCpu, &g_gpu_B, &B_outdatedOnGpu, l_cpu_A,
                 &A_outdatedOnCpu, &g_gpu_A, &A_outdatedOnGpu, d_cpu_yc2,
                 &b_gpu_yc2, &a__2_outdatedOnGpu, f_cpu_zo, &b_zo_outdatedOnCpu,
                 &c_gpu_zo, &b_zo_outdatedOnGpu, b_cpu_yc5, &yc5_outdatedOnCpu,
                 &gpu_yc5, &yc5_outdatedOnGpu);
          if (b_cpu_yc5->size[0] < 1) {
            i8 = 0;
            i10 = 1;
            loop_ub = -1;
          } else {
            i8 = b_cpu_yc5->size[0] - 1;
            i10 = -1;
            loop_ub = 0;
          }
          i = y->size[0] * y->size[1] * y->size[2];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          y->size[0] = div_s32(loop_ub - i8, i10) + 1;
          y->size[1] = 1;
          y->size[2] = 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(y, i, &xb_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_loop_ub = div_s32(loop_ub - i8, i10) + 1;
          profileLoopStart("filtfilt_loop_62", __LINE__, (b_loop_ub - 1) + 1,
                           "1713");
          for (i = 0; i < b_loop_ub; i++) {
            if (yc5_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_yc5, &gpu_yc5);
            }
            yc5_outdatedOnCpu = false;
            y->data[i] = b_cpu_yc5->data[i8 + i10 * i];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
      }
    } else {
      int32_T i1;
      uint32_T sz_idx_0;
      uint32_T sz_idx_1;
      uint32_T sz_idx_2;
      sz_idx_0 = static_cast<uint32_T>(X->size[0]);
      sz_idx_1 = static_cast<uint32_T>(X->size[1]);
      sz_idx_2 = static_cast<uint32_T>(X->size[2]);
      a__4_outdatedOnGpu = false;
      yc3_outdatedOnGpu = false;
      i = cpu_xc1->size[0] * cpu_xc1->size[1];
      cpu_xc1->size[0] = X->size[0];
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      cpu_xc1->size[1] =
          div_s32(X->size[0] * X->size[1] * X->size[2], X->size[0]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_xc1, i, &d_emlrtRTEI);
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      profileLoopStart("filtfilt_loop_3", __LINE__,
                       (static_cast<int32_T>(sz_idx_0) *
                            div_s32(X->size[0] * X->size[1] * X->size[2],
                                    static_cast<int32_T>(sz_idx_0)) -
                        1) +
                           1,
                       "1714");
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      for (i = 0; i < static_cast<int32_T>(sz_idx_0) *
                          div_s32(X->size[0] * X->size[1] * X->size[2],
                                  static_cast<int32_T>(sz_idx_0));
           i++) {
        cpu_xc1->data[i] = X->data[i];
        yc3_outdatedOnGpu = true;
      }
      profileLoopEnd();
      i1 = static_cast<int32_T>(numStage);
      profileLoopStart("filtfilt_loop_6", __LINE__, (i1 - 1) + 1, "1715");
      for (int32_T ii{0}; ii < i1; ii++) {
        int32_T b_i1;
        int32_T b_loop_ub;
        int32_T i10;
        int32_T i8;
        int32_T loop_ub;
        i = r->size[0] * r->size[1];
        r->size[0] = 1;
        r->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(r, i, &f_emlrtRTEI);
        i = static_cast<int32_T>(Letr + 1.0) - 1;
        b_i1 = xc1->size[0] * xc1->size[1];
        xc1->size[0] = static_cast<int32_T>(Letr + 1.0) - 1;
        xc1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(xc1, b_i1, &j_emlrtRTEI);
        profileLoopStart("filtfilt_loop_10", __LINE__,
                         (cpu_xc1->size[1] - 1) + 1, "1716");
        for (b_i1 = 0; b_i1 < cpu_xc1->size[1]; b_i1++) {
          r->data[b_i1] = 2.0 * cpu_xc1->data[cpu_xc1->size[0] * b_i1];
          profileLoopStart("filtfilt_loop_13", __LINE__, (i - 1) + 1, "1717");
          for (loop_ub = 0; loop_ub < i; loop_ub++) {
            xc1->data[loop_ub + xc1->size[0] * b_i1] =
                cpu_xc1->data[((static_cast<int32_T>(Letr + 1.0) - loop_ub) +
                               cpu_xc1->size[0] * b_i1) -
                              1];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        if (xt_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xt, &c_gpu_xt);
        }
        nvtxMarkA("#bsxfun#" MW_AT_LINE);
        bsxfun(r, xc1, cpu_xt);
        xt_outdatedOnCpu = false;
        xt_outdatedOnGpu = true;
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = cpu_B->size[0] * cpu_B->size[1];
        cpu_B->size[0] = 1;
        cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_B, i, &m_emlrtRTEI);
        profileLoopStart("filtfilt_loop_17", __LINE__, (B->size[1] - 1) + 1,
                         "1718");
        for (i = 0; i < B->size[1]; i++) {
          cpu_B->data[i] = B->data[ii + B->size[0] * i];
          B_outdatedOnGpu = true;
        }
        profileLoopEnd();
        A_outdatedOnCpu = false;
        A_outdatedOnGpu = false;
        i = cpu_A->size[0] * cpu_A->size[1];
        cpu_A->size[0] = 1;
        cpu_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_A, i, &o_emlrtRTEI);
        profileLoopStart("filtfilt_loop_20", __LINE__, (A->size[1] - 1) + 1,
                         "1719");
        for (i = 0; i < A->size[1]; i++) {
          cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        zi_outdatedOnCpu = false;
        zi_outdatedOnGpu = false;
        i = cpu_zi->size[0] * cpu_zi->size[1];
        cpu_zi->size[0] = zi->size[0];
        cpu_zi->size[1] = cpu_xt->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_zi, i, &r_emlrtRTEI);
        b_loop_ub = cpu_xt->size[1];
        profileLoopStart("filtfilt_loop_23", __LINE__, (b_loop_ub - 1) + 1,
                         "1720");
        for (i = 0; i < b_loop_ub; i++) {
          loop_ub = zi->size[0];
          profileLoopStart("filtfilt_loop_25", __LINE__, (loop_ub - 1) + 1,
                           "1721");
          for (b_i1 = 0; b_i1 < loop_ub; b_i1++) {
            cpu_zi->data[b_i1 + cpu_zi->size[0] * i] =
                zi->data[b_i1 + zi->size[0] * ii] *
                cpu_xt->data[cpu_xt->size[0] * i];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        nvtxMarkA("#c_filter#" MW_AT_LINE);
        c_filter(cpu_B, &B_outdatedOnCpu, &h_gpu_B, &B_outdatedOnGpu, cpu_A,
                 &A_outdatedOnCpu, &h_gpu_A, &A_outdatedOnGpu, cpu_xt,
                 &c_gpu_xt, &xt_outdatedOnGpu, cpu_zi, &zi_outdatedOnCpu,
                 &e_gpu_zi, &zi_outdatedOnGpu, cpu__3, &yc5_outdatedOnGpu,
                 &gpu__3, &yc5_outdatedOnCpu, b_cpu_zo, &zo_outdatedOnCpu,
                 &d_gpu_zo, &zo_outdatedOnGpu);
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = b_cpu_B->size[0] * b_cpu_B->size[1];
        b_cpu_B->size[0] = 1;
        b_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_B, i, &u_emlrtRTEI);
        profileLoopStart("filtfilt_loop_27", __LINE__, (B->size[1] - 1) + 1,
                         "1722");
        for (i = 0; i < B->size[1]; i++) {
          b_cpu_B->data[i] = B->data[ii + B->size[0] * i];
          B_outdatedOnGpu = true;
        }
        profileLoopEnd();
        A_outdatedOnCpu = false;
        A_outdatedOnGpu = false;
        i = b_cpu_A->size[0] * b_cpu_A->size[1];
        b_cpu_A->size[0] = 1;
        b_cpu_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_A, i, &v_emlrtRTEI);
        profileLoopStart("filtfilt_loop_31", __LINE__, (A->size[1] - 1) + 1,
                         "1723");
        for (i = 0; i < A->size[1]; i++) {
          b_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#c_filter#" MW_AT_LINE);
        c_filter(b_cpu_B, &B_outdatedOnCpu, &i_gpu_B, &B_outdatedOnGpu, b_cpu_A,
                 &A_outdatedOnCpu, &i_gpu_A, &A_outdatedOnGpu, cpu_xc1,
                 &gpu_xc1, &yc3_outdatedOnGpu, b_cpu_zo, &zo_outdatedOnCpu,
                 &d_gpu_zo, &zo_outdatedOnGpu, cpu_yc2, &yc2_outdatedOnCpu,
                 &c_gpu_yc2, &a__2_outdatedOnGpu, c_cpu_zo, &b_zo_outdatedOnCpu,
                 &e_gpu_zo, &b_zo_outdatedOnGpu);
        numStage = static_cast<real_T>(cpu_xc1->size[0]) - Letr;
        if (numStage > static_cast<real_T>(cpu_xc1->size[0]) - 1.0) {
          loop_ub = 0;
          i8 = 1;
          i10 = -1;
        } else {
          loop_ub = cpu_xc1->size[0] - 2;
          i8 = -1;
          i10 = static_cast<int32_T>(numStage) - 1;
        }
        i = r1->size[0] * r1->size[1];
        r1->size[0] = 1;
        r1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(r1, i, &f_emlrtRTEI);
        i = b_xc1->size[0] * b_xc1->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        b_xc1->size[0] = div_s32(i10 - loop_ub, i8) + 1;
        b_xc1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_xc1, i, &db_emlrtRTEI);
        profileLoopStart("filtfilt_loop_36", __LINE__,
                         (cpu_xc1->size[1] - 1) + 1, "1724");
        for (i = 0; i < cpu_xc1->size[1]; i++) {
          if (a__4_outdatedOnGpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_real_T(cpu_xc1, &gpu_xc1);
          }
          a__4_outdatedOnGpu = false;
          r1->data[i] =
              2.0 *
              cpu_xc1->data[(cpu_xc1->size[0] + cpu_xc1->size[0] * i) - 1];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_37", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1725");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i10 - loop_ub, i8); b_i1++) {
            b_xc1->data[b_i1 + b_xc1->size[0] * i] =
                cpu_xc1->data[(loop_ub + i8 * b_i1) + cpu_xc1->size[0] * i];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = g_cpu_B->size[0] * g_cpu_B->size[1];
        g_cpu_B->size[0] = 1;
        g_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(g_cpu_B, i, &fb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_40", __LINE__, (B->size[1] - 1) + 1,
                         "1726");
        for (i = 0; i < B->size[1]; i++) {
          g_cpu_B->data[i] = B->data[ii + B->size[0] * i];
          B_outdatedOnGpu = true;
        }
        profileLoopEnd();
        A_outdatedOnCpu = false;
        A_outdatedOnGpu = false;
        i = g_cpu_A->size[0] * g_cpu_A->size[1];
        g_cpu_A->size[0] = 1;
        g_cpu_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(g_cpu_A, i, &gb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_43", __LINE__, (A->size[1] - 1) + 1,
                         "1727");
        for (i = 0; i < A->size[1]; i++) {
          g_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        if (r2_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_r2, &gpu_r2);
        }
        nvtxMarkA("#bsxfun#" MW_AT_LINE);
        bsxfun(r1, b_xc1, cpu_r2);
        r2_outdatedOnCpu = false;
        a__2_outdatedOnGpu = true;
        nvtxMarkA("#d_filter#" MW_AT_LINE);
        d_filter(g_cpu_B, &B_outdatedOnCpu, &j_gpu_B, &B_outdatedOnGpu, g_cpu_A,
                 &A_outdatedOnCpu, &j_gpu_A, &A_outdatedOnGpu, cpu_r2, &gpu_r2,
                 &a__2_outdatedOnGpu, c_cpu_zo, &b_zo_outdatedOnCpu, &e_gpu_zo,
                 &b_zo_outdatedOnGpu, cpu_yc3, &yc5_outdatedOnGpu, &c_gpu_yc3,
                 &yc3_outdatedOnGpu);
        if (cpu_yc3->size[0] < 1) {
          loop_ub = 0;
          i8 = 1;
          i10 = -1;
        } else {
          loop_ub = cpu_yc3->size[0] - 1;
          i8 = -1;
          i10 = 0;
        }
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = i_cpu_B->size[0] * i_cpu_B->size[1];
        i_cpu_B->size[0] = 1;
        i_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(i_cpu_B, i, &jb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_47", __LINE__, (B->size[1] - 1) + 1,
                         "1728");
        for (i = 0; i < B->size[1]; i++) {
          i_cpu_B->data[i] = B->data[ii + B->size[0] * i];
          B_outdatedOnGpu = true;
        }
        profileLoopEnd();
        A_outdatedOnCpu = false;
        A_outdatedOnGpu = false;
        i = i_cpu_A->size[0] * i_cpu_A->size[1];
        i_cpu_A->size[0] = 1;
        i_cpu_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(i_cpu_A, i, &lb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_49", __LINE__, (A->size[1] - 1) + 1,
                         "1729");
        for (i = 0; i < A->size[1]; i++) {
          i_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        yc5_outdatedOnCpu = false;
        yc3_outdatedOnGpu = false;
        i = c_cpu_yc3->size[0] * c_cpu_yc3->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc3->size[0] = div_s32(i10 - loop_ub, i8) + 1;
        c_cpu_yc3->size[1] = cpu_yc3->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_yc3, i, &nb_emlrtRTEI);
        zi_outdatedOnCpu = false;
        zi_outdatedOnGpu = false;
        i = e_cpu_zi->size[0] * e_cpu_zi->size[1];
        e_cpu_zi->size[0] = zi->size[0];
        e_cpu_zi->size[1] = cpu_yc3->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(e_cpu_zi, i, &ob_emlrtRTEI);
        profileLoopStart("filtfilt_loop_51", __LINE__,
                         (cpu_yc3->size[1] - 1) + 1, "1730");
        for (i = 0; i < cpu_yc3->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_53", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1731");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i10 - loop_ub, i8); b_i1++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yc3, &c_gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            c_cpu_yc3->data[b_i1 + c_cpu_yc3->size[0] * i] =
                cpu_yc3->data[(loop_ub + i8 * b_i1) + cpu_yc3->size[0] * i];
            yc3_outdatedOnGpu = true;
          }
          profileLoopEnd();
          b_loop_ub = zi->size[0];
          profileLoopStart("filtfilt_loop_54", __LINE__, (b_loop_ub - 1) + 1,
                           "1732");
          for (b_i1 = 0; b_i1 < b_loop_ub; b_i1++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yc3, &c_gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            e_cpu_zi->data[b_i1 + e_cpu_zi->size[0] * i] =
                zi->data[b_i1 + zi->size[0] * ii] *
                cpu_yc3->data[(cpu_yc3->size[0] + cpu_yc3->size[0] * i) - 1];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        nvtxMarkA("#c_filter#" MW_AT_LINE);
        c_filter(i_cpu_B, &B_outdatedOnCpu, &k_gpu_B, &B_outdatedOnGpu, i_cpu_A,
                 &A_outdatedOnCpu, &k_gpu_A, &A_outdatedOnGpu, c_cpu_yc3,
                 &d_gpu_yc3, &yc3_outdatedOnGpu, e_cpu_zi, &zi_outdatedOnCpu,
                 &f_gpu_zi, &zi_outdatedOnGpu, cpu__4, &yc5_outdatedOnGpu,
                 &gpu__4, &a__4_outdatedOnGpu, e_cpu_zo, &b_zo_outdatedOnCpu,
                 &f_gpu_zo, &b_zo_outdatedOnGpu);
        if (cpu_yc2->size[0] < 1) {
          loop_ub = 0;
          i8 = 1;
          i10 = -1;
        } else {
          loop_ub = cpu_yc2->size[0] - 1;
          i8 = -1;
          i10 = 0;
        }
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = k_cpu_B->size[0] * k_cpu_B->size[1];
        k_cpu_B->size[0] = 1;
        k_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(k_cpu_B, i, &qb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_55", __LINE__, (B->size[1] - 1) + 1,
                         "1733");
        for (i = 0; i < B->size[1]; i++) {
          k_cpu_B->data[i] = B->data[ii + B->size[0] * i];
          B_outdatedOnGpu = true;
        }
        profileLoopEnd();
        A_outdatedOnCpu = false;
        A_outdatedOnGpu = false;
        i = k_cpu_A->size[0] * k_cpu_A->size[1];
        k_cpu_A->size[0] = 1;
        k_cpu_A->size[1] = A->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(k_cpu_A, i, &sb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_57", __LINE__, (A->size[1] - 1) + 1,
                         "1734");
        for (i = 0; i < A->size[1]; i++) {
          k_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        a__2_outdatedOnGpu = false;
        i = c_cpu_yc2->size[0] * c_cpu_yc2->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc2->size[0] = div_s32(i10 - loop_ub, i8) + 1;
        c_cpu_yc2->size[1] = cpu_yc2->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_yc2, i, &tb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_60", __LINE__,
                         (cpu_yc2->size[1] - 1) + 1, "1735");
        for (i = 0; i < cpu_yc2->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_61", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1736");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i10 - loop_ub, i8); b_i1++) {
            if (yc2_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yc2, &c_gpu_yc2);
            }
            yc2_outdatedOnCpu = false;
            c_cpu_yc2->data[b_i1 + c_cpu_yc2->size[0] * i] =
                cpu_yc2->data[(loop_ub + i8 * b_i1) + cpu_yc2->size[0] * i];
            a__2_outdatedOnGpu = true;
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        nvtxMarkA("#d_filter#" MW_AT_LINE);
        d_filter(k_cpu_B, &B_outdatedOnCpu, &l_gpu_B, &B_outdatedOnGpu, k_cpu_A,
                 &A_outdatedOnCpu, &l_gpu_A, &A_outdatedOnGpu, c_cpu_yc2,
                 &d_gpu_yc2, &a__2_outdatedOnGpu, e_cpu_zo, &b_zo_outdatedOnCpu,
                 &f_gpu_zo, &b_zo_outdatedOnGpu, cpu_yc5, &yc5_outdatedOnCpu,
                 &b_gpu_yc5, &yc5_outdatedOnGpu);
        if (cpu_yc5->size[0] < 1) {
          loop_ub = 0;
          i8 = 1;
          i10 = -1;
        } else {
          loop_ub = cpu_yc5->size[0] - 1;
          i8 = -1;
          i10 = 0;
        }
        a__4_outdatedOnGpu = false;
        yc3_outdatedOnGpu = false;
        i = cpu_xc1->size[0] * cpu_xc1->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        cpu_xc1->size[0] = div_s32(i10 - loop_ub, i8) + 1;
        cpu_xc1->size[1] = cpu_yc5->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_xc1, i, &vb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_63", __LINE__,
                         (cpu_yc5->size[1] - 1) + 1, "1737");
        for (i = 0; i < cpu_yc5->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_64", __LINE__,
                           div_s32(i10 - loop_ub, i8) + 1, "1738");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i10 - loop_ub, i8); b_i1++) {
            if (yc5_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yc5, &b_gpu_yc5);
            }
            yc5_outdatedOnCpu = false;
            cpu_xc1->data[b_i1 + cpu_xc1->size[0] * i] =
                cpu_yc5->data[(loop_ub + i8 * b_i1) + cpu_yc5->size[0] * i];
            yc3_outdatedOnGpu = true;
          }
          profileLoopEnd();
        }
        profileLoopEnd();
      }
      profileLoopEnd();
      i = y->size[0] * y->size[1] * y->size[2];
      y->size[0] = X->size[0];
      y->size[1] = X->size[1];
      y->size[2] = X->size[2];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(y, i, &g_emlrtRTEI);
      profileLoopStart(
          "filtfilt_loop_9", __LINE__,
          (static_cast<int32_T>(sz_idx_0) * static_cast<int32_T>(sz_idx_1) *
               static_cast<int32_T>(sz_idx_2) -
           1) +
              1,
          "1739");
      for (i = 0;
           i < static_cast<int32_T>(sz_idx_0) * static_cast<int32_T>(sz_idx_1) *
                   static_cast<int32_T>(sz_idx_2);
           i++) {
        y->data[i] = cpu_xc1->data[i];
      }
      profileLoopEnd();
    }
    if (xIsRow) {
      i = y->size[0] * y->size[1] * y->size[2];
      y->size[0] = 1;
      y->size[1] = X->size[0];
      y->size[2] = 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(y, i, &h_emlrtRTEI);
    }
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_ytemp);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_r2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_yc2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&l_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&l_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_yc2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&k_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&k_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_yc3);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&j_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&j_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_yc3);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&i_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&i_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_xt);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&h_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&h_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&g_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&g_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_xc1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&r1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&ytemp);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_xt);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&xc1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&r);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_yc5);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yc5);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu__2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu__4);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_yc3);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yc3);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_ytemp);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_yc2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yc2);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu__3);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_zo);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu__1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_xt);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&xt);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_xc1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_ytemp);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&Y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&zi);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&X);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&den);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&num);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_ytemp);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_xc1);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_xt);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu__1);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu__3);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_ytemp);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu__4);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&f_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu__2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_yc5);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yc5);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&h_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&h_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&i_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&i_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_xt);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&j_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&j_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_xt);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&k_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&k_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&f_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&f_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&f_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&l_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&l_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&g_gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&g_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_r2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_ytemp);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

} // namespace coder

// End of code generation (filtfilt.cu)
