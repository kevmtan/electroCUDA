// Copyright 2021 The MathWorks, Inc.

#ifndef MW_CUDA_MEMORY_FUNCTIONS_HPP
#define MW_CUDA_MEMORY_FUNCTIONS_HPP

#ifdef MW_GPU_MEMORY_MANAGER
#include "MWMemoryManager.hpp"
#endif

#if defined(MW_GPU_MEMORY_MANAGER) && !defined(__CUDA_ARCH__)

template<typename MWType_>
cudaError_t mwCudaMalloc(MWType_** devPtr, size_t size) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.allocate(devPtr, size, gcmemory::DISCRETE);
}

template<typename MWType_>
cudaError_t mwCudaMallocManaged(MWType_** devPtr, size_t size) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.allocate(devPtr, size, gcmemory::UNIFIED);
}

template<typename MWType_>
cudaError_t mwCudaFree(MWType_* devPtr) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.deallocate(devPtr);
}

#else
#include "cuda_runtime.h"

template<typename MWType_>
__host__ __device__
cudaError_t mwCudaMalloc(MWType_** devPtr, size_t size) {
    return cudaMalloc(devPtr, size);
}

template<typename MWType_>
__host__
cudaError_t mwCudaMallocManaged(MWType_** devPtr, size_t size) {
    return cudaMallocManaged(devPtr, size);
}

template<typename MWType_>
__host__ __device__
cudaError_t mwCudaFree(MWType_* devPtr) {
    return cudaFree(devPtr);
}

#endif // #ifdef MW_GPU_MEMORY_MANAGER
#endif // #ifndef MW_CUDA_MEMORY_FUNCTIONS_HPP
