/* Copyright 2017-2020 The MathWorks, Inc. */

#ifndef __MW_CUDA_DIM_UTILS_H__
#define __MW_CUDA_DIM_UTILS_H__

#ifdef __CUDACC__

#define MW_GC_DEVICE __device__
#define MW_GC_INLINE __forceinline__
#define GPUCODER_INT32 int
#define GPUCODER_BOOL bool
#define GPUCODER_UINT64 unsigned long long

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetThreadsPerBlock() {
    int block_size = (int)(blockDim.x * blockDim.y * blockDim.z);
    return block_size;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetBlocksPerGrid() {
    int grid_size = (int)(gridDim.x * gridDim.y * gridDim.z);
    return grid_size;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_UINT64 mwGetTotalThreadsLaunched() {
    unsigned long long total_thread_count = (unsigned long long)mwGetThreadsPerBlock() * mwGetBlocksPerGrid();
    return total_thread_count;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetBlockIndex() {
    int block_idx = (gridDim.x * gridDim.y * blockIdx.z) + (gridDim.x * blockIdx.y) + blockIdx.x;
    return block_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_UINT64 mwGetGlobalThreadIndex() {
    unsigned long long thread_idx =
        (((((unsigned long long)(gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
            blockIdx.x) *
               (mwGetThreadsPerBlock()) +
           threadIdx.z * blockDim.x * blockDim.y) +
          threadIdx.y * blockDim.x) +
         threadIdx.x);
    return thread_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetThreadIndexWithinBlock() {
    int thread_block_idx =
        (blockDim.x * blockDim.y * threadIdx.z) + (blockDim.x * threadIdx.y) + threadIdx.x;
    return thread_block_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetGlobalThreadIndexInXDimension() {
    int x_idx = blockDim.x * blockIdx.x + threadIdx.x;
    return x_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetGlobalThreadIndexInYDimension() {
    int y_idx = blockDim.y * blockIdx.y + threadIdx.y;
    return y_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_INT32 mwGetGlobalThreadIndexInZDimension() {
    int z_idx = blockDim.z * blockIdx.z + threadIdx.z;
    return z_idx;
}

static MW_GC_DEVICE MW_GC_INLINE GPUCODER_BOOL mwIsLastBlock() {
    return (blockIdx.x + 1 == gridDim.x && blockIdx.y + 1 == gridDim.y &&
            blockIdx.z + 1 == gridDim.z);
}

#endif

#endif
