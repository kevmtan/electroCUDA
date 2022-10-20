## electroCUDA – see wiki for [documentation & theoretical overview](https://github.com/kevmtan/electroCUDA/wiki)
<a href="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg"><img src="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

Robust preprocessing & analysis for electrophysiology. Hardware acceleration, noise-resistant signal processing & robust statistics are used by all routines. Code is highly modular & easily interoperable with other packages, including import/export tools for EEGLAB, iElvis & Freesurfer.

Routines are intended for any field potential recordings (LFPs/EEG/MEG) but are currently tailored for intracranial EEG (ECoG/sEEG).

Code is Matlab-based with calls to compiled CUDA binaries. User-friendly Matlab wrappers abstract away all CUDA operations. Currently no GUI but data vizualization functionality is extensive.

Routines are designed to leverage a typical [HPC node](https://en.wikipedia.org/wiki/High-performance_computing) or workstation. Compute performance is maximized via multi-layer hardware acceleration & extensive code optimizations. Computationally-intensive methods are used to improve signal processing, data mining & hypothesis testing. **GPU functionality requires Nvidia CUDA GPUs** – sorry Mac users!

See [Tan et al., 2022](https://doi.org/10.1038/s41467-022-29510-2) for the first peer-reviewed paper using electroCUDA (albiet a very early version).
<br>

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with no guarantees. Only tested on Ubuntu 22.04 and Matlab 2022b.
