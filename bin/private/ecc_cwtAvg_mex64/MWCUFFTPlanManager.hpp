/* Copyright 2019-2020 The MathWorks, Inc. */
#ifndef __MWCUFFTPLANMANGER_HPP__
#define __MWCUFFTPLANMANGER_HPP__

#include <cufft.h>

cufftHandle acquireCUFFTPlan(int rank, int* n, int* inembed, int istride, int idist, cufftType type, int batch);

#endif
