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
 
 **Example**:
 
Bin 0/DC bias signal is [1     1     1     1     1     1     1     1].'; 
 
Signal with bin 1 and 7 on is : [1.0000    0.7071    0.0000   -0.7071   -1.0000   -0.7071   -0.0000    0.7071];
              
It stores the result/table with "writetable(T, 'fft_permutation_results2.csv');" where you can change the file it will be save in. 

# 'filterResults.m'
This MATLAB script processes FFT result data stored in an `.xlsx` file and filters it based on specific criteria.  
It extracts key columns, applies a filter condition, and exports the filtered data to a new file.

---

## Overview

- Reads an `.xlsx` file as a table.  
- Extracts the following columns:
  - `trial`
  - `permutation`
  - `Largersum`
- Applies a filter condition from **line 19** to create a subset of rows.
- Exports the filtered results to a new file:  filtered_data.xlsx

Feel free to change line 19 to "Find the rows where the x value is the largest in the row". So if you have a signal with bin 1 on, x = 2; 

The commented part in the bottom is where I have another signal with the table. I can use the above filtered value(filtered_data.xlsx) to remove the trials from the table(fft_permutation_results2) and store it in a new file "fft_permutation_results3" since when you overwrite the file with shorter rows, some of the filtered rows will still stay at the bottom of the xlsx file.
