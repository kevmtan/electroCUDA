# electroCUDA

Accelerated preprocessing & analysis for intracranial & scalp electrophysiology. Robust signal processing & statistical methods are used from preprocessing to final analyses. Data are **never epoched** to support variable-length trials & minimize edge artifacts. 

Unlike most toolboxes, electroCUDA is designed to maximize the utility of all available GPU/CPU resources. Computationally-intensive techniques are used to improve signal processing, statistical inference & automation. electroCUDA runs best on workstations, servers & HPC clusters.

Code is written in Matlab with calls to compiled CUDA binaries. Hardware acceleration is implemented with this preference: 1) [CUDA compiler](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html), 2) [GPU vectorization](https://www.mathworks.com/help/parallel-computing/gpuarray.arrayfun.html), 3) [CPU vectorization](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html), 4) [threaded GPU parallelization](https://www.mathworks.com/help/parallel-computing/run-matlab-functions-on-a-gpu.html), 5) [threaded CPU parallelization](https://www.mathworks.com/help/parallel-computing/parallel.threadpool.html), and 6) [process-based CPU parallelization](https://www.mathworks.com/help/parallel-computing/choose-between-thread-based-and-process-based-environments.html). The highest-ranking feasible implementation was chosen for a given routine.

### Current status: PRE-ALPHA
*[Oct 14, 2022]* Hello world! This is the first commit: a glorified dump from my personal codebase. This release is pre-alpha with no guarantees. Shorter function stacks should work. High-level pipelines not yet released due to patient-identifying inputs. Developed on Ubuntu 22.04 and Matlab 2022b.

Of note, **ec_cudaica** is a fully-operational wrapper that integrates compiled [CUDAICA](https://doi.org/10.1155/2012/206972) binaries in the Matlab environment
<br>
<br>

## Single-subject pipeline for intracranial EEG
### Anatomical preprocessing
1. Process anatomical MRI in Freesurfer to reconstruct native & standardized cortical surfaces.
2. Localize electrode position coordinates, correct postimplantation brain drift & align to cortical surface vertices
3. Calculate electrode anatomical attributes (e.g. proximal tissue density) & parcellate into standard brain atlases (Desikan-Killiany, HCP-Glasser, Yeo networks, etc)
4. Temporally align raw EEG recordings with experimental task, concactenate runs/blocks if needed

### EEG preprocessing for ICA (or other source separation technique)
1. Load raw EEG data & identify irredeemably bad channels (empty, loose contact, etc)
3. Robust detrend within runs: first with a low-order polynomial on time-chunked data, then use a higher-order polynomial on entire run. Use aggressive thresholds to improve source decomposition.
4. Identify remaining bad channels with pre-trained classifier
5. Interpolate timepoints containing non-stationary & channel-specific noise
6. Robust average reference all channels using iterative mean of all remaining 'good' channels. Apply [rank correction](https://sccn.ucsd.edu/wiki/Makoto%27s_preprocessing_pipeline#Why_should_we_add_zero-filled_channel_before_average_referencing.3F_.2808.2F09.2F2020_Updated.3B_prayer_for_Nagasaki.29) at first iteration (correct for any previous referencing) & any further iterations where channels are rejected
7. Calculate data rank from all non-irredeemable channels; if rank-deficient, exclude a 'bad' channel that contributes to rank-deficiency
8. Run ICA (or other source separation technique) on all redeemable channels (even 'bad' ones) except for any rank-impairing channels. Including redeemable 'bad' chans allows ICA to better account for noise sources
9. Reconstruct IC timecourses using *raw* EEG data (no denoising or rereferencing)
10. Identify non-neurogenic ICs with pre-trained classifer

### Final EEG preprocessing
11. Load raw EEG data
12. Robust detrend (within-runs) using conservative thresholds to preserve data fidelity 
13. Robust average reference all channels to mean of remaining 'good' channels
14. Discard any channels excluded from ICA & reconstruct IC timecourses. This results in two EEG datasets: channel timecourses & IC timecourses
16. Decide which dataset(s) you want to analyze: channels, ICs, or both. Apply forthcoming steps to datases(s) of interest.
15. If using channel data, subtract non-neurogenic ICs from channel timecourses (stationary denoising). If using IC timecourses, noise ICs are already separated from neurogenic ICs. ICA is very effective at isolating stationary noise sources (epileptic oscillations, line noise, muscle noise, blinks, etc) *and* distinct neurogenic sources. Alternatively, ASR & DSS can isolate both stationary & non-stationary noise *from* neurogenic activity, however ASR/DSS are bad at isolating *between* neurogenic sources. Thus, ASR/DSS are only suited for denoising channel data.
17. Robust detrend again using even more conservative thresholds to reduce remaining non-stationary noise
18. Identify noisy timepoints (spikes, pops, channel-specific artifacts, etc) per channel or IC... Choose whether to keep, interpolate or remove these timepoints for each analysis

### Time-frequency decomposition
19. Load denoised dataset(s) but **don't** remove/interpolate bad timepoints identified in step 18
20. Run continuous wavelet transform separately per run to avoid edge artifacts. This generates individual timecourses for each frequency, or mean timecourses within frequency band(s) of interest. Morse wavelets are used by default to account for unequal variance-covariance across frequencies.
21. Identify noisy timepoints (spikes, pops, channel-specific artifacts, etc) within each frequency/band for each channel/IC

### ICA on high-frequency timecourses
21. If interested in high-frequency bands (assuming [HFB](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6632564/) but also applies to gamma), run ICA again on channel HFB timecourses prior to subtracting non-neurogenic ICs. Use the original ICA weights as starting weights for high-freq ICA. This produces HFB-optimized ICs that remain analogous to original ICs.

- Standard ICA (e.g. step 8) is [biased towards lower frequencies](https://sccn.ucsd.edu/mediawiki/images/0/09/IcaRejectionLabPresentation_updated.pdf) due to 1/f frequency decay. In other words, higher frequencies have less variance than lower frequencies, thus ICA focuses on lower-frequency activity. Running ICA again on HFB timecourses results in much better decomposition of HFB's neuronal sources.
