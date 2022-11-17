#ifndef __MT19937_H__
#define __MT19937_H__

#ifdef __cplusplus
extern "C" {
#endif

__device__ void mt19937si(unsigned int); // initializer
__device__ unsigned int mt19937s();
__device__ unsigned int mt19937sl(); 
__device__ void mt19937gi(unsigned int); // initializer
__device__ unsigned int mt19937g();
__device__ unsigned int mt19937gl(); 


void init_genrand(unsigned int);
unsigned int genrand_int32();
/*
 * Generates max random numbers between [0 and max) and stores them in dst
 * Should be launched with n blocks of t threads where b*t > max
 */
__global__ void randomCuda( const unsigned int block_seeds[], unsigned int *dst, unsigned int max );


#ifdef __cplusplus
}
#endif

#endif
