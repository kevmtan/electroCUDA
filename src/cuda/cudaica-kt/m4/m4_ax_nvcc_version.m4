AC_DEFUN([AX_NVCC_VERSION], [
  NVCC_VERSION=""
  AC_CACHE_CHECK([nvcc version],[ax_cv_nvcc_version],[
        ax_cv_nvcc_version="`$NVCC --version | grep release | cut -d',' -f2 | cut -d' ' -f3`"
        AS_IF([test "x$ax_cv_nvcc_version" = "x"],[
          ax_cv_nvcc_version=""
        ])
      ])
      NVCC_VERSION=$ax_cv_nvcc_version
  AC_SUBST([NVCC_VERSION])
])
