%% Friedman test to be performed in each corresponding BHI file, example in the HearttoBrainLF folder
% Number of electrodes and subjects

% Launch EEGlab
eeglab;

num_electrodes = 128;
num_subjects = 17;

% Data loading
% Delta
Delta_Supine_SP = load('Median_Supine_SP_Delta.mat', 'medians').medians; 
Delta_Supine_B = load('Median_Supine_B_Delta.mat', 'medians').medians; 
Delta_Upright_SP = load('Median_Upright_SP_Delta.mat', 'medians').medians; 
Delta_Upright_B = load('Median_Upright_B_Delta.mat', 'medians').medians;

% Theta
Theta_Supine_SP = load('Median_Supine_SP_Theta.mat', 'medians').medians; 
Theta_Supine_B = load('Median_Supine_B_Theta.mat', 'medians').medians; 
Theta_Upright_SP = load('Median_Upright_SP_Theta.mat', 'medians').medians; 
Theta_Upright_B = load('Median_Upright_B_Theta.mat', 'medians').medians;

% Alpha
Alpha_Supine_SP = load('Median_Supine_SP_Alpha.mat', 'medians').medians; 
Alpha_Supine_B = load('Median_Supine_B_Alpha.mat', 'medians').medians; 
Alpha_Upright_SP = load('Median_Upright_SP_Alpha.mat', 'medians').medians; 
Alpha_Upright_B = load('Median_Upright_B_Alpha.mat', 'medians').medians;

% Beta
Beta_Supine_SP = load('Median_Supine_SP_Beta.mat', 'medians').medians; 
Beta_Supine_B = load('Median_Supine_B_Beta.mat', 'medians').medians; 
Beta_Upright_SP = load('Median_Upright_SP_Beta.mat', 'medians').medians; 
Beta_Upright_B = load('Median_Upright_B_Beta.mat', 'medians').medians;

% Gamma
Gamma_Supine_SP = load('Median_Supine_SP_Gamma.mat', 'medians').medians; 
Gamma_Supine_B = load('Median_Supine_B_Gamma.mat', 'medians').medians; 
Gamma_Upright_SP = load('Median_Upright_SP_Gamma.mat', 'medians').medians; 
Gamma_Upright_B = load('Median_Upright_B_Gamma.mat', 'medians').medians;

% Initialize results for Friedman p-values
p_values_Friedman = zeros(num_electrodes, 5); % 5 frequencies

% Loop over each electrode
for i = 1:num_electrodes
    % Friedman comparisons for each frequency
    p_values_Friedman(i, 1) = friedman([Delta_Supine_SP(i, :)', Delta_Supine_B(i, :)', Delta_Upright_SP(i, :)', Delta_Upright_B(i, :)'], 1, 'off'); 
    p_values_Friedman(i, 2) = friedman([Theta_Supine_SP(i, :)', Theta_Supine_B(i, :)', Theta_Upright_SP(i, :)', Theta_Upright_B(i, :)'], 1, 'off');
    p_values_Friedman(i, 3) = friedman([Alpha_Supine_SP(i, :)', Alpha_Supine_B(i, :)', Alpha_Upright_SP(i, :)', Alpha_Upright_B(i, :)'], 1, 'off');
    p_values_Friedman(i, 4) = friedman([Beta_Supine_SP(i, :)', Beta_Supine_B(i, :)', Beta_Upright_SP(i, :)', Beta_Upright_B(i, :)'], 1, 'off');
    p_values_Friedman(i, 5) = friedman([Gamma_Supine_SP(i, :)', Gamma_Supine_B(i, :)', Gamma_Upright_SP(i, :)', Gamma_Upright_B(i, :)'], 1, 'off');
end

% Load the EEG file
EEG = pop_loadset('Directory/Powspectrm/Electrodes.set');

% Create a figure with all topoplots
figure;

% Layout parameters
frequencies = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma'};
conditions = {'Supine_SP', 'Supine_B', 'Upright_SP', 'Upright_B'}; % Add the conditions
n_frequencies = length(frequencies);
n_comparaison = length(conditions);

% Create an axes array with tight_subplot on a single row
ha = tight_subplot(1, n_frequencies, [0.05 0.05], [0.1 0.1], [0.1 0.1]);

% Loop over each frequency
for f = 1:n_frequencies
    axes(ha(f));
    
    % Retrieve the appropriate data according to the frequency
    data = p_values_Friedman(:, f); % Use Friedman p-values for each condition
    
    % Calculate the topoplot values
    prova1 = control_perm(data, 0.05, 5, EEG.chanlocs, 30);
    prova1(prova1 == 0) = 1; % Replace zeros with one
    topoplot(-log10(prova1), EEG.chanlocs); % Plot the topoplot
    
    % Apply the reversed colormap in shades of red
    colormap(flipud(cbrewer2('RdBu')));
    
    title(frequencies{f});
    colorbar; 
end

% Adjust the layout
set(gcf, 'Position', [100, 100, 1200, 300]);
%% Wilcoxon

% Number of electrodes and subjects
num_electrodes = 128;
num_subjects = 17;

% Data loading
% Alpha
Alpha_Supine_SP = load('Median_Supine_SP_Alpha.mat', 'medians').medians; 
Alpha_Supine_B = load('Median_Supine_B_Alpha.mat', 'medians').medians; 
Alpha_Upright_SP = load('Median_Upright_SP_Alpha.mat', 'medians').medians; 
Alpha_Upright_B = load('Median_Upright_B_Alpha.mat', 'medians').medians;

% Beta
Beta_Supine_SP = load('Median_Supine_SP_Beta.mat', 'medians').medians; 
Beta_Supine_B = load('Median_Supine_B_Beta.mat', 'medians').medians; 
Beta_Upright_SP = load('Median_Upright_SP_Beta.mat', 'medians').medians; 
Beta_Upright_B = load('Median_Upright_B_Beta.mat', 'medians').medians;

% Delta
Delta_Supine_SP = load('Median_Supine_SP_Delta.mat', 'medians').medians; 
Delta_Supine_B = load('Median_Supine_B_Delta.mat', 'medians').medians; 
Delta_Upright_SP = load('Median_Upright_SP_Delta.mat', 'medians').medians; 
Delta_Upright_B = load('Median_Upright_B_Delta.mat', 'medians').medians;

% Gamma
Gamma_Supine_SP = load('Median_Supine_SP_Gamma.mat', 'medians').medians; 
Gamma_Supine_B = load('Median_Supine_B_Gamma.mat', 'medians').medians; 
Gamma_Upright_SP = load('Median_Upright_SP_Gamma.mat', 'medians').medians; 
Gamma_Upright_B = load('Median_Upright_B_Gamma.mat', 'medians').medians;

% Theta
Theta_Supine_SP = load('Median_Supine_SP_Theta.mat', 'medians').medians; 
Theta_Supine_B = load('Median_Supine_B_Theta.mat', 'medians').medians; 
Theta_Upright_SP = load('Median_Upright_SP_Theta.mat', 'medians').medians; 
Theta_Upright_B = load('Median_Upright_B_Theta.mat', 'medians').medians;

% Initialize results for Wilcoxon p-values and Z-values
p_values_Alpha_Wilcoxon = zeros(num_electrodes, 4); 
z_values_Alpha_Wilcoxon = zeros(num_electrodes, 4);

% Loop over each electrode
for i = 1:num_electrodes
    % Wilcoxon comparisons for Alpha
    [p_values_Alpha_Wilcoxon(i, 1), ~, stats] = signrank(Alpha_Supine_SP(i, :), Alpha_Supine_B(i, :)); 
    z_values_Alpha_Wilcoxon(i, 1) = stats.zval; % Store the Z-value

    [p_values_Alpha_Wilcoxon(i, 2), ~, stats] = signrank(Alpha_Upright_B(i, :), Alpha_Supine_B(i, :));
    z_values_Alpha_Wilcoxon(i, 2) = stats.zval;

    [p_values_Alpha_Wilcoxon(i, 3), ~, stats] = signrank(Alpha_Upright_SP(i, :), Alpha_Supine_SP(i, :));
    z_values_Alpha_Wilcoxon(i, 3) = stats.zval;

    [p_values_Alpha_Wilcoxon(i, 4), ~, stats] = signrank(Alpha_Upright_SP(i, :), Alpha_Upright_B(i, :));
    z_values_Alpha_Wilcoxon(i, 4) = stats.zval;

    % Wilcoxon comparisons for Beta
    [p_values_Beta_Wilcoxon(i, 1), ~, stats] = signrank(Beta_Supine_SP(i, :), Beta_Supine_B(i, :)); 
    z_values_Beta_Wilcoxon(i, 1) = stats.zval; % Store the Z-value

    [p_values_Beta_Wilcoxon(i, 2), ~, stats] = signrank(Beta_Upright_B(i, :), Beta_Supine_B(i, :));
    z_values_Beta_Wilcoxon(i, 2) = stats.zval;

    [p_values_Beta_Wilcoxon(i, 3), ~, stats] = signrank(Beta_Upright_SP(i, :), Beta_Supine_SP(i, :));
    z_values_Beta_Wilcoxon(i, 3) = stats.zval;

    [p_values_Beta_Wilcoxon(i, 4), ~, stats] = signrank(Beta_Upright_SP(i, :), Beta_Upright_B(i, :));
    z_values_Beta_Wilcoxon(i, 4) = stats.zval;

    % Wilcoxon comparisons for Delta
    [p_values_Delta_Wilcoxon(i, 1), ~, stats] = signrank(Delta_Supine_SP(i, :), Delta_Supine_B(i, :)); 
    z_values_Delta_Wilcoxon(i, 1) = stats.zval; % Store the Z-value

    [p_values_Delta_Wilcoxon(i, 2), ~, stats] = signrank(Delta_Upright_B(i, :), Delta_Supine_B(i, :));
    z_values_Delta_Wilcoxon(i, 2) = stats.zval;

    [p_values_Delta_Wilcoxon(i, 3), ~, stats] = signrank(Delta_Upright_SP(i, :), Delta_Supine_SP(i, :));
    z_values_Delta_Wilcoxon(i, 3) = stats.zval;

    [p_values_Delta_Wilcoxon(i, 4), ~, stats] = signrank(Delta_Upright_SP(i, :), Delta_Upright_B(i, :));
    z_values_Delta_Wilcoxon(i, 4) = stats.zval;

    % Wilcoxon comparisons for Gamma
    [p_values_Gamma_Wilcoxon(i, 1), ~, stats] = signrank(Gamma_Supine_SP(i, :), Gamma_Supine_B(i, :)); 
    z_values_Gamma_Wilcoxon(i, 1) = stats.zval; % Store the Z-value

    [p_values_Gamma_Wilcoxon(i, 2), ~, stats] = signrank(Gamma_Upright_B(i, :), Gamma_Supine_B(i, :));
    z_values_Gamma_Wilcoxon(i, 2) = stats.zval;

    [p_values_Gamma_Wilcoxon(i, 3), ~, stats] = signrank(Gamma_Upright_SP(i, :), Gamma_Supine_SP(i, :));
    z_values_Gamma_Wilcoxon(i, 3) = stats.zval;

    [p_values_Gamma_Wilcoxon(i, 4), ~, stats] = signrank(Gamma_Upright_SP(i, :), Gamma_Upright_B(i, :));
    z_values_Gamma_Wilcoxon(i, 4) = stats.zval;

    % Wilcoxon comparisons for Theta
    [p_values_Theta_Wilcoxon(i, 1), ~, stats] = signrank(Theta_Supine_SP(i, :), Theta_Supine_B(i, :)); 
    z_values_Theta_Wilcoxon(i, 1) = stats.zval; % Store the Z-value

    [p_values_Theta_Wilcoxon(i, 2), ~, stats] = signrank(Theta_Upright_B(i, :), Theta_Supine_B(i, :));
    z_values_Theta_Wilcoxon(i, 2) = stats.zval;

    [p_values_Theta_Wilcoxon(i, 3), ~, stats] = signrank(Theta_Upright_SP(i, :), Theta_Supine_SP(i, :));
    z_values_Theta_Wilcoxon(i, 3) = stats.zval;

    [p_values_Theta_Wilcoxon(i, 4), ~, stats] = signrank(Theta_Upright_SP(i, :), Theta_Upright_B(i, :));
    z_values_Theta_Wilcoxon(i, 4) = stats.zval;

end

% Load the EEG file (example for a .set file, adapt according to your file)
EEG = pop_loadset('Directory/Powspectrm/Electrodes.set');
locs = EEG.chanlocs;

% Wilcoxon p-values for each frequency band
% Alpha
p_values_Alpha_Wilcoxon_Supine_SP_vs_Supine_B = p_values_Alpha_Wilcoxon(:, 1);
p_values_Alpha_Wilcoxon_Upright_B_vs_Supine_B = p_values_Alpha_Wilcoxon(:, 2); 
p_values_Alpha_Wilcoxon_Upright_SP_vs_Supine_SP = p_values_Alpha_Wilcoxon(:, 3);
p_values_Alpha_Wilcoxon_Upright_SP_vs_Upright_B = p_values_Alpha_Wilcoxon(:, 4); 

% Beta
p_values_Beta_Wilcoxon_Supine_SP_vs_Supine_B = p_values_Beta_Wilcoxon(:, 1);
p_values_Beta_Wilcoxon_Upright_B_vs_Supine_B = p_values_Beta_Wilcoxon(:, 2); 
p_values_Beta_Wilcoxon_Upright_SP_vs_Supine_SP = p_values_Beta_Wilcoxon(:, 3);
p_values_Beta_Wilcoxon_Upright_SP_vs_Upright_B = p_values_Beta_Wilcoxon(:, 4); 

% Delta
p_values_Delta_Wilcoxon_Supine_SP_vs_Supine_B = p_values_Delta_Wilcoxon(:, 1);
p_values_Delta_Wilcoxon_Upright_B_vs_Supine_B = p_values_Delta_Wilcoxon(:, 2); 
p_values_Delta_Wilcoxon_Upright_SP_vs_Supine_SP = p_values_Delta_Wilcoxon(:, 3);
p_values_Delta_Wilcoxon_Upright_SP_vs_Upright_B = p_values_Delta_Wilcoxon(:, 4); 

% Gamma
p_values_Gamma_Wilcoxon_Supine_SP_vs_Supine_B = p_values_Gamma_Wilcoxon(:, 1);
p_values_Gamma_Wilcoxon_Upright_B_vs_Supine_B = p_values_Gamma_Wilcoxon(:, 2); 
p_values_Gamma_Wilcoxon_Upright_SP_vs_Supine_SP = p_values_Gamma_Wilcoxon(:, 3);
p_values_Gamma_Wilcoxon_Upright_SP_vs_Upright_B = p_values_Gamma_Wilcoxon(:, 4); 

% Theta
p_values_Theta_Wilcoxon_Supine_SP_vs_Supine_B = p_values_Theta_Wilcoxon(:, 1);
p_values_Theta_Wilcoxon_Upright_B_vs_Supine_B = p_values_Theta_Wilcoxon(:, 2); 
p_values_Theta_Wilcoxon_Upright_SP_vs_Supine_SP = p_values_Theta_Wilcoxon(:, 3);
p_values_Theta_Wilcoxon_Upright_SP_vs_Upright_B = p_values_Theta_Wilcoxon(:, 4); 

% Z-score

% Alpha
z_values_Alpha_Wilcoxon_Supine_SP_vs_Supine_B = z_values_Alpha_Wilcoxon(:, 1); 
z_values_Alpha_Wilcoxon_Upright_B_vs_Supine_B = z_values_Alpha_Wilcoxon(:, 2); 
z_values_Alpha_Wilcoxon_Upright_SP_vs_Supine_SP = z_values_Alpha_Wilcoxon(:, 3); 
z_values_Alpha_Wilcoxon_Upright_SP_vs_Upright_B = z_values_Alpha_Wilcoxon(:, 4); 

% Beta
z_values_Beta_Wilcoxon_Supine_SP_vs_Supine_B = z_values_Beta_Wilcoxon(:, 1); 
z_values_Beta_Wilcoxon_Upright_B_vs_Supine_B = z_values_Beta_Wilcoxon(:, 2); 
z_values_Beta_Wilcoxon_Upright_SP_vs_Supine_SP = z_values_Beta_Wilcoxon(:, 3); 
z_values_Beta_Wilcoxon_Upright_SP_vs_Upright_B = z_values_Beta_Wilcoxon(:, 4); 

% Delta
z_values_Delta_Wilcoxon_Supine_SP_vs_Supine_B = z_values_Delta_Wilcoxon(:, 1); 
z_values_Delta_Wilcoxon_Upright_B_vs_Supine_B = z_values_Delta_Wilcoxon(:, 2); 
z_values_Delta_Wilcoxon_Upright_SP_vs_Supine_SP = z_values_Delta_Wilcoxon(:, 3); 
z_values_Delta_Wilcoxon_Upright_SP_vs_Upright_B = z_values_Delta_Wilcoxon(:, 4); 

% Gamma
z_values_Gamma_Wilcoxon_Supine_SP_vs_Supine_B = z_values_Gamma_Wilcoxon(:, 1); 
z_values_Gamma_Wilcoxon_Upright_B_vs_Supine_B = z_values_Gamma_Wilcoxon(:, 2); 
z_values_Gamma_Wilcoxon_Upright_SP_vs_Supine_SP = z_values_Gamma_Wilcoxon(:, 3); 
z_values_Gamma_Wilcoxon_Upright_SP_vs_Upright_B = z_values_Gamma_Wilcoxon(:, 4); 

% Theta
z_values_Theta_Wilcoxon_Supine_SP_vs_Supine_B = z_values_Theta_Wilcoxon(:, 1); 
z_values_Theta_Wilcoxon_Upright_B_vs_Supine_B = z_values_Theta_Wilcoxon(:, 2); 
z_values_Theta_Wilcoxon_Upright_SP_vs_Supine_SP = z_values_Theta_Wilcoxon(:, 3); 
z_values_Theta_Wilcoxon_Upright_SP_vs_Upright_B = z_values_Theta_Wilcoxon(:, 4); 


% List of frequency bands and comparisons
frequencies = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma'};
comparisons = {
    'Supine_SP_vs_Supine_B', 
    'Upright_B_vs_Supine_B', 
    'Upright_SP_vs_Supine_SP', 
    'Upright_SP_vs_Upright_B'
};

% Colors
color_map = flipud(cbrewer2('RdBu'));

% Layout parameters
n_frequencies = length(frequencies);
n_comparisons = length(comparisons);

% Create a figure with all topoplots
figure;
ha = tight_subplot(n_comparisons, n_frequencies, [0.05 0.05], [0.1 0.1], [0.1 0.1]); 

% Loop over comparisons (rows)
for c = 1:n_comparisons
    comparison = comparisons{c};
    
    % Loop over frequency bands (columns)
    for f = 1:n_frequencies
        frequency = frequencies{f};
        
        % Select the corresponding axis
        ax_idx = (c - 1) * n_frequencies + f; % Take the columns into account
        axes(ha(ax_idx)); % Set the current axis
        
        % Retrieve p-values and z-scores for each frequency and comparison
        p_values = eval(['p_values_' frequency '_Wilcoxon_' comparison]); % Ex: p_values_Delta_Wilcoxon_Supine_B_vs_Supine_SP
        z_scores = eval(['z_values_' frequency '_Wilcoxon_' comparison]); % Ex: z_values_Delta_Wilcoxon_Supine_B_vs_Supine_SP
        
        % Cluster correction
        Significant_values = control_perm(p_values, 0.05, 5, EEG.chanlocs, 30);
        
        % Create a mask for significant z-scores
        significant_zscores = z_scores; 
        significant_zscores(~Significant_values) = 0; % Set non-significant z-scores to zero
        
        % Plot the topoplot with significant z-scores
        topoplot(significant_zscores, EEG.chanlocs);
        
        colormap(color_map);
        
        % Set the axis limits for each topoplot
        caxis([-4 4]); % Set the color scale from -4 to 4
    end
end

% Add a single color scale
hcb = colorbar('Position', [0.92, 0.11, 0.02, 0.76], 'Ticks', -4:2:4, ...
               'TickLabels', {'-4', '-2', '0', '2', '4'});

% Title for the frequency columns
for f = 1:n_frequencies
    axes(ha(f)); % Select the first row of each column
    title(frequencies{f}, 'FontSize', 12, 'FontWeight', 'bold'); 
    axis off; 
end

% Adjust the figure layout
set(gcf, 'Position', [100, 100, 1400, 800]);

% Mean z-scores and p-values:
% Initialize a structure to store the means
results_mean = struct();

% Loop over comparisons (rows)
for c = 1:n_comparisons
    comparison = comparisons{c};
    
    for f = 1:n_frequencies
        frequency = frequencies{f};
        
        % Retrieve p-values and z-scores
        p_values = eval(['p_values_' frequency '_Wilcoxon_' comparison]);
        z_scores = eval(['z_values_' frequency '_Wilcoxon_' comparison]);
        
        % Cluster correction
        Significant_values = control_perm(p_values, 0.05, 5, EEG.chanlocs, 30);
        
        % Significant indices
        sig_idx = find(Significant_values);
        
        if ~isempty(sig_idx)
            mean_p = mean(p_values(sig_idx));
            mean_z = mean(z_scores(sig_idx));
        else
            mean_p = NaN;
            mean_z = NaN;
        end
        
        % Save in the structure
        results_mean.(frequency).(comparison).mean_p = mean_p;
        results_mean.(frequency).(comparison).mean_z = mean_z;
    end
end

% Display the results
disp('Mean P et Z for each frequency band and comparaison :');
disp(results_mean);

%% Baroreflex correlation

% Load the EEG file (example for a .set file, adapt according to your file)
EEG = pop_loadset('Directory/Powspectrm/Electrodes.set');
locs = EEG.chanlocs;


color_map = flipud(cbrewer2('RdBu'));

% Data loading
% Alpha
Alpha_Supine_SP = load('Median_Supine_SP_Alpha.mat', 'medians').medians; 
Alpha_Supine_B = load('Median_Supine_B_Alpha.mat', 'medians').medians; 
Alpha_Upright_SP = load('Median_Upright_SP_Alpha.mat', 'medians').medians; 
Alpha_Upright_B = load('Median_Upright_B_Alpha.mat', 'medians').medians;

% Beta
Beta_Supine_SP = load('Median_Supine_SP_Beta.mat', 'medians').medians; 
Beta_Supine_B = load('Median_Supine_B_Beta.mat', 'medians').medians; 
Beta_Upright_SP = load('Median_Upright_SP_Beta.mat', 'medians').medians; 
Beta_Upright_B = load('Median_Upright_B_Beta.mat', 'medians').medians;

% Delta
Delta_Supine_SP = load('Median_Supine_SP_Delta.mat', 'medians').medians; 
Delta_Supine_B = load('Median_Supine_B_Delta.mat', 'medians').medians; 
Delta_Upright_SP = load('Median_Upright_SP_Delta.mat', 'medians').medians; 
Delta_Upright_B = load('Median_Upright_B_Delta.mat', 'medians').medians;

% Gamma
Gamma_Supine_SP = load('Median_Supine_SP_Gamma.mat', 'medians').medians; 
Gamma_Supine_B = load('Median_Supine_B_Gamma.mat', 'medians').medians; 
Gamma_Upright_SP = load('Median_Upright_SP_Gamma.mat', 'medians').medians; 
Gamma_Upright_B = load('Median_Upright_B_Gamma.mat', 'medians').medians;

% Theta
Theta_Supine_SP = load('Median_Supine_SP_Theta.mat', 'medians').medians; 
Theta_Supine_B = load('Median_Supine_B_Theta.mat', 'medians').medians; 
Theta_Upright_SP = load('Median_Upright_SP_Theta.mat', 'medians').medians; 
Theta_Upright_B = load('Median_Upright_B_Theta.mat', 'medians').medians;

% Baroreflex Supine_SP
BRS = readtable('Directory/BRS.csv');

% Assume that the variable names in BRS are 'Supine_SP', 'Supine_B', 'Upright_SP', 'Upright_B'
% If this is not the case, adjust the column names according to the actual table labels.

BRS_Supine_SP = BRS.Supine_SP; % Access the Supine_SP column
BRS_Supine_B = BRS.Supine_B;   % Access the Supine_B column
BRS_Upright_SP = BRS.Upright_SP; % Access the Upright_SP column
BRS_Upright_B = BRS.Upright_B;  % Access the Upright_B column


% Initialize matrices to store the correlation results

% Supine_SP
rho_Alpha_Supine_SP = zeros(128, 1);
pval_Alpha_Supine_SP = zeros(128, 1);
rho_Beta_Supine_SP = zeros(128, 1);
pval_Beta_Supine_SP = zeros(128, 1);
rho_Gamma_Supine_SP = zeros(128, 1);
pval_Gamma_Supine_SP = zeros(128, 1);
rho_Delta_Supine_SP = zeros(128, 1);
pval_Delta_Supine_SP = zeros(128, 1);
rho_Theta_Supine_SP = zeros(128, 1);
pval_Theta_Supine_SP = zeros(128, 1);

% Supine_B
rho_Alpha_Supine_B = zeros(128, 1);
pval_Alpha_Supine_B = zeros(128, 1);
rho_Beta_Supine_B = zeros(128, 1);
pval_Beta_Supine_B = zeros(128, 1);
rho_Gamma_Supine_B = zeros(128, 1);
pval_Gamma_Supine_B = zeros(128, 1);
rho_Delta_Supine_B = zeros(128, 1);
pval_Delta_Supine_B = zeros(128, 1);
rho_Theta_Supine_B = zeros(128, 1);
pval_Theta_Supine_B = zeros(128, 1);

% Upright_SP
rho_Alpha_Upright_SP = zeros(128, 1);
pval_Alpha_Upright_SP = zeros(128, 1);
rho_Beta_Upright_SP = zeros(128, 1);
pval_Beta_Upright_SP = zeros(128, 1);
rho_Gamma_Upright_SP = zeros(128, 1);
pval_Gamma_Upright_SP = zeros(128, 1);
rho_Delta_Upright_SP = zeros(128, 1);
pval_Delta_Upright_SP = zeros(128, 1);
rho_Theta_Upright_SP = zeros(128, 1);
pval_Theta_Upright_SP = zeros(128, 1);

% Upright_B
rho_Alpha_Upright_B = zeros(128, 1);
pval_Alpha_Upright_B = zeros(128, 1);
rho_Beta_Upright_B = zeros(128, 1);
pval_Beta_Upright_B = zeros(128, 1);
rho_Gamma_Upright_B = zeros(128, 1);
pval_Gamma_Upright_B = zeros(128, 1);
rho_Delta_Upright_B = zeros(128, 1);
pval_Delta_Upright_B = zeros(128, 1);
rho_Theta_Upright_B = zeros(128, 1);
pval_Theta_Upright_B = zeros(128, 1);


                                    % Example Condition 1
% Calculate correlations for Alpha Supine_SP with BRS_Supine_SP for the 128 electrodes
for i = 1:128
    [rho_Alpha_Supine_SP(i), pval_Alpha_Supine_SP(i)] = corr(BRS_Supine_SP, Alpha_Supine_SP(i,:)', 'type','Spearman');
end


% Calculate correlations for Beta Supine_SP with BRS_Supine_SP for the 128 electrodes
for i = 1:128
    [rho_Beta_Supine_SP(i), pval_Beta_Supine_SP(i)] = corr(BRS_Supine_SP, Beta_Supine_SP(i,:)', 'type','Spearman');
end


% Calculate correlations for Gamma Supine_SP with BRS_Supine_SP for the 128 electrodes
for i = 1:128
    [rho_Gamma_Supine_SP(i), pval_Gamma_Supine_SP(i)] = corr(BRS_Supine_SP, Gamma_Supine_SP(i,:)', 'type','Spearman');
end

% Calculate correlations for Delta Supine_SP with BRS_Supine_SP for the 128 electrodes
for i = 1:128
    [rho_Delta_Supine_SP(i), pval_Delta_Supine_SP(i)] = corr(BRS_Supine_SP, Delta_Supine_SP(i,:)', 'type','Spearman');
end

% Calculate correlations for Theta Supine_SP with BRS_Supine_SP for the 128 electrodes
for i = 1:128
    [rho_Theta_Supine_SP(i), pval_Theta_Supine_SP(i)] = corr(BRS_Supine_SP, Theta_Supine_SP(i,:)', 'type','Spearman');
end
  
% Initialize the figure
figure;

% Create a grid of subplots with 1 row (conditions) and 5 columns (frequencies)
ha = tight_subplot(1, 5, [0.05 0.05], [0.1 0.1], [0.05 0.05]);

% List of frequency band names in the desired order
frequencies = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma'};

% Iterate through the frequency bands to plot the topoplots
for freq = 1:length(frequencies)
    
    % Select the frequency band
    switch frequencies{freq}
        case 'Delta'
            rho = rho_Delta_Supine_SP;
            pval = pval_Delta_Supine_SP;
        case 'Theta'
            rho = rho_Theta_Supine_SP;
            pval = pval_Theta_Supine_SP;
        case 'Alpha'
            rho = rho_Alpha_Supine_SP;
            pval = pval_Alpha_Supine_SP;
        case 'Beta'
            rho = rho_Beta_Supine_SP;
            pval = pval_Beta_Supine_SP;
        case 'Gamma'
            rho = rho_Gamma_Supine_SP;
            pval = pval_Gamma_Supine_SP;
    end
    
     % Apply cluster-based correction
    prova1 = control_perm(pval, 0.05, 5, EEG.chanlocs, 50);
    prova1(prova1 == 0) = 1;

    % Create a mask for significant rho values (p-value < 0.05)
    significant_rho = rho;
    significant_rho(prova1 == 1) = 0;  % Set non-significant rho values to zero

    % Calculate the mean of the non-zero significant rho values
    nonzero_rho = significant_rho(significant_rho ~= 0);
    if ~isempty(nonzero_rho)
        mean_rho_per_band(freq) = mean(nonzero_rho);
    else
        mean_rho_per_band(freq) = NaN; % If no significant channel
    end

    % Select the subplot for this frequency
    axes(ha(freq));

    % Plot the topoplot
    topoplot(significant_rho, EEG.chanlocs,'whitebk', 'on');
    title([frequencies{freq} ' rho (p < 0.05)']);
    
    % Apply the reversed colormap in shades of red
    colormap(color_map);

    % Set the axis limits for each topoplot
    caxis([-1 1]);
end
set(gcf, 'Color', 'w');
% Add a single colorbar for all subplots
cb = colorbar('Position', [0.97 0.1 0.015 0.8]);  % Even further to the right
cb.Label.String = 'rho values';

% Adjust the figure layout
set(gcf, 'Position', [100, 100, 1600, 800]); % Increase the width for better readability

% Display the means in the console
disp('--- mean of significant rho for each frequency bands ---');
for freq = 1:length(frequencies)
    fprintf('%s : %.4f\n', frequencies{freq}, mean_rho_per_band(freq));
end