%Reading the table, filter it and export it to a new table

T = readtable('fft_permutation_results1.xlsx', 'ReadVariableNames', true);

% Access columns as cell arrays of strings
trail = T.Trial;
perm_col = T.('Permutation');     %[8 7 6 5 4 2 3 1]
sum_col  = T.('LargerSum');      % [0.7071 0.2929 -1.4142 -1]

%  Convert strings like '[8 7 6 5 4 2 3 1]' to numeric arrays
perm_matrix = cellfun(@(s) str2num(s(2:end-1)), perm_col, 'UniformOutput', false);
sum_matrix  = cellfun(@(s) str2num(s(2:end-1)), sum_col,  'UniformOutput', false);

%  Convert cell arrays to numeric matrices
perm_matrix = vertcat(perm_matrix{:});  % N x 8
sum_matrix  = vertcat(sum_matrix{:});   % N x 4 (or whatever length)

% Find the rows where the first value is the largest in the row
keep_rows = sum_matrix(:,1) == max(sum_matrix, [], 2);

% Filter matrices and Trial
sum_matrix = sum_matrix(keep_rows, :);
perm_matrix = perm_matrix(keep_rows, :);
trial_vector = T.Trial(keep_rows);
T_filtered = table(trial_vector, cellstr(num2str(perm_matrix)), cellstr(num2str(sum_matrix)), ...
                 'VariableNames', {'Trial', 'Permutation', 'LargerSum1'});

writetable(T_filtered, 'filtered_data.xlsx');
T_keep = readtable('filtered_data.xlsx');
keep_trials = T_keep.Trial; 
T_data = readtable('fft_permutation_results1.xlsx');
temp = T_data.Trial;

% Find rows where Trial exists in allowed_trials
keep_rows = ismember(temp, keep_trials);

% Filter the table
T_filtered = T_data(keep_rows, :);
writetable(T_filtered, 'fft_permutation_results3.xlsx');




