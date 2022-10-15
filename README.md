# electroCUDA
Accelerated preprocessing & analysis routines for neural electrophysiology. Noise-resistant signal processing & statistics at each step from preprocessing to final analyses. Data are **never epoched** to support variable-length trials & to minimize artifacts. 

Unlike many toolboxes, electroCUDA is designed to leverage all available GPU/CPU resources efficiently. Computationally-intensive techniques are used to improve signal processing, statistical inference & automation. Works best on workstations, servers & HPC clusters.

Code is written in Matlab with calls to compiled CUDA binaries. Hardware acceleration is implemented in this preference: 1) [CUDA compiler](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html), 2) [GPU vectorization](https://www.mathworks.com/help/parallel-computing/gpuarray.arrayfun.html), 3) [CPU vectorization](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html), 4) [threaded GPU parallelization](https://www.mathworks.com/help/parallel-computing/run-matlab-functions-on-a-gpu.html), 5) [threaded CPU parallelization](https://www.mathworks.com/help/parallel-computing/parallel.threadpool.html), and 6) [process-based CPU parallelization](https://www.mathworks.com/help/parallel-computing/choose-between-thread-based-and-process-based-environments.html). The highest-ranking feasible implementation is used for a given routine. GPU functionality can be disabled in most functions.

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This first commit is a glorified dump from my personal codebase: pre-alpha with no guarantees. Shorter function stacks should work. High-level pipelines not yet released due to patient-identifying inputs. Developed on Ubuntu 22.04 and Matlab 2022b.

Of note, *ec_cudaica* is a fully-operational wrapper that integrates compiled [CUDAICA](https://doi.org/10.1155/2012/206972) binaries in the Matlab environment
<br>
<br>

## Single-subject pipeline for intracranial EEG

<a href="https://i.ibb.co/Y7N27q8/s38-ic104-spec.jpg"><img src="https://i.ibb.co/Y7N27q8/s38-ic104-spec.jpg" alt="Summary statistics for an independent component" width="800"/></a>

### Anatomical preprocessing
1. Process anatomical MRI in Freesurfer to reconstruct native & standardized cortical surfaces.
2. Localize electrode position coordinates, correct postimplantation brain drift & align to cortical surface vertices
3. Calculate electrode anatomical attributes (e.g. proximal tissue density) & parcellate into standard brain atlases (Desikan-Killiany, HCP-Glasser, Yeo networks, etc)
4. Temporally align raw EEG recordings with experimental task, concactenate runs/blocks if needed

### Initial EEG preprocessing for ICA (or other source separation technique)
5. Load raw EEG data & identify irredeemably bad channels (empty, loose contact, etc)
6. Robust detrend within runs: first with a low-order polynomial on time-chunked data, then use a higher-order polynomial on entire run. Use aggressive thresholds as ICA is sensitive to non-stationary noise.
7. Identify remaining 'bad' channels with pre-trained classifier
8. Interpolate timepoints containing non-stationary & channel-specific noise
9. Robust average reference all channels using iterative mean of all remaining 'good' channels. Apply [rank correction](https://sccn.ucsd.edu/wiki/Makoto%27s_preprocessing_pipeline#Why_should_we_add_zero-filled_channel_before_average_referencing.3F_.2808.2F09.2F2020_Updated.3B_prayer_for_Nagasaki.29) at first iteration (correct for any previous referencing) & any further iterations where channels are rejected
10. Calculate data rank from all redeemable channels; if rank-deficient, exclude a 'bad' channel that contributes to rank-deficiency
11. Run ICA (or other source separation technique) on all redeemable channels except for any rank-impairing channels. Include 'bad' but redeemable chans to improve isolation of noise sources 
12. Reconstruct independent component (IC) timecourses from *raw* EEG data (no denoising or rereferencing)
13. Identify non-neurogenic ICs with pre-trained classifer

### Main EEG preprocessing
14. Load raw EEG data & discard any channels excluded from ICA 
15. Robust detrend within runs (same as step 6) using more conservative thresholds to preserve data fidelity 
16. Robust average reference all channels to mean of remaining 'good' channels (same as step 9)
17. Reconstruct IC timecourses. This results in two EEG datasets: channel timecourses & IC timecourses
18. Decide which dataset(s) you want to analyze: channels, ICs, or both. Apply forthcoming steps to datases(s) of interest.
20. Subtract non-neurogenic ICs from channel timecourses to remove stationary noise (unless running ICA again in step 26). Neurogenic ICs should be isolated from stationary noise sources (epileptic oscillations, line noise, muscle noise, eye blinks, etc). However, ICA does not isolate non-stationary noise (impedence drift, channel pops, etc). Alternatively, ASR/DSS isolate both stationary & non-stationary noise *from* neurogenic activity at the expense of isolating *between* neurogenic sources. Thus, ASR/DSS are only suited for denoising channel data. ICA is suited for isolating distinct neural sources in addition to denoising.
21. Robust detrend again (same as step 15) using even more conservative thresholds to reduce remaining non-stationary noise
22. Identify remaining noisy timepoints (spikes, pops, channel-specific artifacts, etc) per channel/IC... Choose whether to keep, interpolate or remove these timepoints in later anlyses

### Time-frequency decomposition
23. Load denoised dataset(s) but **don't** remove/interpolate bad timepoints identified in step 22
24. Run continuous wavelet transform separately per run to avoid edge artifacts. This generates individual timecourses for each frequency, or mean timecourses within frequency band(s) of interest. Morse wavelets are used by default as they account for unequal variance-covariance across frequencies.
25. Identify noisy timepoints (spikes, pops, channel-specific artifacts, etc) within each frequency/band for each channel/IC

### ICA on high-frequency timecourses
26. Run ICA again if analyzing high-frequency bands like [HFB](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6632564/) or gamma. High-freq ICA should use channel HFB timecourses *prior* to subtraction of non-neurogenic ICs (avoid rank deficiency). Use the original ICA weights as starting weights for high-freq ICA. This produces HFB-optimized ICs that retain resemblance to the original ICs.

- Standard ICA (e.g. step 11) is [biased towards lower frequencies](https://sccn.ucsd.edu/mediawiki/images/0/09/IcaRejectionLabPresentation_updated.pdf) due to 1/f frequency decay. In other words, lower frequencies have more variance than higher frequencies, which biases ICA towards lower-frequency activity. Running ICA again on HFB timecourses removes low-frequency variance, resulting in much better decomposition of HFB's neuronal sources.
