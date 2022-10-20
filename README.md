# electroCUDA
<a href="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg"><img src="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

Fully-automated preprocessing & analysis routines for field potential electrophysiology (LFP/iEEG/EEG/MEG). Noise-resistant signal processing, robust statistics & hardware acceleration are used in all routines. Easy interoperation with other toolboxes via modular design & conversion tools for EEGLAB, iElvis & Freesurfer.

electroCUDA is designed to efficiently leverage HPC-grade compute resources. Computationally-intensive techniques are used to improve signal processing, data mining & hypothesis testing. Compute performance is maximized via multi-layer hardware acceleration & extensive code optimizations. **Nvidia GPU with CUDA is required for GPU functionality** – sorry Mac users!

Code is Matlab-based with calls to compiled CUDA binaries. General proficiency in Matlab & computing are highly recommended – CUDA proficiency is optional. All CUDA operations are abstracted by user-friendly Matlab wrappers

## [See wiki for practical & theoretical documentation](https://github.com/kevmtan/electroCUDA/wiki)

An early version of electroCUDA were used in [Tan et al., 2022](https://doi.org/10.1038/s41467-022-29510-2) (basic social neuroscience with ECoG).

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with no guarantees. Development has focused exclusively on iEEG thus far, but many routines should work on scalp EEG, MEG & LFPs. Developed on Ubuntu 22.04 and Matlab 2022b.

Of note, *ec_cudaica* is a fully-operational wrapper that integrates compiled [CUDAICA](https://doi.org/10.1155/2012/206972) binaries in the Matlab environment
