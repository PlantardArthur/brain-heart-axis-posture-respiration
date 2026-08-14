# brain-heart-axis-posture-respiration

This repository contains the code used to assess how postural changes (e.g., supine vs. standing/tilt) and respiratory patterns (e.g., paced breathing, respiratory rate) influence the functional communication between the brain and the heart. The analysis quantifies brain-heart interplay (e.g., EEG–ECG/HRV coupling) across experimental conditions to characterize how autonomic and central nervous system activity co-vary under postural and respiratory manipulation.

# Requirements
Matlab (R2024a)

CVR Analysis (Vincent Pichot and al., 2024. DOI : 10.3389/fphys.2023.1224440). Donwload : https://anslabtools.univ-st-etienne.fr/en/download/cvr-analysis-1-0.html.

Brain-Heart-Interaction-Indexes (Vincenzo Catrambone and al., 2019. DOI : 10.1007/s10439-019-02251-y. Github : https://github.com/CatramboneVincenzo/Brain-Heart-Interaction-Indexes)

# Process
1. EEG signals were preprocessed following the HAPPE pipeline (Gabard-Durnam et al., 2018. DOI: 10.3389/fnins.2018.00097, GitHub):

    Resample to 512 Hz.

    Band-pass filter using a fourth-order Butterworth filter (0.5–45 Hz).

    Perform Independent Component Analysis (ICA).

    Visually inspect the data.

2. Compute brain-heart coupling metrics for each condition

    Compute the EEG power spectral density (PSD) for each frequency band.

    Compute HRV spectral components using the Discrete Wavelet Transform (Daubechies 4 mother wavelet) applied to the R-R interval (RRI) series resampled at 2.4 Hz, using 7 decomposition levels (2, 4, 8, 16, 32, 64, and 128 Hz), following Pichot et al. (1999) and using CVR Analysis.

    Compute blood pressure values and baroreflex sensitivity (BRS) using CVR Analysis (Pichot et al., 2024).

    Compute brain-heart interplay indices using the Brain-Heart Interaction Indexes toolbox.

3. Statistical comparisons across conditions

    Conditions were compared using the Friedman test followed by pairwise Wilcoxon signed-rank tests, with correction for multiple comparisons via spatial permutation testing. 

    Spearman correlations were used to assess the relationship between cardiovascular parameters and brain-heart interplay indices.


# Reproducing the figures
Figures reported in the article can be regenerated using the Fig.mat script.

# Citation
If you use this code, please cite the associated article:

@article{Plantard2026brainheart,

  title   = {Assessing the Influence of Postural and Respiratory Changes on the Functional Brain-Heart Axis Communication},

  author  = {Arthur Plantard, Vincenzo Catrambone, Florian Chouchou and Author Gaetano Valenza},
  
  journal = {American Journal of Physiology-Regulatory, Integrative and Comparative Physiology},
  
  publisher = {American Physiological Society},
  
  volume  = {331},
  
  number  = {3},
  
  year    = {2026},
  
  doi     = {10.1152/ajpregu.00303.2025}
}
