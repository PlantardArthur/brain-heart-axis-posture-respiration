# brain-heart-axis-posture-respiration

This repository contains the code used to assess how postural changes (e.g., supine vs. upright) and respiratory patterns (e.g., slow-paced breathing and normal respiration) influence functional communication between the brain and the heart. The analysis quantifies brain-heart interplay (e.g., EEG–ECG/HRV coupling) across experimental conditions to characterize how autonomic and central nervous system activity co-vary under postural and respiratory manipulations.

# Requirements

* MATLAB (R2024a)
* Brainstorm toolbox (https://doi.org/10.1155/2011/879716)
* EEGLAB toolbox (Delorme A & Makeig S (2004) EEGLAB: an open-source toolbox for analysis of single-trial EEG dynamics, Journal of Neuroscience Methods 134:9-21).

**CVR Analysis** (Vincent Pichot et al., 2024. DOI: 10.3389/fphys.2023.1224440).
Download: https://anslabtools.univ-st-etienne.fr/en/download/cvr-analysis-1-0.html

**Brain-Heart-Interaction-Indexes** (Vincenzo Catrambone et al., 2019. DOI: 10.1007/s10439-019-02251-y).
GitHub: https://github.com/CatramboneVincenzo/Brain-Heart-Interaction-Indexes

# Process

## 1. EEG preprocessing

EEG signals were preprocessed following the HAPPE pipeline (Gabard-Durnam et al., 2018. DOI: 10.3389/fnins.2018.00097).

*Cf. `Brain_Process_Script.m`*

* Resample the data to 512 Hz.
* Apply a fourth-order Butterworth band-pass filter (0.5–45 Hz).
* Perform Independent Component Analysis (ICA).
* Visually inspect the data.
* Compute the EEG power spectral density (PSD) for each frequency band.

The results are stored as matrices with dimensions **N Channels × N Times**, for each frequency band.

## 2. ECG preprocessing

ECG signals were preprocessed as follows:

* Apply a fourth-order Butterworth band-pass filter (0.5–45 Hz).
* Perform peak-to-peak analysis to detect R waves within the QRS complexes.
* Compute blood pressure values and baroreflex sensitivity (BRS) using CVR Analysis (Pichot et al., 2024).
* Compute HRV spectral components using the Discrete Wavelet Transform (Daubechies 4 mother wavelet) applied to the R-R interval (RRI) series, resampled at 2.4 Hz, using seven decomposition levels (2, 4, 8, 16, 32, 64, and 128 Hz), following Pichot et al. (1999) and using CVR Analysis (Pichot and al., 1999 : https://doi.org/10.1152/jappl.1999.86.3.1081).

The results are stored as matrices with dimensions **N Frequency × N Times**, for each frequency band (LF and HF).

## 3. Brain-heart coupling

Compute brain-heart coupling metrics for each experimental condition.

*Cf. `BHI_Calcul.m`*

Compute brain-heart interplay indices using the **Brain-Heart-Interaction-Indexes** toolbox:

https://github.com/CatramboneVincenzo/Brain-Heart-Interaction-Indexes

## 4. Statistical comparisons across conditions

The median BHI value must first be computed, for example using the `Median_BHI.m` script.

*Cf. `Stat_and_Figure.m`*

Conditions were compared using the Friedman test, followed by pairwise Wilcoxon signed-rank tests, with correction for multiple comparisons using spatial permutation testing.

Spearman correlations were used to assess the relationships between cardiovascular parameters and brain-heart interplay indices.

# Reproducing the figures

The figures reported in the article can be regenerated using the `Stat_and_Figure.m` script.

# Citation

If you use this code, please cite the associated article:

```bibtex
@article{Plantard2026brainheart,

  title   = {Assessing the Influence of Postural and Respiratory Changes on the Functional Brain-Heart Axis Communication},

  author  = {Arthur Plantard, Vincenzo Catrambone, Florian Chouchou and Gaetano Valenza},

  journal = {American Journal of Physiology-Regulatory, Integrative and Comparative Physiology},

  publisher = {American Physiological Society},

  volume  = {331},

  number  = {3},

  year    = {2026},

  doi     = {10.1152/ajpregu.00303.2025}
}
```
