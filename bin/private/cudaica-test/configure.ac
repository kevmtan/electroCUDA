#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])
AC_INIT([cudaica], [2.0], [fraimondo@dc.uba.ar])
AM_INIT_AUTOMAKE([cudaica], [2.0])
AC_CONFIG_SRCDIR([cudaica.c])
#~ AC_CONFIG_HEADERS([includes/config.h])
m4_include([m4/m4_ax_blas.m4])
m4_include([m4/m4_ax_lapack.m4])
m4_include([m4/m4_ax_check_compile_flag.m4])
m4_include([m4/m4_ax_gcc_version.m4])
m4_include([m4/m4_ax_nvcc_version.m4])
m4_include([m4/m4_ax_cuda_version.m4])
# Checks for programs.
AC_PROG_CXX([g++])
AC_PROG_CC([gcc])
AX_GCC_VERSION
#~ echo $GCC_VERSION
AC_CANONICAL_HOST

ACX_BLAS([],AC_MSG_ERROR([BLAS library is needed.]))
AX_LAPACK([],AC_MSG_ERROR([LAPACK library is needed.]))
#CHECK FOR CUDA
AC_ARG_WITH([cuda],
    [AS_HELP_STRING([--with-cuda],
		[PATH prefix where cuda is installed  @<:@default=/usr/local/cuda@:>@])
	])

AC_ARG_WITH([cuda-arch],
    [AS_HELP_STRING([--with-cuda-arch],
		[CUDA Architecture to use  @<:@default=20@:>@. Options are:
		11 = Compute Capability 1.1 -
		12 = Compute Capability 1.2 -
		13 = Compute Capability 1.3 -
		20 = Compute Capability 2.0 -
		21 = Compute Capability 2.1 -
		30 = Compute Capability 3.0 -
		32 = Compute Capability 3.2 -
        35 = Compute Capability 3.5 -
        50 = Compute Capability 5.0 -
        52 = Compute Capability 5.2 -
        53 = Compute Capability 5.3])],
	[CUDA_ARCH=$with_cuda_arch],
	[CUDA_ARCH=20])

AC_ARG_ENABLE([debug],
	[AS_HELP_STRING([--enable-debug],[Enables debugging features @<:@default=disabled@:>@])],
	[USEDEBUG="true"
	DEBUG=$enable_debug],[USEDEBUG="false"])

AC_ARG_WITH([double],
	[AS_HELP_STRING([--with-double],[Enables double precission features @<:@default=yes@:>@])],
	[
	if test x$enable_double = xyes
	then
		if test $CUDA_ARCH -ge 13
		then
			USESINGLE="false"
		else
			AC_MSG_ERROR([Architecture 1.3 or higher needed for double precission floating point to be available.])
		fi
	else
		USESINGLE="true"
	fi
	],[if test $CUDA_ARCH -ge 13
		then
			USESINGLE="false"
		else
			AC_MSG_ERROR([Architecture 1.3 or higher needed for double precission floating point to be available.])
		fi
	])

AC_ARG_ENABLE([python],
	[AS_HELP_STRING([--enable-python],[Enables python bindings@<:@default=disabled@:>@])],
	[USEPYTHON="true"
	PYTHON=$enable_python],[USEPYTHON="false"])



AC_CHECK_SIZEOF([long])
AS_IF([test $ac_cv_sizeof_long -eq 8],
[OSBIT=64],
[OSBIT=32])

if test x${CUDA_ARCH} = x21
then
	CUDA_COMPUTE_ARCH=20
else
	CUDA_COMPUTE_ARCH=$CUDA_ARCH
fi


echo "Architecture ${with_cuda_arch} ${CUDA_ARCH} ${CUDA_COMPUTE_ARCH}"
#~ echo "BITS: ${OSBIT}"
working_nvcc=no
if test -z "$with_cuda"
then
	CUDA_DIR="/usr/local/cuda"
else
	CUDA_DIR="$with_cuda"
fi
CUDA_CFLAGS="-I$CUDA_DIR/include"
CUDA_PYTHON_LIBS="-l cudart -l cublas"
OSFLAGS=""
if test x$OSBIT = x64
then
	case $host_os in
  		darwin* )
  			CUDA_LIBS="-L$CUDA_DIR/lib -lcudart -lcublas"
			CUDA_LIBS_SUBFOLDER="lib"
			OSFLAGS+=" -DDARWIN"
  		;;
  		*)
		CUDA_LIBS="-L$CUDA_DIR/lib64 -lcudart -lcublas"
		CUDA_LIBS_SUBFOLDER="lib64"
		;;
	esac
	OSFLAGS+=" -m64"
	R250=lib/r250/libr250_64.a
	R250_target=static_64
else
	CUDA_LIBS="-L$CUDA_DIR/lib -lcudart -lcublas"
	OSFLAGS+=" -m32"
	CUDA_LIBS_SUBFOLDER="lib32"
	R250=lib/r250/libr250_32.a
	R250_target=static_32
fi

if test x$USEDEBUG = xtrue
then
    NVCCFLAGS="-DDEBUG=${DEBUG} -G -g -gencode=arch=compute_${CUDA_COMPUTE_ARCH},code=sm_${CUDA_ARCH} --ptxas-options=\"-v\" "
else
    NVCCFLAGS="-O3 -gencode=arch=compute_${CUDA_COMPUTE_ARCH},code=sm_${CUDA_ARCH} "
fi

if test x$USESINGLE = xtrue
then
	NVCCFLAGS+=" -DUSESINGLE"
fi


VERSION="`./evalrev`"
NVCCFLAGS+=" -DGITHASH=${VERSION}"
NVCCFLAGS+=" ${OSFLAGS}"




#~ echo "$CUDA_DIR"
AC_PATH_PROG([NVCC], [nvcc], [], [$CUDA_DIR/bin])
#~ AC_CHECK_PROG([NVCC_EXISTS], [nvcc], [yes], [no], [$CUDA_DIR])
#~ echo "$NVCC"
if test "x$NVCC" != "x"
then
	AX_NVCC_VERSION
	AX_CUDA_VERSION
	NVCCFLAGS+=" -DCUDA_VERSION=${CUDA_VERSION}"
	NVCC_VERSION_MAJOR=$(echo $NVCC_VERSION | cut -d'.' -f1)
	NVCC_VERSION_MINOR=$(echo $NVCC_VERSION | cut -d'.' -f2)

	if test $NVCC_VERSION_MAJOR -lt 4
	then
		AC_MSG_ERROR([CUDA compiler version is lower than 4.0 = $NVCC_VERSION])
	fi

	AC_MSG_CHECKING([whether nvcc works])
	cat > conftest.cu <<EOF
#ifdef USESINGLE
			void __global__ whatever(float *c) {
			float a = 3.2;
			float b = 1.2;
#else
			void __global__ whatever(double *c) {
			double a = 3.2;
			double b = 1.2;
#endif
			*c = a * b;
			__syncthreads();

		}

		int main(int argc, char** argv)  {
#ifdef USESINGLE
			float a = 0.0;
#else
			double a = 0.0;
#endif
			whatever<<<1,1>>>(&a);
			return 0;
		}
EOF
	#~ echo "${NVCC} ${NVCCFLAGS} conftest.cu"
	if $NVCC $NVCCFLAGS conftest.cu
	then
		working_nvcc=yes
		AC_MSG_RESULT([Ok])
	else
		working_nvcc=no
		AC_MSG_ERROR([CUDA compiler is not working right.])
	fi
	rm -f conftest.cu conftest.o

else
	AC_MSG_ERROR([CUDA compiler is needed.])
fi

#~ echo "NVCC= ${NVCC}"
#~ echo "NVCC FLAGS = ${NVCCFLAGS}"

#~ AC_CHECK_FILE ([lib/includes/r250.h], [EXTRALIBS=-Ilib/includes/], [AC_MSG_ERROR([r250.h not found.])])

# Checks for libraries.
# Checks for header files.
AC_CHECK_HEADERS([fcntl.h limits.h stdlib.h string.h unistd.h])
#~ AC_CHECK_HEADERS([clapack.h],[],[AC_MSG_ERROR([clapack.h file is needed.])])
# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([dup2 memset strstr])

GCC_VERSION_MAJOR=$(echo $GCC_VERSION | cut -d'.' -f1)
GCC_VERSION_MINOR=$(echo $GCC_VERSION | cut -d'.' -f2)
GCC_VERSION_PATCH=$(echo $GCC_VERSION | cut -d'.' -f3)

if test $GCC_VERSION_MAJOR -eq 4
then
	if test $GCC_VERSION_MINOR -gt 4
	then
		if test $CUDA_VERSION -eq 4
		then
		AC_MSG_WARN([
=====================================================================
GCC Version is > 4.4 and NVCC compiler may not work. Please check
http://liaa.dc.uba.ar/?q=node/12
for more information on how to fix this issue.
=====================================================================])
		fi
	fi
fi

if test x$USEPYTHON = xtrue
then
	NVCCFLAGS+=" -Xcompiler -fPIC"
fi

AC_SUBST(CUDA_DIR)
AC_SUBST(CUDA_CFLAGS)
AC_SUBST(CUDA_LIBS)
AC_SUBST(CUDA_LIBS_SUBFOLDER)
AC_SUBST(CUDA_PYTHON_LIBS)
AC_SUBST(NVCCFLAGS)
AC_SUBST(R250)
AC_SUBST(R250_target)

if test x$USEPYTHON = xtrue
then
	AC_CONFIG_FILES([python/Makefile])
fi

AC_CONFIG_FILES([Makefile])






AC_OUTPUT
