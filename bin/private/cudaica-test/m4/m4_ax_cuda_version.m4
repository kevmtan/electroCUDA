AC_DEFUN([AX_CUDA_VERSION], [
  CUDA_VERSION=""
  AC_CACHE_CHECK([cuda toolkit version],[ax_cv_cuda_version],[
        ax_cv_cuda_version="`$NVCC --version | grep release | cut -d',' -f2 | cut -d' ' -f3 | cut -d '.' -f 1`"
        AS_IF([test "x$ax_cv_cuda_version" = "x"],[
          ax_cv_cuda_version=""
        ])
      ])
      CUDA_VERSION=$ax_cv_cuda_version
  AC_SUBST([CUDA_VERSION])
])
