firstStage_N_8.m: It runs the first stage output of N = 8 DIF and DIT FFT, store the results in the table and export it to a file. For DIT, I check the sum of odd and even indicies and compare them.
For DIF, I check the sum of the first half and last half and compare them. 
Change x in line 4 to input signal of choice. Example: Bin 0/DC bias signal is [1     1     1     1     1     1     1     1].'; 
Signal with bin 1 and 7 on is : [1.0000    0.7071    0.0000   -0.7071   -1.0000   -0.7071   -0.0000    0.7071];
It stores the result/table with "writetable(T, 'fft_permutation_results2.csv');" where you can change the file it will be save in. 
