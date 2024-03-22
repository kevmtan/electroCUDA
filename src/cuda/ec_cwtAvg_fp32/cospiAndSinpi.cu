//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cospiAndSinpi.cu
//
// Code generation for function 'cospiAndSinpi'
//

// Include files
#include "cospiAndSinpi.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
namespace internal {
namespace scalar {
real_T cospiAndSinpi(real_T x, real_T *s)
{
  real_T c;
  boolean_T negateSinpi;
  if (x < 0.0) {
    x = -x;
    negateSinpi = true;
  } else {
    negateSinpi = false;
  }
  if (x < 0.25) {
    c = std::cos(x * 3.1415926535897931);
    *s = std::sin(x * 3.1415926535897931);
  } else {
    real_T r;
    r = x - 2.0 * std::floor(x / 2.0);
    if (r < 0.25) {
      r *= 3.1415926535897931;
      c = std::cos(r);
      *s = std::sin(r);
    } else if (r < 0.75) {
      r = 0.5 - r;
      r *= 3.1415926535897931;
      c = std::sin(r);
      *s = std::cos(r);
    } else if (r < 1.25) {
      r = 1.0 - r;
      r *= 3.1415926535897931;
      c = -std::cos(r);
      *s = std::sin(r);
    } else if (r < 1.75) {
      r -= 1.5;
      r *= 3.1415926535897931;
      c = std::sin(r);
      *s = -std::cos(r);
    } else {
      r -= 2.0;
      r *= 3.1415926535897931;
      c = std::cos(r);
      *s = std::sin(r);
    }
  }
  if (negateSinpi) {
    *s = -*s;
  }
  return c;
}

} // namespace scalar
} // namespace internal
} // namespace coder

// End of code generation (cospiAndSinpi.cu)
