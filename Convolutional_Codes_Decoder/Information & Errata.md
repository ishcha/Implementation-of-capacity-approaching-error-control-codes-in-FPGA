# Viterbi Decoder for Convolutional Codes
## Information 
### Key Specifications of the VHDL code
- This code is prepared for the generic length rs = 16 for the received vector. 
- This is useful for decoding a [Recursive Systematic Convolutional Encoder](https://github.com/ishcha/Implementation-of-capacity-approaching-error-control-codes-in-FPGA/tree/master/Convolutional_Codes_Encoder/VHDL%20Codes). 
- There are 2 outputs of this code:
  - The codeword after decoding
  - The corresponding message vector. 
- It follows the Viterbi Algorithm for decoding Convolutional Codes. 
- This code is customized to take inputs from Vivado VIO (Virtual Input Output).
  - The input of the code is the output of VIO. 
  - The output of the code is the input of VIO. 
  - It forms the interface between the input and the code and takes the input to the code. It conveys the output of the code to the external display.
  - It is an IP of Vivado.
- _Test bench_ for the code is also provided. 
  - It is used to test the code under its current specifications.


### Key Specifications of the C++ code
  - This code prepared for the received vector length = 14. 
  - This is useful for decoding a _Non-Recursive, Non-Systematic_ Convolutional Code. 
    - The logic of the code is based on a Convolutional Encoder which has ({v1, v2}: Codeword for one bit input, {s1, s2}: state vector, u: one bit input)
      - Codeword is given by:
        - v1 = u xor s2
        - v2 = u xor s1 xor s2
        - s1 = u
        - s2 = s1
      

## Comments
I warmly welcome any suggestions and comments about these codes. To raise any concerns, kindly [mail](ee3180614@iitd.ac.in) me.  
