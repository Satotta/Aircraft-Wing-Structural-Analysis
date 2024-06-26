function [name, PID, dataOut1, dataOut2] = Wing_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (2) Wing Analysis
% +
% +  Title:   Wing_Analysis_Function
% +  Author:  Miles Puchner
% +  PID:     A17567935
% +  Revised: 03/05/2024
% +
% +  This function is the primary analysis function for the wing analysis 
% +  program.  All of the input data is brought into the function using 
% +  "dataIn". Next all the calculations are performed.  Finally, the 
% +  calculated results are written to "dataOut1" and "dataOut2", where 
% +  these two data sets are sent to the main program (p-code) where it is 
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF WING ANALYSIS
% +
% +  A) SECTION PROPERTIES
% +     A.1) Modulus Weighted Section Properties (yc, zc, EA, EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +     A.3) Shear Center Location (ysc, zsc)
% +     A.4) Total Half Span Wing Weight (lb)
% +
% +  B) LOADS
% +     B.1) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.2) Wing Root Reactions - Shear, Torque, and Moment 
% +     B.3) Distributed Wing Internal Shear, Bend Moments, Torque
% +
% +  C) INTERNAL STRESSES
% +     C.1) Wing Root Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Wing Axial Stress (sxx) Plot
% +     C.4) Distributed Wing Shear Stress (tau) Plot
% +
% +  D) WING TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES
% +     D.1) Distributed Wing Y-direction (Drag ) Displacement 
% +     D.2) Distributed Wing Z-direction (Lift ) Displacement 
% +     D.3) Distributed Wing Twist Rotation
% +     D.4) Distributed Wing Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data Array: dataIn (65)
% +     dataIn(01):     Number of Output Plot Data Points
% +     dataIn(02):     Wing Length (inch)
% +     dataIn(03):     Wing Chord (inch)
% +     dataIn(04):     Maximum Wing Thickness (inch)
% +     dataIn(05):     Secondary Structure Added Wing Weight (%)
% +     dataIn(06):     Wing Skin Thickness (inch)
% +     dataIn(07):     Wing Skin Weight Density (lb/in^3)
% +     dataIn(08):     Skin Material Shear Modulus (Msi)
% +     dataIn(09):     Skin Material Yield Strength - Shear (Ksi)
% +     dataIn(10):     Skin Material Ultimate Strength - Shear (Ksi)
% +     dataIn(11):     Stringer (#1) y-location (inch)
% +     dataIn(12):     Stringer (#1) Cross-Section Area (inch^2)
% +     dataIn(13):     Stringer (#1) Iyy Inertia about y-axis (inch^4)
% +     dataIn(14):     Stringer (#1) Izz Inertia about z-axis (inch^4)
% +     dataIn(15):     Stringer (#1) Iyz Product of Inertia (inch^4)
% +     dataIn(16):     Stringer (#1) Weight Density (lb/in^3)
% +     dataIn(17):     Stringer (#1) Material Young’s Modulus (Msi)
% +     dataIn(18):     Stringer (#1) Yield Strength - Tension (Ksi)
% +     dataIn(19):     Stringer (#1) Ultimate Strength - Tension (Ksi)
% +     dataIn(20):     Stringer (#1) Yield Strength - Compression (Ksi)
% +     dataIn(21):     Stringer (#1) Ultimate Strength - Compression (Ksi)
% +     dataIn(22):     Stringer (#2) y-location (inch)
% +     dataIn(23):     Stringer (#2) Cross-Section Area (inch^2)
% +     dataIn(24):     Stringer (#2) Iyy Inertia about y-axis (inch^4)
% +     dataIn(25):     Stringer (#2) Izz Inertia about z-axis (inch^4)
% +     dataIn(26):     Stringer (#2) Iyz Product of Inertia (inch^4)
% +     dataIn(27):     Stringer (#2) Weight Density (lb/in^3)
% +     dataIn(28):     Stringer (#2) Material Young’s Modulus (Msi)
% +     dataIn(29):     Stringer (#2) Yield Strength - Tension (Ksi)
% +     dataIn(30):     Stringer (#2) Ultimate Strength - Tension (Ksi)
% +     dataIn(31):     Stringer (#2) Yield Strength - Compression (Ksi)
% +     dataIn(32):     Stringer (#2) Ultimate Strength - Compression (Ksi)
% +     dataIn(33):     Stringer (#3) y-location (inch)
% +     dataIn(34):     Stringer (#3) Cross-Section Area (inch^2)
% +     dataIn(35):     Stringer (#3) Iyy Inertia about y-axis (inch^4)
% +     dataIn(36):     Stringer (#3) Izz Inertia about z-axis (inch^4)
% +     dataIn(37):     Stringer (#3) Iyz Product of Inertia (inch^4)
% +     dataIn(38):     Stringer (#3) Weight Density (lb/in^3)
% +     dataIn(39):     Stringer (#3) Material Young’s Modulus (Msi)
% +     dataIn(40):     Stringer (#3) Yield Strength - Tension (Ksi)
% +     dataIn(41):     Stringer (#3) Ultimate Strength - Tension (Ksi)
% +     dataIn(42):     Stringer (#3) Yield Strength - Compression (Ksi)
% +     dataIn(43):     Stringer (#3) Ultimate Strength - Compression (Ksi)
% +     dataIn(44):     Stringer (#4) y-location (inch)
% +     dataIn(45):     Stringer (#4) Cross-Section Area (inch^2)
% +     dataIn(46):     Stringer (#4) Iyy Inertia about y-axis (inch^4)
% +     dataIn(47):     Stringer (#4) Izz Inertia about z-axis (inch^4)
% +     dataIn(48):     Stringer (#4) Iyz Product of Inertia (inch^4)
% +     dataIn(49):     Stringer (#4) Weight Density (lb/in^3)
% +     dataIn(50):     Stringer (#4) Material Young’s Modulus (Msi)
% +     dataIn(51):     Stringer (#4) Yield Strength - Tension (Ksi)
% +     dataIn(52):     Stringer (#4) Ultimate Strength - Tension (Ksi)
% +     dataIn(53):     Stringer (#4) Yield Strength - Compression (Ksi)
% +     dataIn(54):     Stringer (#4) Ultimate Strength - Compression (Ksi)
% +     dataIn(55):     Safety Factor - Yield
% +     dataIn(56):     Safety Factor - Ultimate
% +     dataIn(57):     Aircraft Load Factor
% +     dataIn(58):     Drag Distribution - Constant (lb/in)
% +     dataIn(59):     Drag Distribution - rth order (lb/in)
% +     dataIn(60):     Drag Distribution - polynomial order
% +     dataIn(61):     Lift Distribution - Constant (lb/in)
% +     dataIn(62):     Lift Distribution - 2nd Order (lb/in)
% +     dataIn(63):     Lift Distribution - 4th Order (lb/in)
% +     dataIn(64):     Twist Moment Distribution - Constant (lb-in/in)
% +     dataIn(65):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +   Name:             Name of author of this analysis function           
% +   PID:              UCSD Student ID number of author
% +   dataOut1:         Packed calculated output variable data
% +     dataOut1(01):   Modulus Weighted Centroid y-direction (inch)
% +     dataOut1(02):   Modulus Weighted Centroid z-direction (inch)
% +     dataOut1(03):   Cross-Section Weight rhoA (lb/in)
% +     dataOut1(04):   Axial   Stiffness EA   (lb)
% +     dataOut1(05):   Bending Stiffness EIyy (lb-in^2)   
% +     dataOut1(06):   Bending Stiffness EIzz (lb-in^2)   
% +     dataOut1(07):   Bending Stiffness EIyz (lb-in^2)   
% +     dataOut1(08):   Torsion Stiffness GJ   (lb-in^2)
% +     dataOut1(09):   Shear Center, y-direction (inch)
% +     dataOut1(10):   Shear Center, z-direction (inch)
% +     dataOut1(11):   Total Half-Span Wing Weight including added weight factor (lb)
% +     dataOut1(12):   Root Internal Force - X Direction (lb)
% +     dataOut1(13):   Root Internal Force - Y Direction (lb)
% +     dataOut1(14):   Root Internal Force - Z Direction (lb)
% +     dataOut1(15):   Root Internal Moment - about X Direction (lb-in)
% +     dataOut1(16):   Root Internal Moment - about Y Direction (lb-in)
% +     dataOut1(17):   Root Internal Moment - about Z Direction (lb-in)
% +     dataOut1(18):   Stringer (#1) Calculated Axial Stress (lb/in^2)
% +     dataOut1(19):   Stringer (#1) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(20):   Stringer (#1) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(21):   Stringer (#1) Margin of Safety
% +     dataOut1(22):   Stringer (#2) Calculated Axial Stress (lb/in^2)
% +     dataOut1(23):   Stringer (#2) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(24):   Stringer (#2) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(25):   Stringer (#2) Margin of Safety
% +     dataOut1(26):   Stringer (#3) Calculated Axial Stress (lb/in^2)
% +     dataOut1(27):   Stringer (#3) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(28):   Stringer (#3) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(29):   Stringer (#3) Margin of Safety
% +     dataOut1(30):   Stringer (#4) Calculated Axial Stress (lb/in^2)
% +     dataOut1(31):   Stringer (#4) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(32):   Stringer (#4) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(33):   Stringer (#4) Margin of Safety
% +     dataOut1(34):   Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
% +     dataOut1(35):   Skin Panel (1.2) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(36):   Skin Panel (1.2) Margin of Safety
% +     dataOut1(37):   Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
% +     dataOut1(38):   Skin Panel (2.3) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(39):   Skin Panel (2.3) Margin of Safety
% +     dataOut1(40):   Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
% +     dataOut1(41):   Skin Panel (3.4) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(42):   Skin Panel (3.4) Margin of Safety
% +     dataOut1(43):   Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
% +     dataOut1(44):   Skin Panel (4.1) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(45):   Skin Panel (4.1) Margin of Safety
% +     dataOut1(46):   Tip Displacement  - Y Direction (inch)
% +     dataOut1(47):   Tip Displacement  - Z Direction (inch)
% +     dataOut1(48):   Tip Twist (degree)
% +     dataOut1(49):   Tip Bending Slope (dv/dx) (inch/inch)
% +     dataOut1(50):   Tip Bending Slope (dw/dx) (inch/inch)
% +
% +   dataOut2:         Packed calculated output plot data
% +     column( 1):     X direction coordinate (inch)
% +     column( 2):     Applied distributed drag force (lb/in)   
% +     column( 3):     Applied distributed lift force (lb/in)   
% +     column( 4):     Applied distributed torque (lb-in/in)   
% +     column( 5):     Internal shear force  - Vy (lb)   
% +     column( 6):     Internal shear force  - Vz (lb)   
% +     column( 7):     Internal axial torque - Mx (lb-in)
% +     column( 8):     Internal bending moment - My (lb-in)
% +     column( 9):     Internal bending moment - Mz (lb-in)
% +     column(10):     Stringer (#1) Axial Stress (lb/in^2) 
% +     column(11):     Stringer (#2) Axial Stress (lb/in^2) 
% +     column(12):     Stringer (#3) Axial Stress (lb/in^2) 
% +     column(13):     Stringer (#4) Axial Stress (lb/in^2) 
% +     column(14):     Skin Panel (1.2) Shear Stress (lb/in^2) 
% +     column(15):     Skin Panel (2.3) Shear Stress (lb/in^2) 
% +     column(16):     Skin Panel (3.4) Shear Stress (lb/in^2) 
% +     column(17):     Skin Panel (4.1) Shear Stress (lb/in^2)
% +     column(18):     Displacement - Y Direction (inch) 
% +     column(19):     Displacement - z Direction (inch) 
% +     column(20):     Twist (degree)
% +     column(21):     Bending Slope (dv/dx) (inch/inch)
% +     column(22):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Wwrite User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (1) Unpack Input Data and Write User Name and PID')

   nplot    = dataIn( 1);   % number of output plot data points
   Lo       = dataIn( 2);   % Wing Length (inch)
   Co       = dataIn( 3);   % Wing Chord (inch)
   tmax     = dataIn( 4);   % Maximum Wing Thickness (inch)
   Kaw      = dataIn( 5);   % Secondary Structure Added Weight (%)
   to_sk    = dataIn( 6);   % Wing Skin Thickness (inch)
   rho_sk   = dataIn( 7);   % Wing Skin Weight Density (lb/inch^3)
   Go_sk    = dataIn( 8);   % Skin Material Shear Modulus (Msi)
   Sys_sk   = dataIn( 9);   % Skin Material Yield Shear Strength (Ksi)
   Sus_sk   = dataIn(10);   % Skin Material Ultimate Shear Strength (Ksi)
   yo_str1  = dataIn(11);   % Stringer 1 y-location (inch)
   A_str1   = dataIn(12);   % Stringer 1 Cross-Section Area (inch^2)
   Iyy_str1 = dataIn(13);   % Stringer 1 Iyy Inertia about the y-axis (inch^4)
   Izz_str1 = dataIn(14);   % Stringer 1 Izz Inertia about the z-axis (inch^4)
   Iyz_str1 = dataIn(15);   % Stringer 1 Iyz Product of Inertia (inch^4)
   rho_str1 = dataIn(16);   % Stringer 1 Wing Skin Weight Density (lb/inch^3)
   Eo_str1  = dataIn(17);   % Stringer 1 Material Young's Modulus (Msi)
   Syt_str1 = dataIn(18);   % Stringer 1 Material Yield Strength    - Tension (Ksi)
   Sut_str1 = dataIn(19);   % Stringer 1 Material Ultimate Strength - Tension (Ksi)
   Syc_str1 = dataIn(20);   % Stringer 1 Material Yield Strength    - Compression (Ksi)
   Suc_str1 = dataIn(21);   % Stringer 1 Material Ultimate Strength - Compression (Ksi)
   yo_str2  = dataIn(22);   % Stringer 2 y-location (inch)
   A_str2   = dataIn(23);   % Stringer 2 Cross-Section Area (inch^2)
   Iyy_str2 = dataIn(24);   % Stringer 2 Iyy Inertia about the y-axis (inch^4)
   Izz_str2 = dataIn(25);   % Stringer 2 Izz Inertia about the z-axis (inch^4)
   Iyz_str2 = dataIn(26);   % Stringer 2 Iyz Product of Inertia (inch^4)
   rho_str2 = dataIn(27);   % Stringer 2 Wing Skin Weight Density (lb/inch^3)
   Eo_str2  = dataIn(28);   % Stringer 2 Material Young's Modulus (Msi)
   Syt_str2 = dataIn(29);   % Stringer 2 Material Yield Strength    - Tension (Ksi)
   Sut_str2 = dataIn(30);   % Stringer 2 Material Ultimate Strength - Tension (Ksi)
   Syc_str2 = dataIn(31);   % Stringer 2 Material Yield Strength    - Compression (Ksi)
   Suc_str2 = dataIn(32);   % Stringer 2 Material Ultimate Strength - Compression (Ksi)
   yo_str3  = dataIn(33);   % Stringer 3 y-location (inch)
   A_str3   = dataIn(34);   % Stringer 3 Cross-Section Area (inch^2)
   Iyy_str3 = dataIn(35);   % Stringer 3 Iyy Inertia about the y-axis (inch^4)
   Izz_str3 = dataIn(36);   % Stringer 3 Izz Inertia about the z-axis (inch^4)
   Iyz_str3 = dataIn(37);   % Stringer 3 Iyz Product of Inertia (inch^4)
   rho_str3 = dataIn(38);   % Stringer 3 Wing Skin Weight Density (lb/inch^3)
   Eo_str3  = dataIn(39);   % Stringer 3 Material Young's Modulus (Msi)
   Syt_str3 = dataIn(40);   % Stringer 3 Material Yield Strength    - Tension (Ksi)
   Sut_str3 = dataIn(41);   % Stringer 3 Material Ultimate Strength - Tension (Ksi)
   Syc_str3 = dataIn(42);   % Stringer 3 Material Yield Strength    - Compression (Ksi)
   Suc_str3 = dataIn(43);   % Stringer 3 Material Ultimate Strength - Compression (Ksi)
   yo_str4  = dataIn(44);   % Stringer 4 y-location (inch)
   A_str4   = dataIn(45);   % Stringer 4 Cross-Section Area (inch^2)
   Iyy_str4 = dataIn(46);   % Stringer 4 Iyy Inertia about the y-axis (inch^4)
   Izz_str4 = dataIn(47);   % Stringer 4 Izz Inertia about the z-axis (inch^4)
   Iyz_str4 = dataIn(48);   % Stringer 4 Iyz Product of Inertia (inch^4)
   rho_str4 = dataIn(49);   % Stringer 4 Wing Skin Weight Density (lb/inch^3)
   Eo_str4  = dataIn(50);   % Stringer 4 Material Young's Modulus (Msi)
   Syt_str4 = dataIn(51);   % Stringer 4 Material Yield Strength    - Tension (Ksi)
   Sut_str4 = dataIn(52);   % Stringer 4 Material Ultimate Strength - Tension (Ksi)
   Syc_str4 = dataIn(53);   % Stringer 4 Material Yield Strength    - Compression (Ksi)
   Suc_str4 = dataIn(54);   % Stringer 4 Material Ultimate Strength - Compression (Ksi)
   SFy      = dataIn(55);   % Safety Factor - Yield
   SFu      = dataIn(56);   % Safety Factor - Ultimate
   LF       = dataIn(57);   % Aircraft Load Factor
   py0      = dataIn(58);   % Drag Distribution - Constant (lb/in)
   pyr      = dataIn(59);   % Drag Distribution - rth order (lb/in)
   rth      = dataIn(60);   % Drag Distribution - polynomial order
   pz0      = dataIn(61);   % Lift Distribution - Constant (lb/in)
   pz2      = dataIn(62);   % Lift Distribution - 2nd Order (lb/in)
   pz4      = dataIn(63);   % Lift Distribution - 4th Order (lb/in)
   mx0      = dataIn(64);   % Twist Moment Distribution - Constant (lb-in/in)
   mx1      = dataIn(65);   % Twist Moment Distribution - 1st Order (lb-in/in)

% Define author name and PID (Write in your name and PID)    
name  = {'Miles Puchner'};
PID   = {'A17567935'};


% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
disp('     (2) Calculate the Section Properties')


% Define helpful parameters
EA = (Eo_str1*A_str1 + Eo_str2*A_str2 + Eo_str3*A_str3 + Eo_str4*A_str4)*1e6; % (lb)
zo_str1 = 0; % (in)
zo_str3 = 0; % (in)
zo_str4 = tmax/2; % (in)
zo_str2 = -zo_str4; % (in)


% Determine the modulus weighted centroid location
yc = (Eo_str1*A_str1*yo_str1 + Eo_str2*A_str2*yo_str2 + Eo_str3*A_str3*yo_str3 + Eo_str4*A_str4*yo_str4)*1e6/EA; % (in)
zc = (Eo_str1*A_str1*zo_str1 + Eo_str2*A_str2*zo_str2 + Eo_str3*A_str3*zo_str3 + Eo_str4*A_str4*zo_str4)*1e6/EA; % (in)


% Determine the moments of inertia about the centroid

    % For Stringer 1
    y_dist1 = zc - zo_str1; % (in)
    z_dist1 = yc - yo_str1; % (in)
    Iyy_str1_c = Iyy_str1 + A_str1*y_dist1^2; % (in^4)
    Izz_str1_c = Izz_str1 + A_str1*z_dist1^2; % (in^4)
    Iyz_str1_c = Iyz_str1 + A_str1*y_dist1*z_dist1; % (in^4)

    % For stringer 2
    y_dist2 = zc - zo_str2; % (in)
    z_dist2 = yc - yo_str2; % (in)
    Iyy_str2_c = Iyy_str2 + A_str2*y_dist2^2; % (in^4)
    Izz_str2_c = Izz_str2 + A_str2*z_dist2^2; % (in^4)
    Iyz_str2_c = Iyz_str2 + A_str2*y_dist2*z_dist2; % (in^4)

    % For stringer 3
    y_dist3 = zc - zo_str3; % (in)
    z_dist3 = yc - yo_str3; % (in)
    Iyy_str3_c = Iyy_str3 + A_str3*y_dist3^2; % (in^4)
    Izz_str3_c = Izz_str3 + A_str3*z_dist3^2; % (in^4)
    Iyz_str3_c = Iyz_str3 + A_str3*y_dist3*z_dist3; % (in^4)

    % For stringer 4
    y_dist4 = zc - zo_str4; % (in)
    z_dist4 = yc - yo_str4; % (in)
    Iyy_str4_c = Iyy_str4 + A_str4*y_dist4^2; % (in^4)
    Izz_str4_c = Izz_str4 + A_str4*z_dist4^2; % (in^4)
    Iyz_str4_c = Iyz_str4 + A_str4*y_dist4*z_dist4; % (in^4)


% Determine the modulus weighted moments of inertia
EIyy = (Eo_str1*Iyy_str1_c + Eo_str2*Iyy_str2_c + Eo_str3*Iyy_str3_c + Eo_str4*Iyy_str4_c)*1e6; % (lb-in^2)
EIzz = (Eo_str1*Izz_str1_c + Eo_str2*Izz_str2_c + Eo_str3*Izz_str3_c + Eo_str4*Izz_str4_c)*1e6; % (lb-in^2)
EIyz = (Eo_str1*Iyz_str1_c + Eo_str2*Iyz_str2_c + Eo_str3*Iyz_str3_c + Eo_str4*Iyz_str4_c)*1e6; % (lb-in^2)


% Determine the cross section weight
a = Co/4; % (in)
b = tmax/2; % (in)
rhoA_str = rho_str1*A_str1 + rho_str2*A_str2 + rho_str3*A_str3 + rho_str4*A_str4; % (ib/in)
S_ellipse = pi*(3*(a + b) - sqrt((3*a + b)*(a + 3*b))); % (in)
A_ell = S_ellipse/2*to_sk; % (in^2)
A_flat = 2*Co/4*to_sk; % (in^2)
A_ramp = 2*sqrt((Co/2)^2 + (tmax/2)^2)*to_sk; % (in^2)
A_sk = A_ell + A_flat + A_ramp; % (in^2)
rhoA_sk = rho_sk*A_sk; % (ib/in)
rhoA = (rhoA_str + rhoA_sk)*(1 + Kaw/100); % (lb/in)


% Determine the torsional stiffness
A_airfoil = pi*a*b/2 + tmax*Co/4 + tmax/2*Co/2; % (in^2)
S_airfoil = S_ellipse/2 + 2*Co/4 + 2*sqrt((Co/2)^2 + (tmax/2)^2); % (in)
GJ = 4*A_airfoil^2*Go_sk*to_sk/S_airfoil*1e6; % (lb-in^2)


% Determine the total half span wing weight
W_wing = rhoA*Lo; % (lb)


% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')


% Determine the root internal forces:

    % In the x direction
    Vxo = 0;

    % In the y direction
    Vyo = Lo*(py0 + pyr/(rth + 1)); % (lb)

    % In the z direction
    Vzo = Lo*(pz0 + pz2/3 + pz4/5 - LF*rhoA); % (lb)


% Determine the root internal moments

    % In the x direction
    Mxo = Lo*(mx0 + mx1/2 + LF*rhoA*(yc - Co/2) + (pz0 + pz2/3 + pz4/5)*(Co/4 - yc) + (py0 + pyr/(rth + 1))*zc);  % (lb-in)
             
    % In the y direction
    Myo = -Lo^2*(pz0/2 + pz2/4 + pz4/6 - LF*rhoA/2); % (lb-in)
    
    % In the z direction
    Mzo = Lo^2*(py0/2 + pyr/(rth + 2)); % (lb-in)



% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')


% Determine the allowable tension and compression stresses for
    
    % Stringer 1
    S_allow_T_str1 = min([ Syt_str1/SFy , Sut_str1/SFu ]); % (ksi)
    S_allow_C_str1 = -min([ abs(Syc_str1/SFy) , abs(Suc_str1/SFu) ]); % (ksi)

    % Stringer 2
    S_allow_T_str2 = min([ Syt_str2/SFy , Sut_str2/SFu ]); % (ksi)
    S_allow_C_str2 = -min([ abs(Syc_str2/SFy) , abs(Suc_str2/SFu) ]); % (ksi)

    % Stringer 3
    S_allow_T_str3 = min([ Syt_str3/SFy , Sut_str3/SFu ]); % (ksi)
    S_allow_C_str3 = -min([ abs(Syc_str3/SFy) , abs(Suc_str3/SFu) ]); % (ksi)

    % Stringer 4
    S_allow_T_str4 = min([ Syt_str4/SFy , Sut_str4/SFu ]); % (ksi)
    S_allow_C_str4 = -min([ abs(Syc_str4/SFy) , abs(Suc_str4/SFu) ]); % (ksi)


% Determine the internal stresses at the root for the each spar

    % Define the bending compliances
    kyy = EIyy/(EIyy*EIzz - EIyz^2);
    kzz = EIzz/(EIyy*EIzz - EIyz^2);
    kyz = EIyz/(EIyy*EIzz - EIyz^2);

    % Define helpful terms
    mat_str1 = Eo_str1*1e6*[1, -(yo_str1 - yc), -(zo_str1 - zc)]*[1/EA, 0, 0;
                                                                  0, kyy, -kyz;
                                                                  0, -kyz, kzz];
    mat_str2 = Eo_str2*1e6*[1, -(yo_str2 - yc), -(zo_str2 - zc)]*[1/EA, 0, 0;
                                                                  0, kyy, -kyz;
                                                                  0, -kyz, kzz];
    mat_str3 = Eo_str3*1e6*[1, -(yo_str3 - yc), -(zo_str3 - zc)]*[1/EA, 0, 0;
                                                                  0, kyy, -kyz;
                                                                  0, -kyz, kzz];
    mat_str4 = Eo_str4*1e6*[1, -(yo_str4 - yc), -(zo_str4 - zc)]*[1/EA, 0, 0;
                                                                  0, kyy, -kyz;
                                                                  0, -kyz, kzz];

    % Determine the stresses via the matrix equation
    Sxxo_str1 = mat_str1*[0; Mzo; -Myo]/1e3; % (ksi)
    Sxxo_str2 = mat_str2*[0; Mzo; -Myo]/1e3; % (ksi)
    Sxxo_str3 = mat_str3*[0; Mzo; -Myo]/1e3; % (ksi)
    Sxxo_str4 = mat_str4*[0; Mzo; -Myo]/1e3; % (ksi)


% Determine the Margin of Safety

    % For stringer 1
    if Sxxo_str1 < 0
        MS_str1 = S_allow_C_str1/Sxxo_str1 - 1;
    else
        MS_str1 = S_allow_T_str1/Sxxo_str1 - 1;
    end
    
    % For stringer 2
    if Sxxo_str2 < 0
        MS_str2 = S_allow_C_str2/Sxxo_str2 - 1;
    else
        MS_str2 = S_allow_T_str2/Sxxo_str2 - 1;
    end
    
    % For stringer 3
    if Sxxo_str3 < 0
        MS_str3 = S_allow_C_str3/Sxxo_str3 - 1;
    else
        MS_str3 = S_allow_T_str3/Sxxo_str3 - 1;
    end
    
    % For stringer 4
    if Sxxo_str4 < 0
        MS_str4 = S_allow_C_str4/Sxxo_str4 - 1;
    else
        MS_str4 = S_allow_T_str4/Sxxo_str4 - 1;
    end



% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
disp('     (5) Calculate the Data Arrays for Future Plotting')


% Define a set of xa vlues to be used in computation
x = linspace(0, Lo, nplot); % (in)


% Determine the distributed forces and moments along the wing

    % In the y direction
    py = py0 + pyr.*(x./Lo).^rth; % (lb/in)
    
    % In the z direction
    pz_lift = pz0 + pz2.*(x./Lo).^2 + pz4.*(x./Lo).^4; % (lb/in)
    pz = pz0 + pz2.*(x./Lo).^2 + pz4.*(x./Lo).^4 - LF*rhoA; % (lb/in)
    
    % In the x direction
    mx = mx0 + mx1.*x./Lo + LF.*rhoA*(yc - Co/2) + py.*zc + pz_lift.*(Co/4 - yc); % (lb-in/in)


% Determine the internal forces along the wing

    % In the y direction
    Vy = Vyo - py0.*x - pyr.*x.^(rth + 1)/(rth + 1)/Lo^rth; % (lb)
    
    % In the z direction
    Vz = Vzo - pz0.*x - pz2.*x.^3/3/Lo^2 - pz4.*x.^5/5/Lo^4 + LF*rhoA.*x; % (lb)

% Determine the internal moments along the wing

    % In the x direction
    Mx = Mxo - mx0.*x - mx1.*x.^2/2/Lo - LF*rhoA*(yc - Co/2).*x - ...
        (pz0.*x + pz2.*x.^3/3/Lo^2 + pz4.*x.^5/5/Lo^4)*(Co/4 - yc) - (py0.*x + pyr.*x.^(rth + 1)/(rth + 1)/Lo^rth)*zc; % (lb-in)
    
    % In the y direction
    My = Myo + Vzo.*x - pz0.*x.^2/2 - pz2.*x.^4/12/Lo^2 - pz4.*x.^6/30/Lo^4 + LF*rhoA.*x.^2/2; % (lb-in)
    
    % In the z direction
    Mz = Mzo - Vyo.*x + py0.*x.^2/2 + pyr.*x.^(rth + 2)/(rth + 1)/(rth + 2)/Lo^rth; % (lb-in)


% Determine the internal stresses along the wing for the each spar

    % Initialize loop variables
    Sxx_str1 = zeros(1, nplot);
    Sxx_str2 = zeros(1, nplot); 
    Sxx_str3 = zeros(1, nplot);
    Sxx_str4 = zeros(1, nplot);
    
    % Define the loop
    for i = 1:nplot
    
        % Define the axial stress via the matrix equation for each stringer
        Sxx_str1(i) = mat_str1*[0; Mz(i); -My(i)]/1e3; % (ksi)
        Sxx_str2(i) = mat_str2*[0; Mz(i); -My(i)]/1e3; % (ksi)
        Sxx_str3(i) = mat_str3*[0; Mz(i); -My(i)]/1e3; % (ksi)
        Sxx_str4(i) = mat_str4*[0; Mz(i); -My(i)]/1e3; % (ksi)
    
    end


% Determine the slopes and displacements via the derived equations

    % In the y direction
    DvDx = kyy*( Mzo.*x - Vyo.*x.^2./2 + py0.*x.^3./6 + pyr.*x.^(rth + 3)./(rth + 1)/(rth + 2)/(rth + 3)/Lo^rth )...
        + kyz*( Myo.*x + Vzo.*x.^2./2 - pz0.*x.^3./6 - pz2.*x.^5./60/Lo^2 - pz4.*x.^7./210/Lo^4 + LF*rhoA.*x.^3./6 ); % (in/in)
    
    Disp_Y = kyy*( Mzo.*x.^2./2 - Vyo.*x.^3./6 + py0.*x.^4./24 + pyr.*x.^(rth + 4)./(rth + 1)/(rth + 2)/(rth + 3)/(rth + 4)/Lo^rth )...
        + kyz*( Myo.*x.^2./2 + Vzo.*x.^3./6 - pz0.*x.^4./24 - pz2.*x.^6./360/Lo^2 - pz4.*x.^8./1680/Lo^4 + LF*rhoA.*x.^4./24 ); % (in)

    % In the z direction
    DwDx = -kzz*(  Myo.*x + Vzo.*x.^2./2 - pz0.*x.^3./6 - pz2.*x.^5./60/Lo^2 - pz4.*x.^7./210/Lo^4 + LF*rhoA.*x.^3./6 )...
        - kyz*( Mzo.*x - Vyo.*x.^2./2 + py0.*x.^3./6 + pyr.*x.^(rth + 3)./(rth + 1)/(rth + 2)/(rth + 3)/Lo^rth ); % (in/in)
    
    Disp_Z = -kzz*(  Myo.*x.^2./2 + Vzo.*x.^3./6 - pz0.*x.^4./24 - pz2.*x.^6./360/Lo^2 - pz4.*x.^8./1680/Lo^4 + LF*rhoA.*x.^4./24 )...
        - kyz*( Mzo.*x.^2./2 - Vyo.*x.^3./6 + py0.*x.^4./24 + pyr.*x.^(rth + 4)./(rth + 1)/(rth + 2)/(rth + 3)/(rth + 4)/Lo^rth ); % (in)


% Determine the shear stress throughout each skin section

    % Define the stringer locations relative to the modulus weighted
    % centroid
    yc_str2 = yo_str2 - yc; % (in)
    yc_str3 = yo_str3 - yc; % (in)
    yc_str4 = yo_str4 - yc; % (in)
    zc_str2 = zo_str2 - zc; % (in)
    zc_str3 = zo_str3 - zc; % (in)
    zc_str4 = zo_str4 - zc; % (in)
    
    % Define helpful terms
    EA_str2 = Eo_str2*A_str2*1e6; % (lb)
    EA_str3 = Eo_str3*A_str3*1e6; % (lb)
    EA_str4 = Eo_str4*A_str4*1e6; % (lb)

    % Define the cross sectional area segments about an arbitrary point
    % located at (Co/4, 0)
    A_12 = pi*a*b/4 + 1/2*tmax/2*(yo_str2 - Co/4); % (in^2)
    A_23 = 1/2*tmax/2*Co/2 + 1/2*tmax/2*(yo_str2 - Co/4) + tmax/2*(Co/2 - yo_str2); % (in^2)
    A_34 = 1/2*tmax/2*Co/2 + 1/2*tmax/2*(yo_str4 - Co/4) + tmax/2*(Co/2 - yo_str4); % (in^2)
    A_41 = pi*a*b/4 + 1/2*tmax/2*(yo_str4 - Co/4); % (in^2)
    A_tot = A_12 + A_23 + A_34 + A_41; % in^2

    % Define the new X direction moment about the arbitrary point
    Mxo_A = Lo*(mx0 + mx1/2 - LF*rhoA*Co/4); % (lb-in)
    Mx_A = Mxo_A - mx0.*x - mx1.*x.^2/2/Lo + LF*rhoA*Co/4.*x; % (lb-in)
    
    % Define helpful matrices to be used in computation
    mat_A = inv([2*A_12, 2*A_23, 2*A_34, 2*A_41; ...
                   -1,     1,       0,     0; ...
                    0,    -1,       1,     0; ...
                    0,     0,      -1,     1]);

    mat_X = [1; 0; 0; 0];

    mat_Y = [               0;
        EA_str2*(kyz*zc_str2 - kyy*yc_str2);
        EA_str3*(kyz*zc_str3 - kyy*yc_str3);
        EA_str4*(kyz*zc_str4 - kyy*yc_str4)]; 

    mat_Z = [               0;
        EA_str2*(kyz*yc_str2 - kzz*zc_str2);
        EA_str3*(kyz*yc_str3 - kzz*zc_str3);
        EA_str4*(kyz*yc_str4 - kzz*zc_str4)];
    

    % Initialize loop variables
    q = zeros(4, nplot); 

    % Define the loop to determine the shear flows
    for i = 1:nplot
    
        % Define the axial stress via the matrix equation for each stringer
        q(:, i) = mat_A*(Mx_A(i)*mat_X + Vy(i)*mat_Y + Vz(i)*mat_Z); % (lb/in)
        
    end

    % Use the shear flow to determine the shear stress along each skin as a
    % function of x
    Tau_sk12 = q(1, :)./to_sk/1e3; % (ksi)
    Tau_sk23 = q(2, :)./to_sk/1e3; % (ksi)
    Tau_sk34 = q(3, :)./to_sk/1e3; % (ksi)
    Tau_sk41 = q(4, :)./to_sk/1e3; % (ksi)

    % Pull root values
    Tau_o_sk12 = Tau_sk12(1); % (ksi)
    Tau_o_sk23 = Tau_sk23(1); % (ksi)
    Tau_o_sk34 = Tau_sk34(1); % (ksi)
    Tau_o_sk41 = Tau_sk41(1); % (ksi)


% Determine the allowable shear stresses for the skin
Tau_allow_S_sk12 = min([ Sys_sk/SFy , Sus_sk/SFu ]); % (ksi)
Tau_allow_S_sk23 = Tau_allow_S_sk12; % (ksi)
Tau_allow_S_sk34 = Tau_allow_S_sk12; % (ksi)
Tau_allow_S_sk41 = Tau_allow_S_sk12; % (ksi)
    
% Determine the Margin of safety
    
    % For skin 12
    MS_sk12 = Tau_allow_S_sk12/abs(Tau_o_sk12) - 1;

    % For skin 23
    MS_sk23 = Tau_allow_S_sk23/abs(Tau_o_sk23) - 1;

    % For skin 34
    MS_sk34 = Tau_allow_S_sk34/abs(Tau_o_sk34) - 1;

    % For skin 41
    MS_sk41 = Tau_allow_S_sk41/abs(Tau_o_sk41) - 1;


% Determine the twist along the length of the wing

    % Find the length of each skin piece and place in matrix form
    S_12 = S_ellipse/4 + yo_str2 - Co/4;
    S_23 = Co/2 - yo_str2 + sqrt((tmax/2)^2 + (Co/2)^2);
    S_34 = Co/2 - yo_str4 + sqrt((tmax/2)^2 + (Co/2)^2);
    S_41 = S_ellipse/4 + yo_str4 - Co/4;
    mat_S = [S_12, S_23, S_34, S_41];

    % Define integrals of the shear and moment equations for use in twist
    % calculation
    %Vy_int = Vyo.*x - 1/2*py0.*x.^2 - 1/((rth + 1)*(rth + 2)*Lo^rth)*pyr.*x.^(rth + 2);
    Vy_int = Vyo.*x - py0.*x.^2/2 - pyr.*x.^(rth + 2)/(rth + 1)/(rth + 2)/Lo^rth;

    %Vz_int = Vzo.*x - 1/2*pz0.*x.^2 - 1/(12*Lo^2)*pz2.*x.^4 - 1/(30*Lo^4)*pz4.*x.^6 + 1/2*LF*rhoA.*x.^2;
    Vz_int = Vzo.*x - pz0.*x.^2/2 - pz2.*x.^4/12/Lo^2 - pz4.*x.^6/30/Lo^4 + LF*rhoA.*x.^2/2;

    % Mx_A_int = Mxo_A.*x - 1/2*mx0.*x.^2 - 1/(6*Lo)*mx1.*x.^3 + 1/8*LF*rhoA*Co.*x.^2;
    Mx_A_int = Mxo_A.*x - mx0.*x.^2/2 - mx1.*x.^3/6/Lo + LF*rhoA*Co/4.*x.^2/2;

    % Initialize loop variables
    Twist = zeros(1, nplot);

    % Define the loop to determine the shear flows
    for i = 1:nplot
    
        % Define the axial stress via the matrix equation for each stringer
        Twist(i) = 180/(2*pi*A_tot*Go_sk*1e6*to_sk)*mat_S*mat_A*(Mx_A_int(i)*mat_X + Vy_int(i)*mat_Y + Vz_int(i)*mat_Z); % (lb/in)
    
    end


% Determine the y position of the shear center

    % Define the position relative to the quarter chord
    ey_qc = -(mat_S*mat_A*mat_Z)/(mat_S*mat_A*mat_X); % (in)

    % Define position relative to the leading edge
    ysc = Co/4 + ey_qc; % in


% Determine the z position of the shear center

    % Define the position relative to leading edge
    zsc = (mat_S*mat_A*mat_Y)/(mat_S*mat_A*mat_X); % (in)
    


% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (50)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
disp('     (6) Pack the Calculated Data into Array: dataOut1')

     dataOut1(01) = yc;               % Modulus Weighted Centroid y-direction (inch)
     dataOut1(02) = zc;               % Modulus Weighted Centroid z-direction (inch)
     dataOut1(03) = rhoA;             % Cross-Section Weight (lb/inch)
     dataOut1(04) = EA;               % Axial   Stiffness (lb)
     dataOut1(05) = EIyy;             % Bending Stiffness (lb-in^2)   
     dataOut1(06) = EIzz;             % Bending Stiffness (lb-in^2)   
     dataOut1(07) = EIyz;             % Bending Stiffness (lb-in^2)   
     dataOut1(08) = GJ;               % Torsion Stiffness (lb-in^2)
     dataOut1(09) = ysc;              % Shear Center y-direction (inch)
     dataOut1(10) = zsc;              % Shear Center z-direction (inch)
     dataOut1(11) = W_wing;           % Total Half-Span Wing Weight (lb)
     dataOut1(12) = Vxo;              % Root Internal Force - X Direction (lb)
     dataOut1(13) = Vyo;              % Root Internal Force - Y Direction (lb)
     dataOut1(14) = Vzo;              % Root Internal Force - Z Direction (lb)
     dataOut1(15) = Mxo;              % Root Internal Moment - about X Direction (lb-in)
     dataOut1(16) = Myo;              % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(17) = Mzo;              % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(18) = Sxxo_str1;         % Stringer (#1) Calculated Axial Stress (lb/in^2)
     dataOut1(19) = S_allow_T_str1;   % Stringer (#1) Allowable Stress - Tension (lb/in^2)
     dataOut1(20) = S_allow_C_str1;   % Stringer (#1) Allowable Stress - Compression (lb/in^2)
     dataOut1(21) = MS_str1;          % Stringer (#1) Margin of Safety
     dataOut1(22) = Sxxo_str2;         % Stringer (#2) Calculated Axial Stress (lb/in^2)
     dataOut1(23) = S_allow_T_str2;   % Stringer (#2) Allowable Stress - Tension (lb/in^2)
     dataOut1(24) = S_allow_C_str2;   % Stringer (#2) Allowable Stress - Compression (lb/in^2)
     dataOut1(25) = MS_str2;          % Stringer (#2) Margin of Safety
     dataOut1(26) = Sxxo_str3;         % Stringer (#3) Calculated Axial Stress (lb/in^2)
     dataOut1(27) = S_allow_T_str3;   % Stringer (#3) Allowable Stress - Tension (lb/in^2)
     dataOut1(28) = S_allow_C_str3;   % Stringer (#3) Allowable Stress - Compression (lb/in^2)
     dataOut1(29) = MS_str3;          % Stringer (#3) Margin of Safety
     dataOut1(30) = Sxxo_str4;         % Stringer (#4) Calculated Axial Stress (lb/in^2)
     dataOut1(31) = S_allow_T_str4;   % Stringer (#4) Allowable Stress - Tension (lb/in^2)
     dataOut1(32) = S_allow_C_str4;   % Stringer (#4) Allowable Stress - Compression (lb/in^2)
     dataOut1(33) = MS_str4;          % Stringer (#4) Margin of Safety
     dataOut1(34) = Tau_o_sk12;       % Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
     dataOut1(35) = Tau_allow_S_sk12; % Skin Panel (1.2) Allowable Shear Stress  (lb/in^2)
     dataOut1(36) = MS_sk12;          % Skin Panel (1.2) Margin of Safety
     dataOut1(37) = Tau_o_sk23;       % Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
     dataOut1(38) = Tau_allow_S_sk23; % Skin Panel (2.3) Allowable Shear Stress  (lb/in^2)
     dataOut1(39) = MS_sk23;          % Skin Panel (2.3) Margin of Safety
     dataOut1(40) = Tau_o_sk34;       % Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
     dataOut1(41) = Tau_allow_S_sk34; % Skin Panel (3.4) Allowable Shear Stress  (lb/in^2)
     dataOut1(42) = MS_sk34;          % Skin Panel (3.4) Margin of Safety
     dataOut1(43) = Tau_o_sk41;       % Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
     dataOut1(44) = Tau_allow_S_sk41; % Skin Panel (4.1) Allowable Shear Stress  (lb/in^2)
     dataOut1(45) = MS_sk41;          % Skin Panel (4.1) Margin of Safety
     dataOut1(46) = Disp_Y(nplot);    % Tip Diplacement - Y Direction (inch)
     dataOut1(47) = Disp_Z(nplot);    % Tip Diplacement - Z Direction (inch)
     dataOut1(48) = Twist(nplot);     % Tip Twist (degree)
     dataOut1(49) = DvDx(nplot);      % Tip Bending Slope (dv/dx) (inch/inch)
     dataOut1(50) = DwDx(nplot);      % Tip Bending Slope (dw/dx) (inch/inch)

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2" 
% .                matrix size: (nplot,22)  
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')

   for i = 1:nplot;
     dataOut2(i, 1) = x(i);           % x-location (inch)
     dataOut2(i, 2) = py(i);          % drag force (lb/in)
     dataOut2(i, 3) = pz(i);          % lift force (lb/in)
     dataOut2(i, 4) = mx(i);          % distributed torque (lb-in/in)
     dataOut2(i, 5) = Vy(i);          % Internal shear force - Vy (lb)
     dataOut2(i, 6) = Vz(i);          % Internal shear force - Vz (lb)
     dataOut2(i, 7) = Mx(i);          % Internal axial force - Mx (lb-in)
     dataOut2(i, 8) = My(i);          % Internal shear force - My (lb-in)
     dataOut2(i, 9) = Mz(i);          % Internal shear force - Mz (lb-in)
     dataOut2(i,10) = Sxx_str1(i);    % Stringer (#1) Axial Stress (lb/in^2) 
     dataOut2(i,11) = Sxx_str2(i);    % Stringer (#2) Axial Stress (lb/in^2) 
     dataOut2(i,12) = Sxx_str3(i);    % Stringer (#3) Axial Stress (lb/in^2) 
     dataOut2(i,13) = Sxx_str4(i);    % Stringer (#4) Axial Stress (lb/in^2) 
     dataOut2(i,14) = Tau_sk12(i);    % Skin Panel (1.2) Shear Stress (lb/in^2) 
     dataOut2(i,15) = Tau_sk23(i);    % Skin Panel (2.3) Shear Stress (lb/in^2) 
     dataOut2(i,16) = Tau_sk34(i);    % Skin Panel (3.4) Shear Stress (lb/in^2) 
     dataOut2(i,17) = Tau_sk41(i);    % Skin Panel (4.1) Shear Stress (lb/in^2)
     dataOut2(i,18) = Disp_Y(i);      % Displacement - Y Direction (inch)
     dataOut2(i,19) = Disp_Z(i);      % Displacement - Z Direction (inch)
     dataOut2(i,20) = Twist(i);       % Wing Twist (degree)
     dataOut2(i,21) = DvDx(i);        % Bending Slope (dv/dx) (inch/inch)
     dataOut2(i,22) = DwDx(i);        % Bending Slope (dw/dx) (inch/inch)
   
   end;
   
end

%  End of Function: Wing_Analysis_Function
%  ------------------------------------------------------------------------