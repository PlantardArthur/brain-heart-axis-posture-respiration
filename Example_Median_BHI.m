%% Example for 1 condition, Alpha frequency band
% Condition : Supine_SP
% Frequency band : Alpha (A)
% This script loads one CSV file per subject, computes the row-wise
% median for each subject, and saves the resulting median matrix.

% Settings
dataDir      = 'Directory/Heart to BrainHF';
condition    = 'Supine_SP';
band         = 'Alpha';
outputFile   = sprintf('Median_%s_%s.mat', condition, band);

% Subject codes, in the same order as in the original file names
subjectCodes = {'1', '2', '3', '4', '5', '6', '7', '8', '9', ...
                '10', '11', '12', '13', '14', '15', '16', '17'};

nSubjects = numel(subjectCodes);

% Load data and compute the median for each subject
medians = [];

for i = 1:nSubjects
    fileName = sprintf('Sujet_%s_%s_BrainToLF.csv', subjectCodes{i}, band);
    filePath = fullfile(dataDir, fileName);

    subjectTable = readtable(filePath);

    % Row-wise median (median across columns, for each row)
    subjectMedian = median(subjectTable{:, :}, 2);

    medians = [medians, subjectMedian]; %#ok<AGROW>
end

% Save the median values only
save(outputFile, 'medians');

disp('Median values computed and saved:');
disp(outputFile);
