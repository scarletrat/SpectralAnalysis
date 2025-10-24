
# `firstStage_N_8.m`

This MATLAB script runs the **first stage** of an **8-point FFT** using both **Decimation-in-Time (DIT)** and **Decimation-in-Frequency (DIF)** algorithms.  
It compares partial results from each method, stores them in a table, and exports the results to a CSV file.

---

## Overview

- **DIT FFT**  
  Compares the **sum of even and odd indices** after the first stage.

- **DIF FFT**  
  Compares the **sum of the first half and second half** after the first stage.

The computed values are organized into a MATLAB table and written to a CSV file for further inspection.

---

## Usage
 Change x in line 4 to input signal of choice. 
 **Example**
 
Bin 0/DC bias signal is [1     1     1     1     1     1     1     1].'; 
 
Signal with bin 1 and 7 on is : [1.0000    0.7071    0.0000   -0.7071   -1.0000   -0.7071   -0.0000    0.7071];
              
It stores the result/table with "writetable(T, 'fft_permutation_results2.csv');" where you can change the file it will be save in. 
