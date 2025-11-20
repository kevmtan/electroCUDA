//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtc_fp_data.cu
//
// Code generation for function 'ec_wtc_fp_data'
//

// Include files
#include "ec_wtc_fp_data.h"
#include "rt_nonfinite.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131643U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "ec_wtc_fp",                                          // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {3334663369U, 2606893378U, 3553281593U, 3751928550U}, // fSigWrd
    nullptr                                               // fSigMem
};

emlrtMCInfo emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

emlrtRTEInfo g_emlrtRTEI{
    154,                                                        // lineNo
    1,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

emlrtRTEInfo h_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

emlrtRTEInfo k_emlrtRTEI{
    816,              // lineNo
    22,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo l_emlrtRTEI{
    816,              // lineNo
    17,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo m_emlrtRTEI{
    777,              // lineNo
    13,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo n_emlrtRTEI{
    28,                                                           // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

emlrtRTEInfo o_emlrtRTEI{
    778,              // lineNo
    15,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo p_emlrtRTEI{
    38,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

emlrtRTEInfo r_emlrtRTEI{
    21,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

emlrtRTEInfo s_emlrtRTEI{
    31,                      // lineNo
    29,                      // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

emlrtRTEInfo t_emlrtRTEI{
    91,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

emlrtRTEInfo v_emlrtRTEI{
    1,                // lineNo
    1,                // colNo
    "upfirdnGPUImpl", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+codegenable/+gpu/upfirdnGPUImpl.p" // pName
};

emlrtRTEInfo w_emlrtRTEI{
    71,                                                     // lineNo
    5,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

emlrtRTEInfo ab_emlrtRTEI{
    778,              // lineNo
    27,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo bb_emlrtRTEI{
    778,              // lineNo
    13,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

emlrtRTEInfo cb_emlrtRTEI{
    15,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

emlrtRTEInfo db_emlrtRTEI{
    88,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

emlrtRTEInfo eb_emlrtRTEI{
    22,                        // lineNo
    23,                        // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

emlrtRTEInfo hb_emlrtRTEI{
    135,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo ib_emlrtRTEI{
    138,  // lineNo
    19,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo jb_emlrtRTEI{
    180,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo kb_emlrtRTEI{
    129,                         // lineNo
    6,                           // colNo
    "applyBinaryScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyBinaryScalarFunction.m" // pName
};

emlrtRTEInfo lb_emlrtRTEI{
    138,  // lineNo
    6,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo nb_emlrtRTEI{
    220,                                                            // lineNo
    1,                                                              // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

emlrtRTEInfo qb_emlrtRTEI{
    143,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo vb_emlrtRTEI{
    156,  // lineNo
    17,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

emlrtRTEInfo fc_emlrtRTEI{
    60,                                                              // lineNo
    20,                                                              // colNo
    "bsxfun",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m" // pName
};

emlrtRTEInfo mc_emlrtRTEI{
    34,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

emlrtRTEInfo wc_emlrtRTEI{
    273,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo xc_emlrtRTEI{
    445,                                                              // lineNo
    20,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo yc_emlrtRTEI{
    446,                                                              // lineNo
    21,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo bd_emlrtRTEI{
    486,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo cd_emlrtRTEI{
    498,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo dd_emlrtRTEI{
    445,                                                              // lineNo
    1,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo ed_emlrtRTEI{
    446,                                                              // lineNo
    1,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo jd_emlrtRTEI{
    63,                // lineNo
    17,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

emlrtRTEInfo ud_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

emlrtRTEInfo wf_emlrtRTEI{
    49,                                                               // lineNo
    31,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

emlrtRTEInfo ag_emlrtRTEI{
    75,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

emlrtRTEInfo cg_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

emlrtRTEInfo dg_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

emlrtRTEInfo eg_emlrtRTEI{
    49,                                                               // lineNo
    13,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

emlrtRTEInfo fg_emlrtRTEI{
    82,                                                           // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

emlrtRTEInfo gg_emlrtRTEI{
    1,                  // lineNo
    1,                  // colNo
    "gpu_conv2_kernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+images/gpu_conv2_kernel.p" // pName
};

emlrtRTEInfo
    ig_emlrtRTEI{
        88,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

const char_T cv[128]{
    '\x00', '\x01', '\x02', '\x03', '\x04', '\x05', '\x06', '\a',   '\b',
    '\t',   '\n',   '\v',   '\f',   '\r',   '\x0e', '\x0f', '\x10', '\x11',
    '\x12', '\x13', '\x14', '\x15', '\x16', '\x17', '\x18', '\x19', '\x1a',
    '\x1b', '\x1c', '\x1d', '\x1e', '\x1f', ' ',    '!',    '\"',   '#',
    '$',    '%',    '&',    '\'',   '(',    ')',    '*',    '+',    ',',
    '-',    '.',    '/',    '0',    '1',    '2',    '3',    '4',    '5',
    '6',    '7',    '8',    '9',    ':',    ';',    '<',    '=',    '>',
    '?',    '@',    'a',    'b',    'c',    'd',    'e',    'f',    'g',
    'h',    'i',    'j',    'k',    'l',    'm',    'n',    'o',    'p',
    'q',    'r',    's',    't',    'u',    'v',    'w',    'x',    'y',
    'z',    '[',    '\\',   ']',    '^',    '_',    '`',    'a',    'b',
    'c',    'd',    'e',    'f',    'g',    'h',    'i',    'j',    'k',
    'l',    'm',    'n',    'o',    'p',    'q',    'r',    's',    't',
    'u',    'v',    'w',    'x',    'y',    'z',    '{',    '|',    '}',
    '~',    '\x7f'};

const real_T dv[15]{-0.99145537112081261, -0.94910791234275849,
                    -0.8648644233597691,  -0.74153118559939435,
                    -0.58608723546769115, -0.40584515137739718,
                    -0.20778495500789851, 0.0,
                    0.20778495500789851,  0.40584515137739718,
                    0.58608723546769115,  0.74153118559939435,
                    0.8648644233597691,   0.94910791234275849,
                    0.99145537112081261};

const real_T dv1[15]{
    0.022935322010529221, 0.063092092629978544, 0.1047900103222502,
    0.14065325971552589,  0.16900472663926791,  0.19035057806478539,
    0.20443294007529891,  0.20948214108472779,  0.20443294007529891,
    0.19035057806478539,  0.16900472663926791,  0.14065325971552589,
    0.1047900103222502,   0.063092092629978544, 0.022935322010529221};

const real_T dv2[15]{
    0.022935322010529221, -0.066392873538891159, 0.1047900103222502,
    -0.13905213177375081, 0.16900472663926791,   -0.19147947244033353,
    0.20443294007529891,  -0.20847704258874161,  0.20443294007529891,
    -0.19147947244033353, 0.16900472663926791,   -0.13905213177375081,
    0.1047900103222502,   -0.066392873538891159, 0.022935322010529221};

// End of code generation (ec_wtc_fp_data.cu)
