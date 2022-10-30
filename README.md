## electroCUDA – see wiki for [documentation & theoretical overview](https://github.com/kevmtan/electroCUDA/wiki)
<a href="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg"><img src="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

electroCUDA – robust preprocessing & analysis for electrophysiology. Hardware acceleration, noise-resistant signal processing & robust statistics at each step. Extensive data visualization.

Intended for any multichannel field potential recordings (LFP/EEG/MEG) but pipelines are currently tailored for human intracranial EEG (ECoG/sEEG).

Modular code & data structures facilitate easy interoperability with other packages. Seamless import/export tools for EEGLAB, iElvis & Freesurfer. Code is Matlab-based with calls to compiled CUDA, C & Fortran binaries. User-friendly wrappers abstract away all non-Matlab operations.

Designed for [workstations](https://en.wikipedia.org/wiki/workstations) or [HPC nodes](https://en.wikipedia.org/wiki/High-performance_computing). Compute performance is maximized via layered hardware acceleration & comprehensive code optimizations. Computationally-intensive methods used to improve signal processing, feature extraction & hypothesis testing. **GPU functionality requires Nvidia CUDA GPUs** – sorry Mac users!

Please read the wiki for [practical, algorithmic & theoretical overviews](https://github.com/kevmtan/electroCUDA/wiki) of electroCUDA routines. 

See [Tan et al., 2022](https://doi.org/10.1038/s41467-022-29510-2) for the first peer-reviewed paper using electroCUDA (albiet a very early version).
<br>

### Development status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with absolutely no guarantees. Developed on Ubuntu 22.04, Matlab 2022b & CUDA 11.8 using AMD Epyc Milan x64 & Nvidia RTX3060 12gb

### Acknowledgements 
This work was supported by National Science Foundation Graduate Research Fellowship DGE-1650604. Please see wiki for full acknowledgements.

### License
electroCUDA is free and open-source under GNU GPL 3.0

### Terms of use
This code is for research purposes only and is **not intended for clinical or medical use**. 

Use this code at your own risk. Users assume full responsibility for any eventuality related to the use of repository content. The author of this respository makes no guarantees related to repository content.

USE AND DISTRIBUTION OF THIS SOFTWARE UNDER GNU GPL IS FULLY COMPLIANT WITH UNITED STATES MANDATES FOR FEDERALLY-FUNDED RESEARCH AND UNIVERSITY OF CALIFORNIA INTELLECTUAL PROPERTY POLICY.

THE CONTENT OF THIS REPOSITORY IS PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS OF CONTENT HEREIN BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OR ADVERSE OUTCOMES RELATED IN ANY WAY TO THE USE OF THIS CONTENT. ANY USE OF THE CONTENT HEREIN IMPLIES ACCEPTANCE OF THESE TERMS.