## electroCUDA – see wiki for [documentation & theoretical overview](https://github.com/kevmtan/electroCUDA/wiki)
<a href="https://github.com/kevmtan/electroCUDA/blob/master/wiki/s38_ic84_spec.jpg"><img src="https://github.com/kevmtan/electroCUDA/blob/master/wiki/s38_ic84_spec.jpg?raw=true" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

ElectroCUDA – robust preprocessing & analysis for electrophysiology. Core features include noise-resistant signal processing, robust statistics & extensive hardware acceleration.

Routines are intended for any multichannel field potential recordings (LFP/EEG/MEG), but are currently tailored for human intracranial EEG (ECoG/sEEG).

Code is Matlab-based with calls to compiled CUDA, C/C++ & Fortran binaries. User-friendly wrappers abstract away all non-Matlab operations. Modular code & data structures facilitate easy interoperability with other packages.

Routines are compute-intensive and designed for [workstations](https://en.wikipedia.org/wiki/workstations) or [HPC nodes](https://en.wikipedia.org/wiki/High-performance_computing). Compute performance is maximized via layered hardware acceleration & comprehensive code optimizations. **GPU acceleration requires Nvidia CUDA GPUs** – sorry Mac users!

### Development status: PRE-ALPHA
Not yet tested or recommended for mass public use. Hang tight!

### Acknowledgements 
This work was supported by National Science Foundation Graduate Research Fellowship DGE-1650604. Please see wiki for full acknowledgements.

### License
electroCUDA is free and open-source under GNU GPL 3.0

### Terms of use
This code is for research purposes only and is **not intended for clinical or medical use**. 

Use this code at your own risk. Users assume full responsibility for any eventuality related to this software.

USE AND DISTRIBUTION OF THIS SOFTWARE MAY BE SUBJECT TO UNIVERSITY OF CALIFORNIA INTELLECTUAL PROPERTY RIGHTS & UNITED STATES MANDATES FOR FEDERALLY-FUNDED RESEARCH.

THE CONTENT HEREIN IS PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS OF CONTENT HEREIN BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES AND ADVERSE OUTCOMES RELATED IN ANY WAY TO THE USE OF THIS CONTENT. ANY USE OF THE CONTENT HEREIN IMPLIES ACCEPTANCE OF THESE TERMS.
