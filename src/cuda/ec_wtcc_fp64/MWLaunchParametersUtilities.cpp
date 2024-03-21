/* Copyright 2017-2023 The MathWorks, Inc. */

#include "MWLaunchParametersUtilities.hpp"

#include <cstdint>

namespace {

const unsigned int MAX_THREADS_PER_BLOCK = 1024;
const unsigned int MAX_BLOCKS_PER_GRID_DIM_X = INT32_MAX;
const unsigned int MAX_BLOCKS_PER_GRID_DIM_YZ = 65535;

unsigned int roundToMultipleOf32(unsigned int val) {
    return ((val + 31) / 32) * 32;
}

bool isValidDim3(const dim3* obj) {
    return obj->x > 0 && obj->y > 0 && obj->z > 0;
}

void resetDim3ToZeros(dim3* obj) {
    obj->x = 0;
    obj->y = 0;
    obj->z = 0;
}

bool checkBlockSize(const dim3* in) {
    double prod = double(in->x) * double(in->y) * double(in->z);
    return in->z <= 64 && prod > 0 && prod <= MAX_THREADS_PER_BLOCK;
}

bool checkGridSize(const dim3* in) {
    double prod = double(in->x) * double(in->y) * double(in->z);
    return in->x <= MAX_BLOCKS_PER_GRID_DIM_X &&
        in->y <= MAX_BLOCKS_PER_GRID_DIM_YZ &&
        in->z <= MAX_BLOCKS_PER_GRID_DIM_YZ &&
        prod > 0 && prod <= INT32_MAX;
}

unsigned long long divCeil(unsigned long long num, unsigned long long den) {
    if (num == 0) {
        return 0;
    }
    return 1 + (num - 1) / den;
}

}


void mwGetLaunchParameters1D(
    unsigned long long numIterations,
    dim3* grid,
    dim3* block,
    unsigned int maxBlocks) {

    unsigned long numThreads;
    unsigned long long numBlocks;

    // Tune to avoid trivial imbalanced kernel configuration.
    if (numIterations <= 512ULL * maxBlocks) {
        numThreads = 512;
        numBlocks = divCeil(numIterations, numThreads);
        while (numThreads > 128 && numBlocks < 96) {
            numThreads -= 32;
            numBlocks = divCeil(numIterations, numThreads);
        };
        if (numIterations < numThreads) {
            numThreads = roundToMultipleOf32((unsigned int)numIterations);
            numBlocks = 1;
        }
        block->x = numThreads;
        grid->x = (unsigned int)numBlocks;
    } else {
        block->x = 512;
        grid->x = maxBlocks;
    }

    block->y = 1;
    block->z = 1;
    grid->y = 1;
    grid->z = 1;
}


bool mwValidateLaunchParameters(
    const dim3& grid,
    const dim3& block) {

    return isValidDim3(&grid) && isValidDim3(&block);
}


void mwApplyLaunchParameters(
    unsigned long long numIterations,
    const dim3& ingrid,
    const dim3& inblock,
    dim3* outgrid,
    dim3* outblock) {

    if (numIterations == 0) {
        resetDim3ToZeros(outgrid);
        resetDim3ToZeros(outblock);
    } else if (checkBlockSize(&inblock) && checkGridSize(&ingrid)) {
        *outgrid = ingrid;
        *outblock = inblock;
    } else {
        mwGetLaunchParameters1D(numIterations, outgrid, outblock, INT32_MAX);
    }
}
