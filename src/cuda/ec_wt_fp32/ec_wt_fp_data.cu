//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp_data.cu
//
// Code generation for function 'ec_wt_fp_data'
//

// Include files
#include "ec_wt_fp_data.h"
#include "rt_nonfinite.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131643U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "ec_wt_fp",                                           // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {3334663369U, 2606893378U, 3553281593U, 3751928550U}, // fSigWrd
    nullptr                                               // fSigMem
};

emlrtMCInfo f_emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

emlrtRTEInfo e_emlrtRTEI{
    230,             // lineNo
    1,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

emlrtRTEInfo j_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

emlrtRTEInfo m_emlrtRTEI{
    129,                         // lineNo
    6,                           // colNo
    "applyBinaryScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyBinaryScalarFunction.m" // pName
};

emlrtRTEInfo p_emlrtRTEI{
    60,                                                              // lineNo
    20,                                                              // colNo
    "bsxfun",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m" // pName
};

emlrtRTEInfo ab_emlrtRTEI{
    236,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

emlrtRTEInfo ib_emlrtRTEI{
    28,                                                           // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

emlrtRTEInfo qb_emlrtRTEI{
    31,               // lineNo
    23,               // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

emlrtRTEInfo rb_emlrtRTEI{
    34,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

emlrtRTEInfo tb_emlrtRTEI{
    31,               // lineNo
    1,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

emlrtRTEInfo lc_emlrtRTEI{
    273,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo mc_emlrtRTEI{
    445,                                                              // lineNo
    20,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo nc_emlrtRTEI{
    446,                                                              // lineNo
    21,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo pc_emlrtRTEI{
    486,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo qc_emlrtRTEI{
    498,                                                              // lineNo
    5,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo rc_emlrtRTEI{
    445,                                                              // lineNo
    1,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo sc_emlrtRTEI{
    446,                                                              // lineNo
    1,                                                                // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

emlrtRTEInfo xc_emlrtRTEI{
    63,                // lineNo
    17,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

emlrtRTEInfo hd_emlrtRTEI{
    294,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

emlrtRTEInfo ne_emlrtRTEI{
    91,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

emlrtRTEInfo oe_emlrtRTEI{
    1,                // lineNo
    1,                // colNo
    "upfirdnGPUImpl", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+codegenable/+gpu/upfirdnGPUImpl.p" // pName
};

emlrtRTEInfo pe_emlrtRTEI{
    71,                                                     // lineNo
    5,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

emlrtRTEInfo qe_emlrtRTEI{
    88,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

emlrtRTEInfo re_emlrtRTEI{
    22,                        // lineNo
    23,                        // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
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

const real_T dv3[7]{-0.001910444077728,      0.00084171387781295,
                    -0.00059523799130430121, 0.0007936507935003503,
                    -0.0027777777777776816,  0.083333333333333329,
                    0.0057083835261};

// End of code generation (ec_wt_fp_data.cu)
