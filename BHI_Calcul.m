%% Data import
% Example: Alpha band only

% Define the subject ID once, and reuse it everywhere below.

subjectID = 'Sujet_1';

alpha_powspctrm = open(sprintf('Directory/Powspectrm/EEG/%s/Upright_B/Alpha_powspctrm.mat', subjectID));
HRV = readtable(sprintf('Directory/Powspectrm/HRV/WT_Upright_%s_B.csv', subjectID));

% Extract the relevant data
Alpha_powspctrm = alpha_powspctrm.Alpha_powspctrm;
LF = HRV{9:end, 7}; % LF is a vector
RR = HRV{9:end, 3}; % RR is a vector

%% Build a common time vector for interpolation to the same sampling rate

% Dimensions
[n_lines, N] = size(Alpha_powspctrm); % n_lines = 128, N = number of points in Alpha_powspctrm
NLF = length(LF); % LF is a vector

% Parameters
fs = 4;          % Sampling frequency in Hz
n_points = 358;   % Number of interpolated points
t_start = 1;      % Start time in seconds
t_end = 300;      % End time in seconds

% Common time vector
t = linspace(t_start, t_end, n_points);

% Time vectors for Alpha and LF
t_alpha = linspace(t_start, t_end, N);   % For Alpha_powspctrm
t_LF    = linspace(t_start, t_end, NLF); % For LF

% Preallocate matrix for the interpolated Alpha data
Alpha_interpolated = zeros(n_lines, n_points);

% Interpolate Alpha
for i = 1:n_lines
    Alpha_interpolated(i, :) = interp1(t_alpha, Alpha_powspctrm(i, :), t);
end

% Interpolate the LF signal
LF_interpolated = interp1(t_LF, LF, t);

% Result: Alpha_interpolated contains the interpolated Alpha data
% LF_interpolated contains the interpolated LF data

% Display results (optional)
% disp(Alpha_interpolated);
% disp(LF_interpolated);

RR_transposed = RR';

%% Run the BHI model on Alpha
[HeartToBrain, BrainToLF, BrainToHF, HeartToBrain_sigma, HeartToBrain_mc] = ...
    BHImodel(Alpha_interpolated, LF_interpolated, 4, RR_transposed, 15, 15);

%% Plot the Alpha BHI results

% Open EEGLAB if needed
%   eeglab;

% Load the EEG file (for electrode locations)
EEG = pop_loadset('Directory/Powspectrm/Electrodes.set');

% Check that the EEG structure has electrode locations
EEGLoc = EEG.chanlocs;

% Reshape into a single vector for the topoplot
HeartToBrain_single = HeartToBrain(:);

% Topoplot - Alpha
figure;
topoplot(HeartToBrain_single, EEGLoc, 'maplimits', 'absmax');
title('Heart to Brain - Alpha');
colorbar;

% Time-course plot - Alpha
Fs = fs;
figure;
plot((1:length(HeartToBrain(1, :))') / Fs, HeartToBrain(1, :));

%% Save the Alpha BHI results

% Output file name, built from subjectID so it stays consistent
% with the files loaded above.
filename_HeartTBrain = sprintf('%s_Alpha_HeartTBrain.csv', subjectID);

% Save BrainToLF as a CSV file with ";" as delimiter
%writematrix(BrainToLF, filename_BrainToLF, 'Delimiter', ';');

% Save BrainToHF as a CSV file with ";" as delimiter
%writematrix(BrainToHF, filename_BrainToHF, 'Delimiter', ';');

% Save HeartToBrain as a CSV file with ";" as delimiter
writematrix(HeartToBrain, filename_HeartTBrain, 'Delimiter', ';');