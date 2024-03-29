# Mini-Processor


This repository contains code for designing a hardware that implements a processor which can execute a subset of ARM instructions. Further details can be found in the document titled "Lab Assignment 2 Overview.pdf".


## Logistics

The overall assignment was divided into 8 stages. The short description of each stage can be found in the file "Lab Assignment 2 Overview.pdf". Each directory in the "Stages" folder corresponds to one of these stages.

The code was written in VHDL. EDAplayground was used for simulation and Quartus was used for synthesis.

## Structure

The main directory of the repository contains this README file, along with a directory called "Processor". Processor directory contains the final modular working code for a processor with desired functionality. The main directory also contains a directory "Stages", which includes different stages of the assignment.

Each directory in this subdirectory contains the problem statement for the specific stage, along with the code submitted. The directory also has the report submitted, testcases, simulations and the synthesis reports. Some directories may also contain the RTL Synthesis report, which was generated using Quartus.

## Logic

The logic for Single Cycle Datapath and Multi Cycle Datapath + Controller was taken from the lecture slides and is attached below.

![alt text](https://github.com/TanishGupta15/COL216/blob/main/Stages/Stage-1/SingleCycleDatapath.png)
![alt text](https://github.com/TanishGupta15/COL216/blob/main/Stages/Stage-3/MulticycleDataPath%26Controller.png)


## Copyright

This repository was made for Assignment-2 of course COL216, II Semester, 2020-21 at IIT Delhi under Prof Anshul Kumar. Copy at your own risk :) (Changing variable names won't help you escape plagiarism).


## Author

Tanish Gupta (2020CS10397)
