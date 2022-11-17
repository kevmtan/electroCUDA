//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle_data.cu
//
// Code generation for function 'ec_CWTsingle_data'
//

// Include files
#include "ec_CWTsingle_data.h"
#include "rt_nonfinite.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emxArray_real32_T *psidft;

boolean_T psidft_not_empty;

emxArray_real32_T *cf;

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131627U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "ec_CWTsingle",                                       // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {1075284325U, 2201364878U, 3488609979U, 1269018621U}, // fSigWrd
    nullptr                                               // fSigMem
};

// End of code generation (ec_CWTsingle_data.cu)
