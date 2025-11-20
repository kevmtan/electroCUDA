/* Copyright 2017-2020 The MathWorks, Inc. */

#ifndef __MW_CUDA_DIM_UTILS_H__
#define __MW_CUDA_DIM_UTILS_H__

#ifdef __CUDACC__

static __device__ __forceinline__
unsigned int mwGetThreadsPerBlock() {
    return blockDim.x * blockDim.y * blockDim.z;
}

static __device__ __forceinline__
unsigned int mwGetBlocksPerGrid() {
    return gridDim.x * gridDim.y * gridDim.z;
}

static __device__ __forceinline__
unsigned long long mwGetTotalThreadsLaunched() {
    return (unsigned long long)mwGetThreadsPerBlock() * mwGetBlocksPerGrid();
}

static __device__ __forceinline__
unsigned int mwGetBlockIndex() {
    return (gridDim.x * gridDim.y * blockIdx.z) + (gridDim.x * blockIdx.y) + blockIdx.x;
}

static __device__ __forceinline__
unsigned int mwGetThreadIndexWithinBlock() {
    return (blockDim.x * blockDim.y * threadIdx.z) + (blockDim.x * threadIdx.y) + threadIdx.x;
}

static __device__ __forceinline__
unsigned long long mwGetGlobalThreadIndex() {
    return (unsigned long long)mwGetBlockIndex() * mwGetThreadsPerBlock() +
        mwGetThreadIndexWithinBlock();
}

static __device__ __forceinline__
unsigned int mwGetGlobalThreadIndexInXDimension() {
    return blockDim.x * blockIdx.x + threadIdx.x;
}

static __device__ __forceinline__
unsigned int mwGetGlobalThreadIndexInYDimension() {
    return blockDim.y * blockIdx.y + threadIdx.y;
}

static __device__ __forceinline__
unsigned int mwGetGlobalThreadIndexInZDimension() {
    return blockDim.z * blockIdx.z + threadIdx.z;
}

#endif

#endif
