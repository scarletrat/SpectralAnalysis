clc;
clear;
N = 8;
x = [1.0000    0.7071    0.0000   -0.7071   -1.0000   -0.7071   -0.0000    0.7071].'; %signal
trueFFT = fft(x);
W = exp(-1j*2*pi/N);   % twiddle factor W_N

% Generate ALL permutations
permsList = perms(1:N);   % size = [40320 × 8]
numTrials = size(permsList, 1);

fprintf("Total permutations: %d\n", numTrials);

% First stage butterfly matrix (radix-2)
B1_DIT = [1  1  0  0  0  0  0  0;
      1 -1  0  0  0  0  0  0;
      0  0  1  1  0  0  0  0;
      0  0  1 -1  0  0  0  0;
      0  0  0  0  1  1  0  0;
      0  0  0  0  1 -1  0  0;
      0  0  0  0  0  0  1  1;
      0  0  0  0  0  0  1 -1];

B1_DIF = [1 0 0 0 1 0 0 0;   % sums
      0 1 0 0 0 1 0 0;
      0 0 1 0 0 0 1 0;
      0 0 0 1 0 0 0 1;
      1 0 0 0 -1 0 0 0;  % differences
      0 1 0 0 0 -1 0 0;
      0 0 1 0 0 0 -1 0;
      0 0 0 1 0 0 0 -1];

tw = [1 1 1 1 1 W^1 W^2 W^3].';  % twiddle vector for DIF stage

%Creating table
T = table((1:numTrials)', ...
    strings(numTrials,1), ...
    zeros(numTrials,1), ...
    zeros(numTrials,1), ...
    strings(numTrials,1), ...
    strings(numTrials,1), ...
    zeros(numTrials,1), ...
    'VariableNames', {'Trial','Permutation','EvenSum','OddSum','LargerSum','DIT_result','DIF_val'});


for k = 1:numTrials
    P = eye(N);
    P = P(permsList(k,:), :); % permutation matrix
    largersum =[];
    % ----- DIT -----
    y_dit = B1_DIT * (P * x);
    evenSum = sum(abs(y_dit(1:2:end)));
    oddSum  = sum(abs(y_dit(2:2:end)));
    if evenSum > oddSum
        score_dit = "even";
        largersum = y_dit(1:2:end);
    else
        score_dit = "odd";
        largersum = y_dit(2:2:end);
    end

    % ----- DIF -----
    x_perm = P * x;
    y_dif = B1_DIF * x_perm;
    y_dif(5:8) = y_dif(5:8) .* tw(5:8);
    firstHalf = sum(abs(y_dif(1:4)));
    secondHalf = sum(abs(y_dif(5:8)));
    if firstHalf > secondHalf
        score_dif = firstHalf;
    else
        score_dif = secondHalf;
    end
    % Store in struct array
    T.Trial(k) = k;
    T.Permutation(k) = string(mat2str(permsList(k,:)));
    T.EvenSum(k) = evenSum;
    T.OddSum(k) = oddSum;
    T.LargerSum(k) = string(mat2str(largersum.'));
    T.DIT_result(k) = score_dit;
    T.DIF_val(k) = score_dif;

    %fprintf("Trial %02d | DIT=%-11s | DIT_val=%s | DIF=%.2f | Perm=%s\n", ...
        %k, score_dit, mat2str(largersum(:)), score_dif, mat2str(permsList(k,:)));
end
writetable(T, 'fft_permutation_results2.csv');

