%DIF 
clc;
clear;
N = 4;
x = [1,-5,0,2].';   


% Stage 1 butterfly
B1 = [1 0 1 0;
      0 1 0 1;
      1 0 -1 0;
      0 1 0 -1];

% Stage 2 butterfly
W = exp(-1j*2*pi/N);   % twiddle factor W_N
D = diag([1, 1, W^0, W^1]);
B2 = [1 1 0 0;
      1 -1 0 0;
      0 0 1 1;
      0 0 1 -1]* D;

% Permutation (bit reversal for N=4: [0 2 1 3])
P = [1 0 0 0;
     0 0 1 0;
     0 1 0 0;
     0 0 0 1];
% DIF FFT using matrices
X = P*B2*B1*x;

Z = fft(x);
