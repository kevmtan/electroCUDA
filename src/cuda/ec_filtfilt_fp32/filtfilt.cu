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
    181,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    420,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo
    e_emlrtRTEI{
        76,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo f_emlrtRTEI{
    184,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    150,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    179,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    423,                                                        // lineNo
    36,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    356,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    304,                                                        // lineNo
    16,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    424,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    357,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    424,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    357,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    307,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo
    q_emlrtRTEI{
        88,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo r_emlrtRTEI{
    181,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    307,                                                        // lineNo
    28,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    425,                                                        // lineNo
    23,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    425,                                                        // lineNo
    31,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    358,                                                        // lineNo
    23,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    308,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    358,                                                        // lineNo
    31,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    308,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    358,                                                        // lineNo
    39,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo bb_emlrtRTEI{
    309,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo cb_emlrtRTEI{
    426,                                                        // lineNo
    38,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo db_emlrtRTEI{
    309,                                                        // lineNo
    28,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo eb_emlrtRTEI{
    427,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fb_emlrtRTEI{
    427,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo gb_emlrtRTEI{
    309,                                                        // lineNo
    36,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo hb_emlrtRTEI{
    359,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ib_emlrtRTEI{
    429,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo jb_emlrtRTEI{
    360,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo kb_emlrtRTEI{
    429,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo lb_emlrtRTEI{
    360,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo mb_emlrtRTEI{
    429,                                                        // lineNo
    37,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo nb_emlrtRTEI{
    373,                                                        // lineNo
    21,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ob_emlrtRTEI{
    430,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo pb_emlrtRTEI{
    373,                                                        // lineNo
    29,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo qb_emlrtRTEI{
    430,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo rb_emlrtRTEI{
    430,                                                        // lineNo
    34,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo sb_emlrtRTEI{
    374,                                                        // lineNo
    18,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo tb_emlrtRTEI{
    432,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ub_emlrtRTEI{
    374,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo vb_emlrtRTEI{
    1,                                                          // lineNo
    14,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo wb_emlrtRTEI{
    300,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo xb_emlrtRTEI{
    416,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo yb_emlrtRTEI{
    423,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ac_emlrtRTEI{
    304,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo bc_emlrtRTEI{
    427,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo cc_emlrtRTEI{
    360,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo dc_emlrtRTEI{
    430,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ec_emlrtRTEI{
    374,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fc_emlrtRTEI{
    426,                                                        // lineNo
    10,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo hc_emlrtRTEI{
    713,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ic_emlrtRTEI{
    223,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo jc_emlrtRTEI{
    224,                                                        // lineNo
    1,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo kc_emlrtRTEI{
    716,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo lc_emlrtRTEI{
    54,                                                               // lineNo
    9,                                                                // colNo
    "div",                                                            // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/div.m" // pName
};

static emlrtRTEInfo mc_emlrtRTEI{
    231,                                                        // lineNo
    25,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo nc_emlrtRTEI{
    232,                                                        // lineNo
    26,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo oc_emlrtRTEI{
    119,                                                          // lineNo
    28,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo pc_emlrtRTEI{
    238,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo qc_emlrtRTEI{
    245,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo rc_emlrtRTEI{
    246,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo sc_emlrtRTEI{
    250,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo tc_emlrtRTEI{
    261,                                                        // lineNo
    40,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    1647,     // lineNo
    27,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
    125,      // lineNo
    44,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo wc_emlrtRTEI{
    1676,     // lineNo
    5,        // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo xc_emlrtRTEI{
    13,                                                                // lineNo
    1,                                                                 // colNo
    "sparse",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/sparfun/sparse.m" // pName
};

static emlrtRTEInfo yc_emlrtRTEI{
    261,                                                        // lineNo
    56,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
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
    190,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    261,                                                        // lineNo
    19,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo hd_emlrtRTEI{
    119,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    120,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo jd_emlrtRTEI{
    125,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo
    kd_emlrtRTEI{
        457,           // lineNo
        63,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo
    ld_emlrtRTEI{
        394,           // lineNo
        25,            // colNo
        "CXSparseAPI", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
        "CXSparseAPI.m" // pName
    };

static emlrtRTEInfo md_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    733,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo od_emlrtRTEI{
    738,                                                        // lineNo
    20,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo pd_emlrtRTEI{
    731,                                                        // lineNo
    15,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo be_emlrtRTEI{
    505,                                                        // lineNo
    12,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ce_emlrtRTEI{
    661,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo de_emlrtRTEI{
    672,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ee_emlrtRTEI{
    667,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo fe_emlrtRTEI{
    656,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ge_emlrtRTEI{
    550,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo he_emlrtRTEI{
    673,                                                        // lineNo
    9,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ie_emlrtRTEI{
    551,                                                        // lineNo
    13,                                                         // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo je_emlrtRTEI{
    657,                                                        // lineNo
    5,                                                          // colNo
    "filtfilt",                                                 // fName
    "/usr/local/MATLAB/R2024b/toolbox/signal/signal/filtfilt.m" // pName
};

static emlrtRTEInfo ke_emlrtRTEI{
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

static void binary_expand_op_1(emxArray_real32_T *in1, real_T in2, int32_T in3,
                               const emxArray_real32_T *in4, int32_T in5,
                               const emxArray_real32_T *in6);

namespace coder {
static void filtfiltParser(const emxArray_real32_T *ctf,
                           const emxArray_real32_T *varargin_1,
                           emxArray_real32_T *B, emxArray_real32_T *A,
                           real_T *numStage, real_T *P, real_T *Q,
                           boolean_T *isNumNonempty, boolean_T *isDenNonempty);

static void findEffectiveFilterLen(emxArray_real32_T *coef,
                                   real32_T effLen_data[],
                                   int32_T effLen_size[1]);

static void getCoeffsAndInitialConditions(
    const emxArray_real32_T *num, const emxArray_real32_T *den, real_T numStage,
    real_T P, real_T Q, emxArray_real32_T *B, emxArray_real32_T *A,
    emxArray_real32_T *zi, real32_T *Letr);

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

static void binary_expand_op_1(emxArray_real32_T *in1, real_T in2, int32_T in3,
                               const emxArray_real32_T *in4, int32_T in5,
                               const emxArray_real32_T *in6)
{
  emxArray_real32_T *b_in4;
  int32_T i;
  int32_T in6_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  nvtxRangePushA("#fcn#binary_expand_op_1#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in6_idx_0 = in6->size[0];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_in4, 2, &lc_emlrtRTEI, true);
  i = b_in4->size[0] * b_in4->size[1];
  if (in6_idx_0 == 1) {
    b_in4->size[0] = in4->size[0];
  } else {
    b_in4->size[0] = in6_idx_0;
  }
  b_in4->size[1] = in5 + 1;
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(b_in4, i, &lc_emlrtRTEI);
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
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_in4);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
namespace coder {
static void filtfiltParser(const emxArray_real32_T *ctf,
                           const emxArray_real32_T *varargin_1,
                           emxArray_real32_T *B, emxArray_real32_T *A,
                           real_T *numStage, real_T *P, real_T *Q,
                           boolean_T *isNumNonempty, boolean_T *isDenNonempty)
{
  emxArray_real32_T *NUM;
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
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&NUM, 2, &ke_emlrtRTEI, true);
  u0 = NUM->size[0] * NUM->size[1];
  NUM->size[0] = ctf->size[0];
  NUM->size[1] = ctf->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(NUM, u0, &be_emlrtRTEI);
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
      if (ctf->data[3] == 1.0F) {
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
    } else if (ctf->data[3] == 1.0F) {
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
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(B, u0, &ge_emlrtRTEI);
    u0 = A->size[0] * A->size[1];
    A->size[0] = NUM->size[0];
    A->size[1] = 3;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(A, u0, &ie_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(B, u0, &fe_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_5", __LINE__, (numSV - 1) + 1, "");
      for (u0 = 0; u0 < numSV; u0++) {
        B->data[u0] = ctf->data[u0];
      }
      profileLoopEnd();
      u0 = A->size[0] * A->size[1];
      A->size[0] = 1;
      A->size[1] = u1;
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(A, u0, &je_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(B, u0, &ce_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(A, u0, &ee_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(B, u0, &de_emlrtRTEI);
      profileLoopStart("filtfiltParser_loop_3", __LINE__,
                       (ctf->size[0] * ctf->size[1] - 1) + 1, "");
      for (u0 = 0; u0 < ctf->size[0] * ctf->size[1]; u0++) {
        B->data[u0] = ctf->data[u0];
      }
      profileLoopEnd();
      u0 = A->size[0] * A->size[1];
      A->size[0] = varargin_1->size[0];
      A->size[1] = varargin_1->size[1];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(A, u0, &he_emlrtRTEI);
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
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&NUM);
  *numStage = b_numStage;
  *P = numSV;
  *Q = u1;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
static void findEffectiveFilterLen(emxArray_real32_T *coef,
                                   real32_T effLen_data[],
                                   int32_T effLen_size[1])
{
  emxArray_boolean_T *x;
  emxArray_real32_T *varargin_1;
  int32_T ii_data[1];
  int32_T idx;
  int32_T k;
  int32_T nx;
  real32_T maxCoef;
  boolean_T exitg1;
  nvtxRangePushA("#fcn#findEffectiveFilterLen#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nx = coef->size[1];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&varargin_1, 2, &pd_emlrtRTEI, true);
  idx = varargin_1->size[0] * varargin_1->size[1];
  varargin_1->size[0] = 1;
  varargin_1->size[1] = coef->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(varargin_1, idx, &md_emlrtRTEI);
  profileLoopStart("findEffectiveFilterLen_loop_0", __LINE__, (nx - 1) + 1, "");
  for (k = 0; k < nx; k++) {
    varargin_1->data[k] = std::abs(coef->data[k]);
  }
  profileLoopEnd();
  nx = varargin_1->size[1];
  maxCoef = varargin_1->data[0];
  profileLoopStart("findEffectiveFilterLen_loop_1", __LINE__, (nx - 2) + 1, "");
  for (idx = 0; idx <= nx - 2; idx++) {
    real32_T f;
    boolean_T p;
    f = varargin_1->data[idx + 1];
    if (std::isnan(f)) {
      p = false;
    } else if (std::isnan(maxCoef)) {
      p = true;
    } else {
      p = (maxCoef < f);
    }
    if (p) {
      maxCoef = f;
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&varargin_1);
  if (maxCoef != 0.0F) {
    idx = coef->size[1];
    nx = coef->size[0] * coef->size[1];
    coef->size[0] = 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(coef, nx, &nd_emlrtRTEI);
    profileLoopStart("findEffectiveFilterLen_loop_2", __LINE__, (idx - 1) + 1,
                     "");
    for (nx = 0; nx < idx; nx++) {
      coef->data[nx] /= maxCoef;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_boolean_T#" MW_AT_LINE);
  emxInit_boolean_T(&x, 1, &od_emlrtRTEI, true);
  idx = x->size[0];
  x->size[0] = coef->size[1];
  nvtxMarkA("#emxEnsureCapacity_boolean_T#" MW_AT_LINE);
  emxEnsureCapacity_boolean_T(x, idx, &od_emlrtRTEI);
  profileLoopStart("findEffectiveFilterLen_loop_3", __LINE__,
                   (coef->size[1] - 1) + 1, "");
  for (idx = 0; idx < coef->size[1]; idx++) {
    x->data[idx] = (coef->data[idx] != 0.0F);
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
    effLen_data[0] = static_cast<real32_T>(ii_data[0]);
  }
  profileLoopEnd();
  if (k == 0) {
    effLen_size[0] = 1;
    effLen_data[0] = 0.0F;
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

//
//
static void getCoeffsAndInitialConditions(const emxArray_real32_T *num,
                                          const emxArray_real32_T *den,
                                          real_T numStage, real_T P, real_T Q,
                                          emxArray_real32_T *B,
                                          emxArray_real32_T *A,
                                          emxArray_real32_T *zi, real32_T *Letr)
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
  emxArray_real32_T *IDX;
  emxArray_real32_T *b_den;
  emxArray_real32_T *b_num;
  emxArray_real32_T *c_den;
  emxArray_real32_T *c_num;
  emxArray_real32_T *colIdx;
  emxArray_real32_T *rhs;
  emxArray_real32_T *rowIdx;
  emxArray_real_T *b;
  emxArray_real_T *b_in_d;
  emxArray_real_T *b_outBuff;
  emxArray_real_T *c_in_d;
  emxArray_real_T *in_d;
  emxArray_real_T *outBuff;
  emxArray_real_T *y_d;
  emxArray_real_T *yf;
  emxArray_real_T *zik;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *y;
  int32_T b_i;
  int32_T b_loop_ub;
  int32_T b_ns;
  int32_T c_ns;
  int32_T i;
  int32_T i10;
  int32_T i11;
  int32_T k;
  int32_T loop_ub;
  int32_T n;
  int32_T nc;
  int32_T numalloc{0};
  int32_T thism;
  real32_T b_tmp_data[1];
  real32_T tmp_data[1];
  real32_T M;
  real32_T ord;
  nvtxRangePushA("#fcn#getCoeffsAndInitialConditions#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  M = std::fmax(static_cast<real32_T>(P), static_cast<real32_T>(Q));
  ord = 0.0F;
  i = static_cast<int32_T>(numStage);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_num, 2, &hc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_den, 2, &kc_emlrtRTEI, true);
  profileLoopStart("getCoeffsAndInitialConditions_loop_0", __LINE__,
                   (i - 1) + 1, "");
  for (int32_T ns{0}; ns < i; ns++) {
    b_i = b_num->size[0] * b_num->size[1];
    b_num->size[0] = 1;
    b_num->size[1] = num->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(b_num, b_i, &hc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_1", __LINE__,
                     (num->size[1] - 1) + 1, "");
    for (b_i = 0; b_i < num->size[1]; b_i++) {
      b_num->data[b_i] = num->data[ns + num->size[0] * b_i];
    }
    profileLoopEnd();
    b_i = b_den->size[0] * b_den->size[1];
    b_den->size[0] = 1;
    b_den->size[1] = den->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(b_den, b_i, &kc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_3", __LINE__,
                     (den->size[1] - 1) + 1, "");
    for (b_i = 0; b_i < den->size[1]; b_i++) {
      b_den->data[b_i] = den->data[ns + den->size[0] * b_i];
    }
    int32_T tmp_size[1];
    profileLoopEnd();
    nvtxMarkA("#findEffectiveFilterLen#" MW_AT_LINE);
    findEffectiveFilterLen(b_num, tmp_data, tmp_size);
    nvtxMarkA("#findEffectiveFilterLen#" MW_AT_LINE);
    findEffectiveFilterLen(b_den, b_tmp_data, tmp_size);
    ord = (ord + std::fmax(tmp_data[0], b_tmp_data[0])) - 1.0F;
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_den);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_num);
  b_i = B->size[0] * B->size[1];
  B->size[0] = static_cast<int32_T>(numStage);
  B->size[1] = static_cast<int32_T>(M);
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(B, b_i, &ic_emlrtRTEI);
  b_i = A->size[0] * A->size[1];
  A->size[0] = static_cast<int32_T>(numStage);
  A->size[1] = static_cast<int32_T>(M);
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(A, b_i, &jc_emlrtRTEI);
  profileLoopStart(
      "getCoeffsAndInitialConditions_loop_2", __LINE__,
      (static_cast<int32_T>(numStage) * static_cast<int32_T>(M) - 1) + 1, "");
  for (b_i = 0; b_i < static_cast<int32_T>(numStage) * static_cast<int32_T>(M);
       b_i++) {
    B->data[b_i] = 0.0F;
    A->data[b_i] = 0.0F;
  }
  profileLoopEnd();
  if (P < 1.0) {
    n = 0;
    i = 0;
  } else {
    n = static_cast<int32_T>(P);
    i = static_cast<int32_T>(P);
  }
  if (num->size[0] == den->size[0]) {
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&c_num, 2, &lc_emlrtRTEI, true);
    b_i = c_num->size[0] * c_num->size[1];
    c_num->size[0] = num->size[0];
    c_num->size[1] = n;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(c_num, b_i, &lc_emlrtRTEI);
    profileLoopStart("getCoeffsAndInitialConditions_loop_4", __LINE__,
                     (n - 1) + 1, "");
    for (b_i = 0; b_i < n; b_i++) {
      profileLoopStart("getCoeffsAndInitialConditions_loop_5", __LINE__,
                       (num->size[0] - 1) + 1, "");
      for (k = 0; k < num->size[0]; k++) {
        c_num->data[k + c_num->size[0] * b_i] =
            num->data[k + num->size[0] * b_i] / den->data[k];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    thism = static_cast<int32_T>(numStage);
    profileLoopStart("getCoeffsAndInitialConditions_loop_6", __LINE__,
                     (i - 1) + 1, "");
    for (b_i = 0; b_i < i; b_i++) {
      profileLoopStart("getCoeffsAndInitialConditions_loop_8", __LINE__,
                       (thism - 1) + 1, "");
      for (k = 0; k < thism; k++) {
        B->data[k + B->size[0] * b_i] =
            c_num->data[k + static_cast<int32_T>(numStage) * b_i];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&c_num);
  } else {
    nvtxMarkA("#binary_expand_op_1#" MW_AT_LINE);
    binary_expand_op_1(B, numStage, i, num, n - 1, den);
  }
  if (Q < 1.0) {
    n = 0;
  } else {
    n = static_cast<int32_T>(Q);
  }
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_den, 2, &lc_emlrtRTEI, true);
  b_i = c_den->size[0] * c_den->size[1];
  c_den->size[0] = den->size[0];
  c_den->size[1] = n;
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(c_den, b_i, &lc_emlrtRTEI);
  profileLoopStart("getCoeffsAndInitialConditions_loop_7", __LINE__,
                   (n - 1) + 1, "");
  for (b_i = 0; b_i < n; b_i++) {
    profileLoopStart("getCoeffsAndInitialConditions_loop_9", __LINE__,
                     (den->size[0] - 1) + 1, "");
    for (k = 0; k < den->size[0]; k++) {
      c_den->data[k + c_den->size[0] * b_i] =
          den->data[k + den->size[0] * b_i] / den->data[k];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  thism = static_cast<int32_T>(numStage);
  if (Q < 1.0) {
    n = 0;
  } else {
    n = static_cast<int32_T>(Q);
  }
  profileLoopStart("getCoeffsAndInitialConditions_loop_10", __LINE__,
                   (n - 1) + 1, "");
  for (b_i = 0; b_i < n; b_i++) {
    profileLoopStart("getCoeffsAndInitialConditions_loop_11", __LINE__,
                     (thism - 1) + 1, "");
    for (k = 0; k < thism; k++) {
      A->data[k + A->size[0] * b_i] =
          c_den->data[k + static_cast<int32_T>(numStage) * b_i];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_den);
  if (M > 1.0F) {
    real_T tol;
    int32_T i7;
    int32_T i9;
    b_i = zi->size[0] * zi->size[1];
    zi->size[0] = static_cast<int32_T>(M - 1.0F);
    zi->size[1] = static_cast<int32_T>(numStage);
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(zi, b_i, &mc_emlrtRTEI);
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&rhs, 1, &ed_emlrtRTEI, true);
    b_i = rhs->size[0];
    rhs->size[0] = static_cast<int32_T>(M - 1.0F);
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(rhs, b_i, &nc_emlrtRTEI);
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&IDX, 2, &pc_emlrtRTEI, true);
    if (M - 1.0F >= 1.07374182E+9F) {
      tol = M - 1.0F;
      b_i = IDX->size[0] * IDX->size[1];
      IDX->size[0] = 1;
      IDX->size[1] = static_cast<int32_T>((M - 1.0F) - 1.0) + 1;
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(IDX, b_i, &pc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_13", __LINE__,
                       static_cast<int32_T>(tol - 1.0) + 1, "");
      for (b_i = 0; b_i <= static_cast<int32_T>(tol - 1.0); b_i++) {
        IDX->data[b_i] = static_cast<real32_T>(static_cast<real_T>(b_i) + 1.0);
      }
      profileLoopEnd();
    } else {
      n = static_cast<int32_T>(std::floor(M - 1.0F));
      b_i = IDX->size[0] * IDX->size[1];
      IDX->size[0] = 1;
      IDX->size[1] = static_cast<int32_T>(std::floor(M - 1.0F));
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(IDX, b_i, &oc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_12", __LINE__,
                       (n - 1) + 1, "");
      for (k = 0; k < n; k++) {
        IDX->data[k] = static_cast<real32_T>(k + 1);
      }
      profileLoopEnd();
    }
    if (IDX->size[1] < 2) {
      n = 0;
      i = 0;
    } else {
      n = 1;
      i = IDX->size[1];
    }
    if (static_cast<real_T>(static_cast<int32_T>(M - 1.0F)) - 1.0 < 1.0) {
      i7 = 1;
    } else {
      i7 = static_cast<int32_T>(M - 1.0F);
    }
    if (IDX->size[1] - 1 < 1) {
      thism = 0;
    } else {
      thism = IDX->size[1] - 1;
    }
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&rowIdx, 2, &qc_emlrtRTEI, true);
    b_i = rowIdx->size[0] * rowIdx->size[1];
    rowIdx->size[0] = 1;
    rowIdx->size[1] = ((IDX->size[1] + i) - n) + thism;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(rowIdx, b_i, &qc_emlrtRTEI);
    k = IDX->size[1];
    profileLoopStart("getCoeffsAndInitialConditions_loop_14", __LINE__,
                     (k - 1) + 1, "");
    for (b_i = 0; b_i < k; b_i++) {
      rowIdx->data[b_i] = IDX->data[b_i];
    }
    profileLoopEnd();
    k = i - n;
    profileLoopStart("getCoeffsAndInitialConditions_loop_15", __LINE__,
                     (k - 1) + 1, "");
    for (b_i = 0; b_i < k; b_i++) {
      rowIdx->data[b_i + IDX->size[1]] = IDX->data[n + b_i];
    }
    profileLoopEnd();
    profileLoopStart("getCoeffsAndInitialConditions_loop_16", __LINE__,
                     (thism - 1) + 1, "");
    for (b_i = 0; b_i < thism; b_i++) {
      rowIdx->data[((b_i + IDX->size[1]) + i) - n] = IDX->data[b_i];
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&colIdx, 2, &rc_emlrtRTEI, true);
    b_i = colIdx->size[0] * colIdx->size[1];
    colIdx->size[0] = 1;
    colIdx->size[1] = (((static_cast<int32_T>(M - 1.0F) + i) - n) + i) - n;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(colIdx, b_i, &rc_emlrtRTEI);
    k = static_cast<int32_T>(M - 1.0F);
    profileLoopStart("getCoeffsAndInitialConditions_loop_17", __LINE__,
                     (k - 1) + 1, "");
    for (b_i = 0; b_i < k; b_i++) {
      colIdx->data[b_i] = 1.0F;
    }
    profileLoopEnd();
    k = i - n;
    profileLoopStart("getCoeffsAndInitialConditions_loop_18", __LINE__,
                     (k - 1) + 1, "");
    for (b_i = 0; b_i < k; b_i++) {
      colIdx->data[b_i + static_cast<int32_T>(M - 1.0F)] = IDX->data[n + b_i];
    }
    profileLoopEnd();
    k = i - n;
    profileLoopStart("getCoeffsAndInitialConditions_loop_19", __LINE__,
                     (k - 1) + 1, "");
    for (b_i = 0; b_i < k; b_i++) {
      colIdx->data[((b_i + static_cast<int32_T>(M - 1.0F)) + i) - n] =
          IDX->data[n + b_i];
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&IDX);
    i9 = static_cast<int32_T>(numStage);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&y_d, 1, &gd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&y_colidx, 1, &gd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&y_rowidx, 1, &gd_emlrtRTEI, true);
    if (static_cast<int32_T>(numStage) - 1 >= 0) {
      if (M < 3.0F) {
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
    emxInit_real_T(&yf, 2, &fd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&ridxInt, 1, &hd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cidxInt, 1, &id_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&sortedIndices, 1, &jd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&t, 1, &wc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_t, 1, &wc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b, 1, &yc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&zik, 1, &ad_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&in_d, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&in_colidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&in_rowidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_in_d, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_in_colidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_in_rowidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_in_d, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&c_in_colidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&c_in_rowidx, 1, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&outBuff, 1, &ld_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_outBuff, 1, &ld_emlrtRTEI, true);
    profileLoopStart("getCoeffsAndInitialConditions_loop_20", __LINE__,
                     (i9 - 1) + 1, "");
    for (int32_T ns{0}; ns < i9; ns++) {
      M = B->data[ns];
      n = rhs->size[0];
      b_i = rhs->size[0];
      rhs->size[0] = n;
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(rhs, b_i, &sc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_21", __LINE__,
                       (n - 1) + 1, "");
      for (b_i = 0; b_i < n; b_i++) {
        rhs->data[b_i] = B->data[ns + B->size[0] * (b_i + 1)] -
                         M * A->data[ns + A->size[0] * (b_i + 1)];
      }
      profileLoopEnd();
      b_i = yf->size[0] * yf->size[1];
      yf->size[0] = 1;
      yf->size[1] = (((i11 - i10) + i7) + i7) - 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(yf, b_i, &tc_emlrtRTEI);
      yf->data[0] = A->data[ns + A->size[0]] + 1.0F;
      profileLoopStart("getCoeffsAndInitialConditions_loop_22", __LINE__,
                       (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        yf->data[b_i + 1] = A->data[ns + A->size[0] * (i10 + b_i)];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_23", __LINE__,
                       (b_loop_ub - 2) + 1, "");
      for (b_i = 0; b_i <= b_loop_ub - 2; b_i++) {
        yf->data[((b_i + i11) - i10) + 1] = 1.0;
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_24", __LINE__,
                       (b_loop_ub - 2) + 1, "");
      for (b_i = 0; b_i <= b_loop_ub - 2; b_i++) {
        yf->data[((b_i + i11) - i10) + i7] = -1.0;
      }
      profileLoopEnd();
      b_i = ridxInt->size[0];
      ridxInt->size[0] = rowIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(ridxInt, b_i, &uc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_25", __LINE__,
                       (b_ns - 1) + 1, "");
      for (k = 0; k < b_ns; k++) {
        ridxInt->data[k] = static_cast<int32_T>(rowIdx->data[k]);
      }
      profileLoopEnd();
      b_i = cidxInt->size[0];
      cidxInt->size[0] = colIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(cidxInt, b_i, &uc_emlrtRTEI);
      b_i = sortedIndices->size[0];
      sortedIndices->size[0] = colIdx->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(sortedIndices, b_i, &vc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_26", __LINE__,
                       (c_ns - 1) + 1, "");
      for (k = 0; k < c_ns; k++) {
        cidxInt->data[k] = static_cast<int32_T>(colIdx->data[k]);
        sortedIndices->data[k] = k + 1;
      }
      profileLoopEnd();
      nvtxMarkA("#introsort#" MW_AT_LINE);
      internal::introsort(sortedIndices, cidxInt->size[0], cidxInt, ridxInt);
      n = cidxInt->size[0];
      b_i = t->size[0];
      t->size[0] = cidxInt->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(t, b_i, &wc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_27", __LINE__,
                       (cidxInt->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < cidxInt->size[0]; b_i++) {
        t->data[b_i] = cidxInt->data[b_i];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_28", __LINE__,
                       (n - 1) + 1, "");
      for (k = 0; k < n; k++) {
        cidxInt->data[k] = t->data[sortedIndices->data[k] - 1];
      }
      profileLoopEnd();
      n = ridxInt->size[0];
      b_i = b_t->size[0];
      b_t->size[0] = ridxInt->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(b_t, b_i, &wc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_29", __LINE__,
                       (ridxInt->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < ridxInt->size[0]; b_i++) {
        b_t->data[b_i] = ridxInt->data[b_i];
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_30", __LINE__,
                       (n - 1) + 1, "");
      for (k = 0; k < n; k++) {
        ridxInt->data[k] = b_t->data[sortedIndices->data[k] - 1];
      }
      profileLoopEnd();
      n = ridxInt->size[0];
      thism = ridxInt->data[0];
      profileLoopStart("getCoeffsAndInitialConditions_loop_31", __LINE__,
                       (n - 2) + 1, "");
      for (i = 0; i <= n - 2; i++) {
        if (thism < ridxInt->data[i + 1]) {
          thism = ridxInt->data[i + 1];
        }
      }
      profileLoopEnd();
      i = cidxInt->data[cidxInt->size[0] - 1];
      b_i = y_d->size[0];
      y_d->size[0] = numalloc;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(y_d, b_i, &xc_emlrtRTEI);
      if (numalloc - 1 >= 0) {
        std::memset(&y_d->data[0], 0,
                    static_cast<uint32_T>(numalloc) * sizeof(real_T));
      }
      b_i = y_colidx->size[0];
      y_colidx->size[0] = cidxInt->data[cidxInt->size[0] - 1] + 1;
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(y_colidx, b_i, &xc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_32", __LINE__,
                       cidxInt->data[cidxInt->size[0] - 1] + 1, "");
      for (b_i = 0; b_i <= cidxInt->data[cidxInt->size[0] - 1]; b_i++) {
        y_colidx->data[b_i] = 0;
      }
      profileLoopEnd();
      y_colidx->data[0] = 1;
      b_i = y_rowidx->size[0];
      y_rowidx->size[0] = numalloc;
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(y_rowidx, b_i, &xc_emlrtRTEI);
      if (numalloc - 1 >= 0) {
        std::memset(&y_rowidx->data[0], 0,
                    static_cast<uint32_T>(numalloc) * sizeof(int32_T));
      }
      n = 0;
      profileLoopStart("getCoeffsAndInitialConditions_loop_33", __LINE__,
                       (i - 1) + 1, "");
      for (k = 0; k < i; k++) {
        nvtxRangePushA(
            "#loop#getCoeffsAndInitialConditions_whileloop_0##" MW_AT_LINE);
        while ((n + 1 <= nc) && (cidxInt->data[n] == k + 1)) {
          y_rowidx->data[n] = ridxInt->data[n];
          n++;
        }
        nvtxRangePop();
        y_colidx->data[k + 1] = n + 1;
      }
      profileLoopEnd();
      profileLoopStart("getCoeffsAndInitialConditions_loop_34", __LINE__,
                       (nc - 1) + 1, "");
      for (k = 0; k < nc; k++) {
        y_d->data[k] = yf->data[sortedIndices->data[k] - 1];
      }
      profileLoopEnd();
      i = cidxInt->data[cidxInt->size[0] - 1];
      nvtxMarkA("#sparse_fillIn#" MW_AT_LINE);
      sparse_fillIn(y_d, y_colidx, y_rowidx);
      b_i = b->size[0];
      b->size[0] = rhs->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b, b_i, &yc_emlrtRTEI);
      profileLoopStart("getCoeffsAndInitialConditions_loop_35", __LINE__,
                       (rhs->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < rhs->size[0]; b_i++) {
        b->data[b_i] = rhs->data[b_i];
      }
      profileLoopEnd();
      if ((thism == 0) || (cidxInt->data[cidxInt->size[0] - 1] == 0)) {
        b_i = zik->size[0];
        zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(zik, b_i, &ad_emlrtRTEI);
        if (i - 1 >= 0) {
          std::memset(&zik->data[0], 0,
                      static_cast<uint32_T>(i) * sizeof(real_T));
        }
      } else if (b->size[0] == cidxInt->data[cidxInt->size[0] - 1]) {
        cs_di *b_cxA;
        cs_din *b_N;
        cs_dis *b_S;
        if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
          nvtxMarkA("#sparse_ctranspose#" MW_AT_LINE);
          sparse_ctranspose(y_d, y_colidx, y_rowidx, thism,
                            cidxInt->data[cidxInt->size[0] - 1], b_in_d,
                            b_in_colidx, b_in_rowidx, &n, &i);
          b_cxA = makeCXSparseMatrix(
              b_in_colidx->data[b_in_colidx->size[0] - 1] - 1, i, n,
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
                              c_in_colidx, c_in_rowidx, &n, &i);
            c_cxA = makeCXSparseMatrix(
                c_in_colidx->data[c_in_colidx->size[0] - 1] - 1, i, n,
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
          qr_rank_di(c_N, &tol);
          b_i = zik->size[0];
          zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(zik, b_i, &bd_emlrtRTEI);
          if (b->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
            b_i = b_outBuff->size[0];
            b_outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_outBuff, b_i, &dd_emlrtRTEI);
          } else {
            b_i = b_outBuff->size[0];
            b_outBuff->size[0] = b->size[0];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_outBuff, b_i, &cd_emlrtRTEI);
          }
          k = b->size[0];
          profileLoopStart("getCoeffsAndInitialConditions_loop_40", __LINE__,
                           (k - 1) + 1, "");
          for (b_i = 0; b_i < k; b_i++) {
            b_outBuff->data[b_i] = b->data[b_i];
          }
          profileLoopEnd();
          solve_from_qr_di(c_N, c_S, (double *)&b_outBuff->data[0], b->size[0],
                           cidxInt->data[cidxInt->size[0] - 1]);
          n = cidxInt->data[cidxInt->size[0] - 1];
          profileLoopStart("getCoeffsAndInitialConditions_loop_41", __LINE__,
                           (n - 1) + 1, "");
          for (b_i = 0; b_i < n; b_i++) {
            zik->data[b_i] = b_outBuff->data[b_i];
          }
          profileLoopEnd();
          cs_di_sfree(c_S);
          cs_di_nfree(c_N);
        } else {
          b_i = zik->size[0];
          zik->size[0] = b->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(zik, b_i, &ad_emlrtRTEI);
          profileLoopStart("getCoeffsAndInitialConditions_loop_37", __LINE__,
                           (b->size[0] - 1) + 1, "");
          for (b_i = 0; b_i < b->size[0]; b_i++) {
            zik->data[b_i] = b->data[b_i];
          }
          profileLoopEnd();
          solve_from_lu_di(b_N, b_S, (double *)&zik->data[0], b->size[0]);
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
                            in_colidx, in_rowidx, &n, &i);
          cxA = makeCXSparseMatrix(in_colidx->data[in_colidx->size[0] - 1] - 1,
                                   i, n, &in_colidx->data[0],
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
        n = qr_rank_di(N, &tol);
        if (thism > cidxInt->data[cidxInt->size[0] - 1]) {
          thism = cidxInt->data[cidxInt->size[0] - 1];
        }
        if (n < thism) {
          char_T str[14];
          y = nullptr;
          m = emlrtCreateCharArray(2, &iv[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 6, m, &rfmt[0]);
          emlrtAssign(&y, m);
          b_y = nullptr;
          m1 = emlrtCreateDoubleScalar(tol);
          emlrtAssign(&b_y, m1);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(y, b_y, &d_emlrtMCI),
                           "<output of sprintf>", str);
          nvtxMarkA("#warning#" MW_AT_LINE);
          internal::warning(n, str);
        }
        b_i = zik->size[0];
        zik->size[0] = cidxInt->data[cidxInt->size[0] - 1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(zik, b_i, &bd_emlrtRTEI);
        if (b->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
          b_i = outBuff->size[0];
          outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(outBuff, b_i, &dd_emlrtRTEI);
        } else {
          b_i = outBuff->size[0];
          outBuff->size[0] = b->size[0];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(outBuff, b_i, &cd_emlrtRTEI);
        }
        k = b->size[0];
        profileLoopStart("getCoeffsAndInitialConditions_loop_38", __LINE__,
                         (k - 1) + 1, "");
        for (b_i = 0; b_i < k; b_i++) {
          outBuff->data[b_i] = b->data[b_i];
        }
        profileLoopEnd();
        solve_from_qr_di(N, S, (double *)&outBuff->data[0], b->size[0],
                         cidxInt->data[cidxInt->size[0] - 1]);
        n = cidxInt->data[cidxInt->size[0] - 1];
        profileLoopStart("getCoeffsAndInitialConditions_loop_39", __LINE__,
                         (n - 1) + 1, "");
        for (b_i = 0; b_i < n; b_i++) {
          zik->data[b_i] = outBuff->data[b_i];
        }
        profileLoopEnd();
        cs_di_sfree(S);
        cs_di_nfree(N);
      }
      n = zi->size[0];
      profileLoopStart("getCoeffsAndInitialConditions_loop_36", __LINE__,
                       (n - 1) + 1, "");
      for (b_i = 0; b_i < n; b_i++) {
        zi->data[b_i + zi->size[0] * ns] =
            static_cast<real32_T>(zik->data[b_i]);
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
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b);
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
    emxFree_real_T(&yf);
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&colIdx);
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&rowIdx);
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&rhs);
  } else {
    zi->size[0] = 0;
    zi->size[1] = static_cast<int32_T>(numStage);
  }
  *Letr = std::fmax(1.0F, 3.0F * ord);
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
void filtfilt(const emxArray_real32_T *ctf, const emxArray_real32_T *varargin_1,
              const emxArray_real32_T *varargin_2, emxArray_real32_T *y)
{
  emxArray_real32_T b_gpu_A;
  emxArray_real32_T b_gpu_B;
  emxArray_real32_T b_gpu_xt;
  emxArray_real32_T b_gpu_yc2;
  emxArray_real32_T b_gpu_yc3;
  emxArray_real32_T b_gpu_yc5;
  emxArray_real32_T b_gpu_ytemp;
  emxArray_real32_T b_gpu_zi;
  emxArray_real32_T b_gpu_zo;
  emxArray_real32_T c_gpu_A;
  emxArray_real32_T c_gpu_B;
  emxArray_real32_T c_gpu_xt;
  emxArray_real32_T c_gpu_yc2;
  emxArray_real32_T c_gpu_yc3;
  emxArray_real32_T c_gpu_ytemp;
  emxArray_real32_T c_gpu_zi;
  emxArray_real32_T c_gpu_zo;
  emxArray_real32_T d_gpu_A;
  emxArray_real32_T d_gpu_B;
  emxArray_real32_T d_gpu_yc2;
  emxArray_real32_T d_gpu_yc3;
  emxArray_real32_T d_gpu_zi;
  emxArray_real32_T d_gpu_zo;
  emxArray_real32_T e_gpu_A;
  emxArray_real32_T e_gpu_B;
  emxArray_real32_T e_gpu_zi;
  emxArray_real32_T e_gpu_zo;
  emxArray_real32_T f_gpu_A;
  emxArray_real32_T f_gpu_B;
  emxArray_real32_T f_gpu_zi;
  emxArray_real32_T f_gpu_zo;
  emxArray_real32_T g_gpu_A;
  emxArray_real32_T g_gpu_B;
  emxArray_real32_T gpu_A;
  emxArray_real32_T gpu_B;
  emxArray_real32_T gpu__1;
  emxArray_real32_T gpu__2;
  emxArray_real32_T gpu__3;
  emxArray_real32_T gpu__4;
  emxArray_real32_T gpu_r2;
  emxArray_real32_T gpu_xc1;
  emxArray_real32_T gpu_xt;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_yc2;
  emxArray_real32_T gpu_yc3;
  emxArray_real32_T gpu_yc5;
  emxArray_real32_T gpu_ytemp;
  emxArray_real32_T gpu_zi;
  emxArray_real32_T gpu_zo;
  emxArray_real32_T h_gpu_A;
  emxArray_real32_T h_gpu_B;
  emxArray_real32_T i_gpu_A;
  emxArray_real32_T i_gpu_B;
  emxArray_real32_T j_gpu_A;
  emxArray_real32_T j_gpu_B;
  emxArray_real32_T k_gpu_A;
  emxArray_real32_T k_gpu_B;
  emxArray_real32_T l_gpu_A;
  emxArray_real32_T l_gpu_B;
  emxArray_real32_T *A;
  emxArray_real32_T *B;
  emxArray_real32_T *X;
  emxArray_real32_T *b_cpu_A;
  emxArray_real32_T *b_cpu_B;
  emxArray_real32_T *b_cpu_xt;
  emxArray_real32_T *b_cpu_yc2;
  emxArray_real32_T *b_cpu_yc3;
  emxArray_real32_T *b_cpu_yc5;
  emxArray_real32_T *b_cpu_ytemp;
  emxArray_real32_T *b_cpu_zi;
  emxArray_real32_T *b_cpu_zo;
  emxArray_real32_T *b_xc1;
  emxArray_real32_T *c_cpu_A;
  emxArray_real32_T *c_cpu_B;
  emxArray_real32_T *c_cpu_xt;
  emxArray_real32_T *c_cpu_yc2;
  emxArray_real32_T *c_cpu_yc3;
  emxArray_real32_T *c_cpu_ytemp;
  emxArray_real32_T *c_cpu_zi;
  emxArray_real32_T *c_cpu_zo;
  emxArray_real32_T *cpu_A;
  emxArray_real32_T *cpu_B;
  emxArray_real32_T *cpu__1;
  emxArray_real32_T *cpu__2;
  emxArray_real32_T *cpu__3;
  emxArray_real32_T *cpu__4;
  emxArray_real32_T *cpu_r2;
  emxArray_real32_T *cpu_xc1;
  emxArray_real32_T *cpu_xt;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_yc2;
  emxArray_real32_T *cpu_yc3;
  emxArray_real32_T *cpu_yc5;
  emxArray_real32_T *cpu_ytemp;
  emxArray_real32_T *cpu_zi;
  emxArray_real32_T *cpu_zo;
  emxArray_real32_T *d_cpu_A;
  emxArray_real32_T *d_cpu_B;
  emxArray_real32_T *d_cpu_yc2;
  emxArray_real32_T *d_cpu_yc3;
  emxArray_real32_T *d_cpu_zi;
  emxArray_real32_T *d_cpu_zo;
  emxArray_real32_T *den;
  emxArray_real32_T *e_cpu_A;
  emxArray_real32_T *e_cpu_B;
  emxArray_real32_T *e_cpu_zi;
  emxArray_real32_T *e_cpu_zo;
  emxArray_real32_T *f_cpu_A;
  emxArray_real32_T *f_cpu_B;
  emxArray_real32_T *f_cpu_zi;
  emxArray_real32_T *f_cpu_zo;
  emxArray_real32_T *g_cpu_A;
  emxArray_real32_T *g_cpu_B;
  emxArray_real32_T *h_cpu_A;
  emxArray_real32_T *h_cpu_B;
  emxArray_real32_T *i_cpu_A;
  emxArray_real32_T *i_cpu_B;
  emxArray_real32_T *j_cpu_A;
  emxArray_real32_T *j_cpu_B;
  emxArray_real32_T *k_cpu_A;
  emxArray_real32_T *k_cpu_B;
  emxArray_real32_T *l_cpu_A;
  emxArray_real32_T *l_cpu_B;
  emxArray_real32_T *num;
  emxArray_real32_T *r;
  emxArray_real32_T *r1;
  emxArray_real32_T *xc1;
  emxArray_real32_T *xt;
  emxArray_real32_T *ytemp;
  emxArray_real32_T *zi;
  real_T P;
  real_T Q;
  real_T numStage;
  int32_T i;
  real32_T Letr;
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
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_ytemp);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_r2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&g_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&g_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&l_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&l_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&f_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&f_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&f_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&k_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&k_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_xt);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&e_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&e_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&j_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&j_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_xt);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&i_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&i_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&e_gpu_zi);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&h_gpu_A);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&h_gpu_B);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_yc5);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_yc5);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu__2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&f_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu__4);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_yc3);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_ytemp);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&e_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_yc2);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu__1);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_zo);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu__3);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_xt);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_xc1);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_ytemp);
  r2_outdatedOnCpu = false;
  yc3_outdatedOnGpu = false;
  b_zo_outdatedOnCpu = false;
  b_zo_outdatedOnGpu = false;
  yc2_outdatedOnCpu = false;
  a__2_outdatedOnGpu = false;
  zo_outdatedOnCpu = false;
  zo_outdatedOnGpu = false;
  yc5_outdatedOnGpu = false;
  yc5_outdatedOnCpu = false;
  xt_outdatedOnCpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&X, 3, &b_emlrtRTEI, true);
  i = X->size[0] * X->size[1] * X->size[2];
  X->size[0] = varargin_2->size[0];
  X->size[1] = varargin_2->size[1];
  X->size[2] = varargin_2->size[2];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(X, i, &emlrtRTEI);
  profileLoopStart(
      "filtfilt_loop_0", __LINE__,
      (varargin_2->size[0] * varargin_2->size[1] * varargin_2->size[2] - 1) + 1,
      "1553");
  for (i = 0;
       i < varargin_2->size[0] * varargin_2->size[1] * varargin_2->size[2];
       i++) {
    X->data[i] = varargin_2->data[i];
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&num, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&den, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#filtfiltParser#" MW_AT_LINE);
  filtfiltParser(ctf, varargin_1, num, den, &numStage, &P, &Q, &xIsRow,
                 &yc5_outdatedOnGpu);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&B, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&A, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&zi, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_ytemp, 1, &wb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_xc1, 2, &xb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_xt, 2, &yb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&xt, 1, &j_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu__3, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_zo, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu__1, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_zo, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_yc2, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_zo, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_yc2, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_zo, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_ytemp, 1, &ac_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_yc3, 2, &bc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_yc3, 1, &cc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu__4, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&e_cpu_zo, 2, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu__2, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&f_cpu_zo, 1, &vb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_yc5, 2, &dc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_yc5, 1, &ec_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&r, 2, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&xc1, 2, &i_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_B, 2, &l_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_A, 2, &n_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_zi, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_B, 2, &t_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_A, 2, &u_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_B, 2, &m_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_A, 2, &o_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_xt, 1, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_zi, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_B, 2, &v_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_A, 2, &x_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_y, 1, &ab_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&e_cpu_B, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&e_cpu_A, 2, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_zi, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&ytemp, 1, &w_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&r1, 2, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_xc1, 2, &cb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&f_cpu_B, 2, &bb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&f_cpu_A, 2, &db_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_zi, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&g_cpu_B, 2, &eb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&g_cpu_A, 2, &fb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&h_cpu_B, 2, &jb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&h_cpu_A, 2, &lb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_xt, 1, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&i_cpu_B, 2, &ib_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&i_cpu_A, 2, &kb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_yc3, 2, &mb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&e_cpu_zi, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&j_cpu_B, 2, &nb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&j_cpu_A, 2, &pb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_yc3, 1, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&f_cpu_zi, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&k_cpu_B, 2, &ob_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&k_cpu_A, 2, &qb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_yc2, 2, &rb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&l_cpu_B, 2, &sb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&l_cpu_A, 2, &ub_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_yc2, 1, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_r2, 2, &fc_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_ytemp, 1, &gb_emlrtRTEI, true);
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(X, i, &b_emlrtRTEI);
    } else {
      xIsRow = false;
    }
    nvtxMarkA("#getCoeffsAndInitialConditions#" MW_AT_LINE);
    getCoeffsAndInitialConditions(num, den, numStage, P, Q, B, A, zi, &Letr);
    if (X->size[1] * X->size[2] == 1) {
      if (X->size[0] < 10000) {
        int32_T b_i;
        int32_T i1;
        real32_T Y_data[9999];
        yc5_outdatedOnGpu = false;
        a__2_outdatedOnGpu = false;
        b_i = X->size[0];
        profileLoopStart("filtfilt_loop_1", __LINE__, (X->size[0] - 1) + 1,
                         "1554");
        for (i = 0; i < X->size[0]; i++) {
          Y_data[i] = X->data[i];
        }
        profileLoopEnd();
        i1 = static_cast<int32_T>(numStage);
        profileLoopStart("filtfilt_loop_4", __LINE__, (i1 - 1) + 1, "1555");
        for (int32_T ii{0}; ii < i1; ii++) {
          int32_T b_loop_ub;
          int32_T i7;
          int32_T i9;
          int32_T loop_ub;
          real32_T b_y;
          real32_T f1;
          f1 = static_cast<real32_T>(b_i) - Letr;
          if (f1 > static_cast<real32_T>(b_i) - 1.0F) {
            loop_ub = 0;
            i7 = 1;
            i9 = -1;
          } else {
            loop_ub = b_i - 2;
            i7 = -1;
            i9 = static_cast<int32_T>(f1) - 1;
          }
          f1 = 2.0F * Y_data[0];
          b_y = 2.0F * Y_data[b_i - 1];
          yc5_outdatedOnCpu = false;
          i = b_cpu_ytemp->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_cpu_ytemp->size[0] = (static_cast<int32_T>(Letr + 1.0F) + b_i) +
                                 div_s32(i9 - loop_ub, i7);
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(b_cpu_ytemp, i, &k_emlrtRTEI);
          b_loop_ub = static_cast<int32_T>(Letr + 1.0F) - 2;
          profileLoopStart("filtfilt_loop_11", __LINE__, b_loop_ub + 1, "1556");
          for (i = 0; i <= b_loop_ub; i++) {
            b_cpu_ytemp->data[i] =
                f1 - Y_data[(static_cast<int32_T>(Letr + 1.0F) - i) - 1];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          profileLoopStart("filtfilt_loop_14", __LINE__, (b_i - 1) + 1, "1557");
          for (i = 0; i < b_i; i++) {
            b_cpu_ytemp->data[(i + static_cast<int32_T>(Letr + 1.0F)) - 1] =
                Y_data[i];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_loop_ub = div_s32(i9 - loop_ub, i7);
          profileLoopStart("filtfilt_loop_15", __LINE__, b_loop_ub + 1, "1558");
          for (i = 0; i <= b_loop_ub; i++) {
            b_cpu_ytemp
                ->data[((i + static_cast<int32_T>(Letr + 1.0F)) + b_i) - 1] =
                b_y - Y_data[loop_ub + i7 * i];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = e_cpu_B->size[0] * e_cpu_B->size[1];
          e_cpu_B->size[0] = 1;
          e_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(e_cpu_B, i, &p_emlrtRTEI);
          profileLoopStart("filtfilt_loop_18", __LINE__, (B->size[1] - 1) + 1,
                           "1559");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(e_cpu_A, i, &s_emlrtRTEI);
          profileLoopStart("filtfilt_loop_21", __LINE__, (A->size[1] - 1) + 1,
                           "1560");
          for (i = 0; i < A->size[1]; i++) {
            e_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = c_cpu_zi->size[0];
          c_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_cpu_zi, i, &e_emlrtRTEI);
          profileLoopStart("filtfilt_loop_24", __LINE__, (zi->size[0] - 1) + 1,
                           "1561");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(ytemp, i, &w_emlrtRTEI);
          profileLoopStart("filtfilt_loop_27", __LINE__, loop_ub + 1, "1562");
          for (i = 0; i <= loop_ub; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_ytemp, &b_gpu_ytemp);
            }
            yc5_outdatedOnGpu = false;
            ytemp->data[i] = cpu_ytemp->data[loop_ub - i];
          }
          profileLoopEnd();
          yc5_outdatedOnGpu = false;
          a__2_outdatedOnGpu = false;
          i = cpu_ytemp->size[0];
          cpu_ytemp->size[0] = ytemp->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(cpu_ytemp, i, &y_emlrtRTEI);
          profileLoopStart("filtfilt_loop_30", __LINE__,
                           (ytemp->size[0] - 1) + 1, "1563");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(f_cpu_B, i, &bb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_33", __LINE__, (B->size[1] - 1) + 1,
                           "1564");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(f_cpu_A, i, &db_emlrtRTEI);
          profileLoopStart("filtfilt_loop_35", __LINE__, (A->size[1] - 1) + 1,
                           "1565");
          for (i = 0; i < A->size[1]; i++) {
            f_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = d_cpu_zi->size[0];
          d_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(d_cpu_zi, i, &e_emlrtRTEI);
          profileLoopStart("filtfilt_loop_37", __LINE__, (zi->size[0] - 1) + 1,
                           "1566");
          for (i = 0; i < zi->size[0]; i++) {
            d_cpu_zi->data[i] =
                zi->data[i + zi->size[0] * ii] * cpu_ytemp->data[0];
            zi_outdatedOnGpu = true;
          }
          profileLoopEnd();
          yc5_outdatedOnCpu = false;
          i = c_cpu_ytemp->size[0];
          c_cpu_ytemp->size[0] = cpu_ytemp->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_cpu_ytemp, i, &gb_emlrtRTEI);
          b_loop_ub = cpu_ytemp->size[0] - 1;
          profileLoopStart("filtfilt_loop_41", __LINE__, b_loop_ub + 1, "1567");
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
          f1 = static_cast<real32_T>(cpu_ytemp->size[0]) - Letr;
          if (Letr + 1.0F > f1) {
            loop_ub = 1;
            i7 = 1;
          } else {
            loop_ub = static_cast<int32_T>(f1);
            i7 = -1;
          }
          profileLoopStart("filtfilt_loop_45", __LINE__, (b_i - 1) + 1, "1568");
          for (i = 0; i < b_i; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_ytemp, &b_gpu_ytemp);
            }
            yc5_outdatedOnGpu = false;
            Y_data[i] = cpu_ytemp->data[(loop_ub + i7 * i) - 1];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        i = y->size[0] * y->size[1] * y->size[2];
        y->size[0] = b_i;
        y->size[1] = 1;
        y->size[2] = 1;
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(y, i, &h_emlrtRTEI);
        profileLoopStart("filtfilt_loop_8", __LINE__, (b_i - 1) + 1, "1569");
        for (i = 0; i < b_i; i++) {
          y->data[i] = Y_data[i];
        }
        profileLoopEnd();
      } else {
        int32_T b_i;
        i = y->size[0] * y->size[1] * y->size[2];
        y->size[0] = X->size[0];
        y->size[1] = X->size[1];
        y->size[2] = X->size[2];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(y, i, &c_emlrtRTEI);
        profileLoopStart("filtfilt_loop_2", __LINE__,
                         (X->size[0] * X->size[1] * X->size[2] - 1) + 1,
                         "1570");
        for (i = 0; i < X->size[0] * X->size[1] * X->size[2]; i++) {
          y->data[i] = X->data[i];
        }
        profileLoopEnd();
        b_i = static_cast<int32_T>(numStage);
        profileLoopStart("filtfilt_loop_5", __LINE__, (b_i - 1) + 1, "1571");
        for (int32_T ii{0}; ii < b_i; ii++) {
          int32_T b_i1;
          int32_T b_loop_ub;
          int32_T i7;
          int32_T i9;
          int32_T loop_ub;
          real32_T f1;
          f1 = 2.0F * y->data[0];
          i = static_cast<int32_T>(Letr + 1.0F) - 1;
          b_i1 = xt->size[0];
          xt->size[0] = static_cast<int32_T>(Letr + 1.0F) - 1;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(xt, b_i1, &j_emlrtRTEI);
          profileLoopStart("filtfilt_loop_7", __LINE__, (i - 1) + 1, "1572");
          for (b_i1 = 0; b_i1 < i; b_i1++) {
            xt->data[b_i1] =
                -y->data[(static_cast<int32_T>(Letr + 1.0F) - b_i1) - 1] + f1;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = c_cpu_B->size[0] * c_cpu_B->size[1];
          c_cpu_B->size[0] = 1;
          c_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_cpu_B, i, &m_emlrtRTEI);
          profileLoopStart("filtfilt_loop_12", __LINE__, (B->size[1] - 1) + 1,
                           "1573");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_cpu_A, i, &o_emlrtRTEI);
          profileLoopStart("filtfilt_loop_16", __LINE__, (A->size[1] - 1) + 1,
                           "1574");
          for (i = 0; i < A->size[1]; i++) {
            c_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          xt_outdatedOnGpu = false;
          i = b_cpu_xt->size[0];
          b_cpu_xt->size[0] = xt->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(b_cpu_xt, i, &r_emlrtRTEI);
          profileLoopStart("filtfilt_loop_19", __LINE__, (xt->size[0] - 1) + 1,
                           "1575");
          for (i = 0; i < xt->size[0]; i++) {
            b_cpu_xt->data[i] = xt->data[i];
            xt_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = b_cpu_zi->size[0];
          b_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(b_cpu_zi, i, &e_emlrtRTEI);
          profileLoopStart("filtfilt_loop_22", __LINE__, (zi->size[0] - 1) + 1,
                           "1576");
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
                   &yc5_outdatedOnGpu, &gpu__1, &a__2_outdatedOnGpu, b_cpu_zo,
                   &zo_outdatedOnCpu, &gpu_zo, &zo_outdatedOnGpu);
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = d_cpu_B->size[0] * d_cpu_B->size[1];
          d_cpu_B->size[0] = 1;
          d_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(d_cpu_B, i, &v_emlrtRTEI);
          profileLoopStart("filtfilt_loop_26", __LINE__, (B->size[1] - 1) + 1,
                           "1577");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(d_cpu_A, i, &x_emlrtRTEI);
          profileLoopStart("filtfilt_loop_29", __LINE__, (A->size[1] - 1) + 1,
                           "1578");
          for (i = 0; i < A->size[1]; i++) {
            d_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          i = y->size[0];
          yc5_outdatedOnCpu = false;
          b_i1 = cpu_y->size[0];
          cpu_y->size[0] = y->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(cpu_y, b_i1, &ab_emlrtRTEI);
          profileLoopStart("filtfilt_loop_32", __LINE__, (i - 1) + 1, "1579");
          for (b_i1 = 0; b_i1 < i; b_i1++) {
            cpu_y->data[b_i1] = y->data[b_i1];
            yc5_outdatedOnCpu = true;
          }
          profileLoopEnd();
          nvtxMarkA("#b_filter#" MW_AT_LINE);
          b_filter(d_cpu_B, &B_outdatedOnCpu, &d_gpu_B, &B_outdatedOnGpu,
                   d_cpu_A, &A_outdatedOnCpu, &d_gpu_A, &A_outdatedOnGpu, cpu_y,
                   &gpu_y, &yc5_outdatedOnCpu, b_cpu_zo, &zo_outdatedOnCpu,
                   &gpu_zo, &zo_outdatedOnGpu, b_cpu_yc2, &yc2_outdatedOnCpu,
                   &gpu_yc2, &a__2_outdatedOnGpu, d_cpu_zo, &b_zo_outdatedOnCpu,
                   &b_gpu_zo, &b_zo_outdatedOnGpu);
          f1 = static_cast<real32_T>(y->size[0]) - Letr;
          if (f1 >
              static_cast<real32_T>(static_cast<real_T>(y->size[0]) - 1.0)) {
            loop_ub = 0;
            i7 = 1;
            i9 = -1;
          } else {
            loop_ub = static_cast<int32_T>(static_cast<real32_T>(
                          static_cast<real_T>(y->size[0]) - 1.0)) -
                      1;
            i7 = -1;
            i9 = static_cast<int32_T>(f1) - 1;
          }
          f1 = 2.0F * y->data[y->size[0] - 1];
          i = xt->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          xt->size[0] = div_s32(i9 - loop_ub, i7) + 1;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(xt, i, &hb_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_34", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1580");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i9 - loop_ub, i7); i++) {
            xt->data[i] = -y->data[loop_ub + i7 * i] + f1;
          }
          profileLoopEnd();
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = h_cpu_B->size[0] * h_cpu_B->size[1];
          h_cpu_B->size[0] = 1;
          h_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(h_cpu_B, i, &jb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_39", __LINE__, (B->size[1] - 1) + 1,
                           "1581");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(h_cpu_A, i, &lb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_42", __LINE__, (A->size[1] - 1) + 1,
                           "1582");
          for (i = 0; i < A->size[1]; i++) {
            h_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          xt_outdatedOnGpu = false;
          i = c_cpu_xt->size[0];
          c_cpu_xt->size[0] = xt->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(c_cpu_xt, i, &r_emlrtRTEI);
          profileLoopStart("filtfilt_loop_44", __LINE__, (xt->size[0] - 1) + 1,
                           "1583");
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
            i7 = 1;
            i9 = -1;
          } else {
            loop_ub = b_cpu_yc3->size[0] - 1;
            i7 = -1;
            i9 = 0;
          }
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = j_cpu_B->size[0] * j_cpu_B->size[1];
          j_cpu_B->size[0] = 1;
          j_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(j_cpu_B, i, &nb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_46", __LINE__, (B->size[1] - 1) + 1,
                           "1584");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(j_cpu_A, i, &pb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_48", __LINE__, (A->size[1] - 1) + 1,
                           "1585");
          for (i = 0; i < A->size[1]; i++) {
            j_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          yc5_outdatedOnCpu = false;
          yc3_outdatedOnGpu = false;
          i = d_cpu_yc3->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          d_cpu_yc3->size[0] = div_s32(i9 - loop_ub, i7) + 1;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(d_cpu_yc3, i, &r_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_50", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1586");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i9 - loop_ub, i7); i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_yc3, &gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            d_cpu_yc3->data[i] = b_cpu_yc3->data[loop_ub + i7 * i];
            yc3_outdatedOnGpu = true;
          }
          profileLoopEnd();
          zi_outdatedOnCpu = false;
          zi_outdatedOnGpu = false;
          i = f_cpu_zi->size[0];
          f_cpu_zi->size[0] = zi->size[0];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(f_cpu_zi, i, &e_emlrtRTEI);
          profileLoopStart("filtfilt_loop_52", __LINE__, (zi->size[0] - 1) + 1,
                           "1587");
          for (i = 0; i < zi->size[0]; i++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_yc3, &gpu_yc3);
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
            i7 = 1;
            i9 = -1;
          } else {
            loop_ub = b_cpu_yc2->size[0] - 1;
            i7 = -1;
            i9 = 0;
          }
          B_outdatedOnCpu = false;
          B_outdatedOnGpu = false;
          i = l_cpu_B->size[0] * l_cpu_B->size[1];
          l_cpu_B->size[0] = 1;
          l_cpu_B->size[1] = B->size[1];
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(l_cpu_B, i, &sb_emlrtRTEI);
          profileLoopStart("filtfilt_loop_56", __LINE__, (B->size[1] - 1) + 1,
                           "1588");
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
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(l_cpu_A, i, &ub_emlrtRTEI);
          profileLoopStart("filtfilt_loop_58", __LINE__, (A->size[1] - 1) + 1,
                           "1589");
          for (i = 0; i < A->size[1]; i++) {
            l_cpu_A->data[i] = A->data[ii + A->size[0] * i];
            A_outdatedOnGpu = true;
          }
          profileLoopEnd();
          a__2_outdatedOnGpu = false;
          i = d_cpu_yc2->size[0];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          d_cpu_yc2->size[0] = div_s32(i9 - loop_ub, i7) + 1;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(d_cpu_yc2, i, &r_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_59", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1590");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (i = 0; i <= div_s32(i9 - loop_ub, i7); i++) {
            if (yc2_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_yc2, &gpu_yc2);
            }
            yc2_outdatedOnCpu = false;
            d_cpu_yc2->data[i] = b_cpu_yc2->data[loop_ub + i7 * i];
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
            i7 = 0;
            i9 = 1;
            loop_ub = -1;
          } else {
            i7 = b_cpu_yc5->size[0] - 1;
            i9 = -1;
            loop_ub = 0;
          }
          i = y->size[0] * y->size[1] * y->size[2];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          y->size[0] = div_s32(loop_ub - i7, i9) + 1;
          y->size[1] = 1;
          y->size[2] = 1;
          nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
          emxEnsureCapacity_real32_T(y, i, &c_emlrtRTEI);
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          b_loop_ub = div_s32(loop_ub - i7, i9) + 1;
          profileLoopStart("filtfilt_loop_62", __LINE__, (b_loop_ub - 1) + 1,
                           "1591");
          for (i = 0; i < b_loop_ub; i++) {
            if (yc5_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_yc5, &gpu_yc5);
            }
            yc5_outdatedOnCpu = false;
            y->data[i] = b_cpu_yc5->data[i7 + i9 * i];
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_xc1, i, &d_emlrtRTEI);
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      profileLoopStart("filtfilt_loop_3", __LINE__,
                       (static_cast<int32_T>(sz_idx_0) *
                            div_s32(X->size[0] * X->size[1] * X->size[2],
                                    static_cast<int32_T>(sz_idx_0)) -
                        1) +
                           1,
                       "1592");
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
      profileLoopStart("filtfilt_loop_6", __LINE__, (i1 - 1) + 1, "1593");
      for (int32_T ii{0}; ii < i1; ii++) {
        int32_T b_i1;
        int32_T b_loop_ub;
        int32_T i7;
        int32_T i9;
        int32_T loop_ub;
        real32_T f1;
        i = r->size[0] * r->size[1];
        r->size[0] = 1;
        r->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(r, i, &e_emlrtRTEI);
        i = static_cast<int32_T>(Letr + 1.0F) - 1;
        b_i1 = xc1->size[0] * xc1->size[1];
        xc1->size[0] = static_cast<int32_T>(Letr + 1.0F) - 1;
        xc1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(xc1, b_i1, &i_emlrtRTEI);
        profileLoopStart("filtfilt_loop_10", __LINE__,
                         (cpu_xc1->size[1] - 1) + 1, "1594");
        for (b_i1 = 0; b_i1 < cpu_xc1->size[1]; b_i1++) {
          r->data[b_i1] = 2.0F * cpu_xc1->data[cpu_xc1->size[0] * b_i1];
          profileLoopStart("filtfilt_loop_13", __LINE__, (i - 1) + 1, "1595");
          for (loop_ub = 0; loop_ub < i; loop_ub++) {
            xc1->data[loop_ub + xc1->size[0] * b_i1] =
                cpu_xc1->data[((static_cast<int32_T>(Letr + 1.0F) - loop_ub) +
                               cpu_xc1->size[0] * b_i1) -
                              1];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        if (xt_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xt, &c_gpu_xt);
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_B, i, &l_emlrtRTEI);
        profileLoopStart("filtfilt_loop_17", __LINE__, (B->size[1] - 1) + 1,
                         "1596");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_A, i, &n_emlrtRTEI);
        profileLoopStart("filtfilt_loop_20", __LINE__, (A->size[1] - 1) + 1,
                         "1597");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_zi, i, &q_emlrtRTEI);
        b_loop_ub = cpu_xt->size[1];
        profileLoopStart("filtfilt_loop_23", __LINE__, (b_loop_ub - 1) + 1,
                         "1598");
        for (i = 0; i < b_loop_ub; i++) {
          loop_ub = zi->size[0];
          profileLoopStart("filtfilt_loop_25", __LINE__, (loop_ub - 1) + 1,
                           "1599");
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
                 &gpu__3, &yc5_outdatedOnCpu, cpu_zo, &zo_outdatedOnCpu,
                 &d_gpu_zo, &zo_outdatedOnGpu);
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = b_cpu_B->size[0] * b_cpu_B->size[1];
        b_cpu_B->size[0] = 1;
        b_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_cpu_B, i, &t_emlrtRTEI);
        profileLoopStart("filtfilt_loop_28", __LINE__, (B->size[1] - 1) + 1,
                         "1600");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_cpu_A, i, &u_emlrtRTEI);
        profileLoopStart("filtfilt_loop_31", __LINE__, (A->size[1] - 1) + 1,
                         "1601");
        for (i = 0; i < A->size[1]; i++) {
          b_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#c_filter#" MW_AT_LINE);
        c_filter(b_cpu_B, &B_outdatedOnCpu, &i_gpu_B, &B_outdatedOnGpu, b_cpu_A,
                 &A_outdatedOnCpu, &i_gpu_A, &A_outdatedOnGpu, cpu_xc1,
                 &gpu_xc1, &yc3_outdatedOnGpu, cpu_zo, &zo_outdatedOnCpu,
                 &d_gpu_zo, &zo_outdatedOnGpu, cpu_yc2, &yc2_outdatedOnCpu,
                 &c_gpu_yc2, &a__2_outdatedOnGpu, c_cpu_zo, &b_zo_outdatedOnCpu,
                 &e_gpu_zo, &b_zo_outdatedOnGpu);
        f1 = static_cast<real32_T>(cpu_xc1->size[0]) - Letr;
        if (f1 > static_cast<real32_T>(static_cast<real_T>(cpu_xc1->size[0]) -
                                       1.0)) {
          loop_ub = 0;
          i7 = 1;
          i9 = -1;
        } else {
          loop_ub = static_cast<int32_T>(static_cast<real32_T>(
                        static_cast<real_T>(cpu_xc1->size[0]) - 1.0)) -
                    1;
          i7 = -1;
          i9 = static_cast<int32_T>(f1) - 1;
        }
        i = r1->size[0] * r1->size[1];
        r1->size[0] = 1;
        r1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(r1, i, &e_emlrtRTEI);
        i = b_xc1->size[0] * b_xc1->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        b_xc1->size[0] = div_s32(i9 - loop_ub, i7) + 1;
        b_xc1->size[1] = cpu_xc1->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_xc1, i, &cb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_36", __LINE__,
                         (cpu_xc1->size[1] - 1) + 1, "1602");
        for (i = 0; i < cpu_xc1->size[1]; i++) {
          if (a__4_outdatedOnGpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_xc1, &gpu_xc1);
          }
          a__4_outdatedOnGpu = false;
          r1->data[i] =
              2.0F *
              cpu_xc1->data[(cpu_xc1->size[0] + cpu_xc1->size[0] * i) - 1];
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_38", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1603");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i9 - loop_ub, i7); b_i1++) {
            b_xc1->data[b_i1 + b_xc1->size[0] * i] =
                cpu_xc1->data[(loop_ub + i7 * b_i1) + cpu_xc1->size[0] * i];
          }
          profileLoopEnd();
        }
        profileLoopEnd();
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = g_cpu_B->size[0] * g_cpu_B->size[1];
        g_cpu_B->size[0] = 1;
        g_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(g_cpu_B, i, &eb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_40", __LINE__, (B->size[1] - 1) + 1,
                         "1604");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(g_cpu_A, i, &fb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_43", __LINE__, (A->size[1] - 1) + 1,
                         "1605");
        for (i = 0; i < A->size[1]; i++) {
          g_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        if (r2_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_r2, &gpu_r2);
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
          i7 = 1;
          i9 = -1;
        } else {
          loop_ub = cpu_yc3->size[0] - 1;
          i7 = -1;
          i9 = 0;
        }
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = i_cpu_B->size[0] * i_cpu_B->size[1];
        i_cpu_B->size[0] = 1;
        i_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(i_cpu_B, i, &ib_emlrtRTEI);
        profileLoopStart("filtfilt_loop_47", __LINE__, (B->size[1] - 1) + 1,
                         "1606");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(i_cpu_A, i, &kb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_49", __LINE__, (A->size[1] - 1) + 1,
                         "1607");
        for (i = 0; i < A->size[1]; i++) {
          i_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        yc5_outdatedOnCpu = false;
        yc3_outdatedOnGpu = false;
        i = c_cpu_yc3->size[0] * c_cpu_yc3->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc3->size[0] = div_s32(i9 - loop_ub, i7) + 1;
        c_cpu_yc3->size[1] = cpu_yc3->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(c_cpu_yc3, i, &mb_emlrtRTEI);
        zi_outdatedOnCpu = false;
        zi_outdatedOnGpu = false;
        i = e_cpu_zi->size[0] * e_cpu_zi->size[1];
        e_cpu_zi->size[0] = zi->size[0];
        e_cpu_zi->size[1] = cpu_yc3->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(e_cpu_zi, i, &q_emlrtRTEI);
        profileLoopStart("filtfilt_loop_51", __LINE__,
                         (cpu_yc3->size[1] - 1) + 1, "1608");
        for (i = 0; i < cpu_yc3->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_53", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1609");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i9 - loop_ub, i7); b_i1++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc3, &c_gpu_yc3);
            }
            yc5_outdatedOnGpu = false;
            c_cpu_yc3->data[b_i1 + c_cpu_yc3->size[0] * i] =
                cpu_yc3->data[(loop_ub + i7 * b_i1) + cpu_yc3->size[0] * i];
            yc3_outdatedOnGpu = true;
          }
          profileLoopEnd();
          b_loop_ub = zi->size[0];
          profileLoopStart("filtfilt_loop_54", __LINE__, (b_loop_ub - 1) + 1,
                           "1610");
          for (b_i1 = 0; b_i1 < b_loop_ub; b_i1++) {
            if (yc5_outdatedOnGpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc3, &c_gpu_yc3);
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
          i7 = 1;
          i9 = -1;
        } else {
          loop_ub = cpu_yc2->size[0] - 1;
          i7 = -1;
          i9 = 0;
        }
        B_outdatedOnCpu = false;
        B_outdatedOnGpu = false;
        i = k_cpu_B->size[0] * k_cpu_B->size[1];
        k_cpu_B->size[0] = 1;
        k_cpu_B->size[1] = B->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(k_cpu_B, i, &ob_emlrtRTEI);
        profileLoopStart("filtfilt_loop_55", __LINE__, (B->size[1] - 1) + 1,
                         "1611");
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
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(k_cpu_A, i, &qb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_57", __LINE__, (A->size[1] - 1) + 1,
                         "1612");
        for (i = 0; i < A->size[1]; i++) {
          k_cpu_A->data[i] = A->data[ii + A->size[0] * i];
          A_outdatedOnGpu = true;
        }
        profileLoopEnd();
        a__2_outdatedOnGpu = false;
        i = c_cpu_yc2->size[0] * c_cpu_yc2->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc2->size[0] = div_s32(i9 - loop_ub, i7) + 1;
        c_cpu_yc2->size[1] = cpu_yc2->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(c_cpu_yc2, i, &rb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_60", __LINE__,
                         (cpu_yc2->size[1] - 1) + 1, "1613");
        for (i = 0; i < cpu_yc2->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_61", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1614");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i9 - loop_ub, i7); b_i1++) {
            if (yc2_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc2, &c_gpu_yc2);
            }
            yc2_outdatedOnCpu = false;
            c_cpu_yc2->data[b_i1 + c_cpu_yc2->size[0] * i] =
                cpu_yc2->data[(loop_ub + i7 * b_i1) + cpu_yc2->size[0] * i];
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
          i7 = 1;
          i9 = -1;
        } else {
          loop_ub = cpu_yc5->size[0] - 1;
          i7 = -1;
          i9 = 0;
        }
        a__4_outdatedOnGpu = false;
        yc3_outdatedOnGpu = false;
        i = cpu_xc1->size[0] * cpu_xc1->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        cpu_xc1->size[0] = div_s32(i9 - loop_ub, i7) + 1;
        cpu_xc1->size[1] = cpu_yc5->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_xc1, i, &tb_emlrtRTEI);
        profileLoopStart("filtfilt_loop_63", __LINE__,
                         (cpu_yc5->size[1] - 1) + 1, "1615");
        for (i = 0; i < cpu_yc5->size[1]; i++) {
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          profileLoopStart("filtfilt_loop_64", __LINE__,
                           div_s32(i9 - loop_ub, i7) + 1, "1616");
          nvtxMarkA("#div_s32#" MW_AT_LINE);
          for (b_i1 = 0; b_i1 <= div_s32(i9 - loop_ub, i7); b_i1++) {
            if (yc5_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc5, &b_gpu_yc5);
            }
            yc5_outdatedOnCpu = false;
            cpu_xc1->data[b_i1 + cpu_xc1->size[0] * i] =
                cpu_yc5->data[(loop_ub + i7 * b_i1) + cpu_yc5->size[0] * i];
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(y, i, &f_emlrtRTEI);
      profileLoopStart(
          "filtfilt_loop_9", __LINE__,
          (static_cast<int32_T>(sz_idx_0) * static_cast<int32_T>(sz_idx_1) *
               static_cast<int32_T>(sz_idx_2) -
           1) +
              1,
          "1617");
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
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(y, i, &g_emlrtRTEI);
    }
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_ytemp);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_r2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_yc2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&l_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&l_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_yc2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&k_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&k_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&f_cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_yc3);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&j_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&j_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&e_cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_yc3);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&i_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&i_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_xt);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&h_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&h_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&g_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&g_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&f_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&f_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_xc1);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&r1);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&ytemp);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&e_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&e_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_y);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_xt);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&xc1);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&r);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_yc5);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_yc5);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&f_cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu__2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&e_cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu__4);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_yc3);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_yc3);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_ytemp);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_yc2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_yc2);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu__1);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_zo);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu__3);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&xt);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_xt);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_xc1);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_ytemp);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&zi);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&A);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&B);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&X);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&den);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&num);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_ytemp);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_xc1);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_xt);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu__3);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu__1);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&e_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_ytemp);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu__4);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&f_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu__2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_zo);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_yc5);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_yc5);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&h_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&h_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&e_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&i_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&i_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_xt);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&j_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&j_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&e_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&e_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_xt);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&k_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&k_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&f_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&f_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&f_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_yc3);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_zi);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&l_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&l_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&g_gpu_B);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&g_gpu_A);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_yc2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_r2);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_ytemp);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

} // namespace coder

// End of code generation (filtfilt.cu)
