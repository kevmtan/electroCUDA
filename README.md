# electroCUDA
<a href="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg"><img src="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

Accelerated preprocessing & analysis routines for electrophysiology. Noise-resistant signal processing & robust statistics are used at each step from preprocessing to final analyses. Intended for intracranial EEG, scalp EEG, MEG & LFPs.

Unlike many ephysio toolboxes, electroCUDA doesn't shy away from computationally-intensive techniques that improve signal processing, statistical inference & automation. Compute performance is maximized through extensive hardware acceleration & code optimizations.

Code is written in Matlab with calls to compiled CUDA binaries. Hardware acceleration is implemented in this preference: 1) [CUDA compiler](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html), 2) [GPU vectorization](https://www.mathworks.com/help/parallel-computing/gpuarray.arrayfun.html), 3) [CPU vectorization](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html), 4) [threaded GPU parallelization](https://www.mathworks.com/help/parallel-computing/run-matlab-functions-on-a-gpu.html), 5) [threaded CPU parallelization](https://www.mathworks.com/help/parallel-computing/parallel.threadpool.html), and 6) [process-based CPU parallelization](https://www.mathworks.com/help/parallel-computing/choose-between-thread-based-and-process-based-environments.html). The highest-ranking feasible implementation is used for a given subroutine. GPU functionality can be disabled in most functions.

Runs best on workstations, servers & HPC clusters. Nvidia CUDA-enabled GPU is required for GPU acceleration (sorry Mac users!)

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with no guarantees. Development has focused exclusively on iEEG thus far, but many routines should work on scalp EEG, MEG & LFPs. Developed on Ubuntu 22.04 and Matlab 2022b.

Of note, *ec_cudaica* is a fully-operational wrapper that integrates compiled [CUDAICA](https://doi.org/10.1155/2012/206972) binaries in the Matlab environment
