# Turbo Encoder
## Information
### Key specifications:
- Rate = 1/3
- This code is made using the following building blocks:
  - [Recursive Systematic Convolutional Encoder](https://github.com/ishcha/Implementation-of-capacity-approaching-error-control-codes-in-FPGA/tree/master/Convolutional_Codes_Encoder/VHDL%20Codes)
  - [S Interleaver](https://github.com/ishcha/Implementation-of-capacity-approaching-error-control-codes-in-FPGA/tree/master/Turbo-Encoder/Interleaver)
- The first bit is the systematic bit. 
- This code is customized to take inputs from Vivado VIO (Virtual Input Output).
  - The input of the code is the output of VIO. 
  - The output of the code is the input of VIO. 
  - It forms the interface between the input and the code and takes the input to the code. It conveys the output of the code to the external display.
  - It is an IP of Vivado.
- _Test bench_ for the code is also provided. 
  - It is used to test the code under its current specifications. 
  
## Comments
I warmly welcome any suggestions and comments about these codes. To raise any concerns, kindly [mail](ee3180614@iitd.ac.in) me.  
