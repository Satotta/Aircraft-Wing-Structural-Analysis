# Aircraft-Wing-Structural-Analysis

The following files can be broken down into 2 categories:

1) Files necessary to run the function
   * Wing_Analysis_Input.xlsx (Created by Professor John Kosmatka)
     --> neatly organizes all necessary inputs
     
   * Wing_Analysis_Output.xlsx (Created by Professor John Kosmatka)
     --> neatly organizes outputs and plots
     
   * Wing_Analysis_Main.p (Created by Professor John Kosmatka)
     --> calls the wing analysis function and does the necessary data conversion for plotting and listing in Excel
     
   * Wing_Analysis_Function.p
     --> used by the main function; simply a p-code variant of Wing_Analysis_Function.m which contains all the computation and structural analysis

2) Actual code files and proof of utility (sample inputs and outputs)
   * Wing_Analysis_Function.m
     --> contains all the computation and structural analysis code

   * Wing_Analysis_Input_AL.xlsx
     --> sample input for a wing with an aluminum spar

   * Wing_Analysis_Output_AL.xlsx
     --> sample output for a wing with an aluminum spar


To run, start MATLAB and ensure path has access to all files listed within category 1. Then type "run Wing_Analysis_Main.p"


     
