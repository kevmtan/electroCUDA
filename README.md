## electroCUDA – see wiki for [documentation & theoretical overview](https://github.com/kevmtan/electroCUDA/wiki)
<a href="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg"><img src="https://i.ibb.co/Q9YQg17/s38-ic84-spec.jpg" alt="Summary statistics of a highly-localized neuronal source decomposed by electroCUDA" width="800"/></a>
<br><sub> Summary statistics of an independent neuronal source decomposed by electroCUDA </sub>

electroCUDA – robust preprocessing & analysis for electrophysiology. All routines utilize hardware acceleration, noise-resistant signal processing & robust statistics. Modular code & data structures are easily interoperable with other packages.

Routines are intended for any field potential recordings (LFPs/EEG/MEG) but are currently tailored for intracranial EEG (ECoG/sEEG).

Code is Matlab-based with calls to compiled CUDA binaries. User-friendly Matlab wrappers abstract away all CUDA operations. Seamless import/export tools for EEGLAB, iElvis & Freesurfer. Currently no GUI but data vizualization functionality is extensive.

Routines are intended for a typical [HPC node](https://en.wikipedia.org/wiki/High-performance_computing) or workstation. Compute performance is maximized via multi-layer hardware acceleration & extensive code optimizations. Computationally-intensive methods are used to improve signal processing, data mining & hypothesis testing. **GPU functionality requires Nvidia CUDA GPUs** – sorry Mac users!

Please read the wiki for [practical, algorithmic & theoretical overviews](https://github.com/kevmtan/electroCUDA/wiki) of electroCUDA routines. 

See [Tan et al., 2022](https://doi.org/10.1038/s41467-022-29510-2) for the first peer-reviewed paper using electroCUDA (albiet a very early version).
<br>

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with absolutely no guarantees. Developed on Ubuntu 22.04 and Matlab 2022b.

### License
electroCUDA is free and open-source under GNU GPL 3.0

### Terms of use
This code is intended for research purposes only and is **not for clinical or medical use**. 

Use this code at your own risk. Users assume full responsibility for any eventuality related to the use of content in this repository. The author of this respository makes no guarantees related to the content herein.

The content of this repository is provided "as is" without any express or implied warranties. In no event shall the authors and contributors of content herein be liable for any direct, indirect, incidental, special, exemplary or consequential damages or adverse outcomes related in any way to the use of this content. **Any use of the content herein implies acceptance of these terms.**

### Acknowledgements 
This work was supported by National Science Foundation Graduate Research Fellowship DGE-1650604. See wiki for full acknowledgements.