
# CUDAICA

## What is CUDAICA?
Is an implementation of [Infomax ICA](https://en.wikipedia.org/wiki/Infomax) made on CUDA.

## What is Infomax ICA?
[Infomax ICA](https://en.wikipedia.org/wiki/Infomax) is an algorithm to perform Independent Component Analysis

## Requirements

### Hardware

* A CUDA enabled GPU
* Enough RAM!

### Software

* Cuda Toolkit: 4.0+ required
* GCC
* Autotools, Autoconf and M4
* GFORTRAN compiler
* BLAS library


## Installation

1. Download the source code
2. Configure
3. Make

### Advanced configurations options
Additionaly, when configuring the source code, the following options can be passed to the configure script:
* `–-with-cuda`: Use specified path as cuda base directory. Example: `–with-cuda=/opt/cuda`. Default: `/usr/local/cuda`.
* `–-with-cuda-arch`: Generate cudaica for the specified cuda compute capability. Options are:
  * 11 = Compute Capability 1.1
  * 12 = Compute Capability 1.2
  * 13 = Compute Capability 1.3
  * 20 = Compute Capability 2.0 (default)
  * 21 = Compute Capability 2.1
  * 30 = Compute Capability 3.0
  * 32 = Compute Capability 3.2
  * 35 = Compute Capability 3.5
  * 50 = Compute Capability 5.0
  * 52 = Compute Capability 5.2
  * 53 = Compute Capability 5.3
* `–-with-double`: Enables or disables double precision floating point. Options are:
  * `yes` (default)
  * `no`
* `–-enable-debug`: Enable debugging features and use specified level. Generates executable with debugging symbols and nvcc shows extra information. Example `–enable-debug=2`.
  1. Function calls.
  2. Memory alloc information.
  3. Function calls inside iterations.
* `--enable-python`: Enables python bindings (default=`disabled`)
  
  
More information [LIAA](https://liaa.dc.uba.ar/node/10) website

## Cite

Raimondo, Federico, Juan E. Kamienkowski, Mariano Sigman, and Diego Fernandez Slezak. “CUDAICA: GPU Optimization of Infomax-ICA EEG Analysis.” Computational Intelligence and Neuroscience 2012 (2012).
