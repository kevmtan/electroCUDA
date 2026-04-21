# MATLAB Context for electroCUDA

## Environment
- MATLAB release: R2026a
- OS: Ubuntu 25.10
- GPU/CUDA: NVIDIA RTX 3090, CUDA 13.x+
- All toolboxes installed

## Known unavailable or avoided APIs
- Fine to use undocumented/internal APIs (e.g., `matlab.internal.*`)
- Assume compatibility target is R2026a+ unless noted.

## Project conventions
- Prefer explicit name-value args for clarity.
- Validate dimensions at function boundaries.
- Keep GPU paths optional/fallback to CPU.
- Prefer Matlab toolbox functions versus writing from scratch