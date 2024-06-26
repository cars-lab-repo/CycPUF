# CycPUF: Cyclic Physical Unclonable Function
This repository contains resources related to cyclic and acyclic PUF generation.   </br>
[Michael Dominguez](https://github.com/M-A-D-007) & [Amin Rezaei](https://github.com/r3zaei) </br>
### Abstract

Physical Unclonable Functions (PUFs) leverage manufacturing process imperfections that cause propagation delay discrepancies for the signals traveling along these paths. While PUFs can be used for device authentication and chip-specific key generation, strong PUFs have been shown to be vulnerable to machine learning modeling attacks. Although there is an impression that combinational circuits must be designed without any loops, cyclic combinational circuits have been shown to increase design security against hardware intellectual property theft. In this project, we introduce feedback signals into traditional delay-based PUF designs such as arbiter PUF, ring oscillator PUF, and butterfly PUF to give them a wider range of possible output behaviors and thus an edge against modeling attacks. Based on our analysis, cyclic PUFs produce responses that can be binary, steady-state, oscillating, or pseudo-random under fixed challenges.
## A. Contents 
 
### 1. Paper
The published paper in which we introduce the CycPUF is contained in this folder.

### 2. Sample Dataset
A sample dataset has been generated and is ready for use.  The layout is as follows:	<br>
	- `multi_bit_APUF`: an acyclic APUF with 121-bit challenge and response size	<br>
	- `multi_bit_BPUF`: an acyclic BPUF with 33-bit challenge and response size	<br>
	- `multi_bit_CycAPUF`: a cyclic APUF with 45-bit challenge and response size, and 44 cycles	<br>
	- `multi_bit_CycBPUF`: a cyclic BPUF with 15-bit challenge and response size, and 3 cycles	<br>
	- `multi_bit_CycROPUF`: a cyclic ROPUF with 6-bit challenge and response size, and 6 cycles	<br>
	- `multi_bit_ROPUF`: an acyclic ROPUF with 22-bit challenge and response size	<br>
	- `one_bit_APUF`: an acyclic APUF with 243-bit challenge and single-bit response size	<br>
	- `one_bit_BPUF`: an acyclic BPUF with 10-bit challenge and single-bit response size	<br>
	- `one_bit_CycAPUF`: a cyclic APUF with 37-bit challenge, single-bit response size, and 25 cycles	<br>
	- `one_bit_CycBPUF`: a cyclic BPUF with 51-bit challenge, single-bit response size, and 25 cycles	<br>
	- `two_bit_CycROPUF`: a cyclic ROPUF with 14-bit challenge, two-bit response size, and 10 cycles	<br>
	- `two_bit_ROPUF`: an acyclic ROPUF with 34-bit challenge, two-bit response size	<br>

### 3. Source
Our source code is contained in this folder.  Here you will find two python files:	<br>
	- `puf_defs`: a python module containing the module definitions for verilog code generation	<br>
	- `puf_framework`: the main python file for PUF generation	<br>

## B. Usage
Use the below steps to generate your own PUFs.

### 1. First, navigate to the `sources` directory.
```
>cd source
```

### 2. Next, run the `puf_framework` to begin the program.
```
>python puf_framework.py
```

### 3. Pick the PUF design that is desired.
Three basic delay PUF designs are currently avilable.  In order, these are APUF (1), BPUF (2), and ROPUF (3). By typing a 1, 2, or 3 and hitting enter, one can select their base PUF design.	<br>
*For the purpose of this tutorial, we will choose the APUF (1).*
```
>Type 1, 2, or 3: 1
```
### 4. Choose whether the PUF will be a CycPUF or not.
Here one can set whether the PUF to be generated will contain cycles for CycPUF behavior or if the PUF will remain an acyclic PUF.	<br>
*For the purpose of this tutorial, we will choose to create a CycPUF (y).*
```
>Will this be a CycPUF?
>Type (y)es or (n)o: y
```
### 5. Choose whether the PUF will have a multi-bit response or not.
The size of the response vector can either take on the size of the challenge vector or may be a single-bit response.	<br>
*For the purpose of this tutorial, we will choose to have a multi-bit response (y).*
```
>*Will this PUF have a multi-bit response?*
>Type (y)es or (n)o: y
```
### 6. Choose the size of the challenge vector.
The size of the challenge vector must be an integer of at least 1.	<br>
- NOTE: The smallest challenge (and response) size that the ROPUF may have is 2 and must be an even number.	<br>

*For the purpose of this tutorial, we will choose to have a challenge size of 45.*
```
>Enter the size of the Challenge vector (an integer): 45
```
### 7. Choose the number of cycles.
The number of cycles for a CycPUF must be an integer of at least 1 and cannot equal the challenge vector size.	<br>
- NOTE: The minimum number of cycles that the ROPUF may have is 2 and must be an even number.  A CycROPUF with a challenge of 2 is not possible.	<br>

*For the purpose of this tutorial, we will choose to have 44 cycles.*
```
>Enter the number of cycles (an integer): 44
```
### 8. The requested PUF has been generated.
The PUF that we specified has been generated and can now be found in the `sources` directory.
```
>You chose multi-bit response, cyclic APUF with a 45 bit Challenge vector. Your verilog files have been generated in the current directory.
```

## C. Citation
```
@INPROCEEDINGS{CycPUF,
  author={Dominguez, Michael and Rezaei, Amin},
  booktitle={2024 Design, Automation & Test in Europe Conference & Exhibition (DATE)}, 
  title={CycPUF: Cyclic Physical Unclonable Function}, 
  year={2024},
  volume={},
  number={},
  pages={1-6},
  doi={}
}

