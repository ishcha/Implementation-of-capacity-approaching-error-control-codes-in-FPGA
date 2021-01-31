# Recursive Systematic Convolutional Encoder
## Information
This is the **VHDL code for a Binary Recursive Systematic Convolutional Encoder**. 
The specifications of this code are as follows:
- This is a _vectorized_ version of the code. 
  - It takes in a message block and gives out the codeword vector.
- This code is currently customised to 
  - A message length of 4 bits. (Constraint Length)
  - Encoder state of 2 bits. (2 D flip flops constitute the memory in the Convolutional Encoder)
  - Rate = 1/2.
- This code is customized to take inputs from Vivado VIO (Virtual Input Output).
  - The input of the code is the output of VIO. 
  - The output of the code is the input of VIO. 
  - It forms the interface between the input and the code and takes the input to the code. It conveys the output of the code to the external display.
  - It is an IP of Vivado.
- _Test bench_ for the code is also provided. 
  - It is used to test the code under its current specifications. 

## Errata
- n, r are redundant generic variables, which were in use earlier for testing purposes. 

## Comments
I warmly welcome any suggestions and comments about these codes. To raise any concerns, kindly [mail](ee3180614@iitd.ac.in) me.  
