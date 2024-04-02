/* Copyright 2017-2023 The MathWorks, Inc. */

#ifndef MW_LAUNCH_PARAMETERS_HPP
#define MW_LAUNCH_PARAMETERS_HPP

#include <cuda_runtime.h>

void mwGetLaunchParameters1D(
    unsigned long long numIterations,
    dim3* grid,
    dim3* block,
    unsigned int maxBlocks);

bool mwValidateLaunchParameters(
    const dim3& grid,
    const dim3& block);

void mwApplyLaunchParameters(
    unsigned long long numIterations,
    const dim3& ingrid,
    const dim3& inblock,
    dim3* outgrid,
    dim3* outblock);

#endif
