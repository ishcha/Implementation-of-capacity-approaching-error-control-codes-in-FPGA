# Viterbi Decoder for Convolutional Codes
## Information 
### Key Specifications
- This code is prepared for the generic length rs = 16 for the received vector. 
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
- The zip file contains the entire Vivado folder created on my local system in a compressed way. 

## Comments
I warmly welcome any suggestions and comments about these codes. To raise any concerns, kindly [mail](ee3180614@iitd.ac.in) me.  
