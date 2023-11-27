%% [5] - LIVER COMPARTMENT
function [F5,P5,U5] = liver(t,tstart,y,WR,GIR,MR,c0)
    
    %Initialize
    ptemp = zeros(22,1);
    utemp = zeros(22,1);

    %Assign parameters to estimate
    lambda4  = c0(33); alpha4  = c0(34);
    lambda5  = c0(35); alpha5  = c0(36);
    lambda6  = c0(37); alpha6  = c0(38);
    lambda8  = c0(39); alpha8  = c0(40); 
    lambda15 = c0(41); alpha15 = c0(42);
    
    %Vmax values
    Vmax(1) = 0.765;
    Vmax(2) = 0.68;
    Vmax(3) = 5.44;
    Vmax(4) = 7.44;
    Vmax(5) = 2.08;
    Vmax(6) = 1.80;
    Vmax(7) = 0.40;
    Vmax(8) = 3.84;
    Vmax(9) = 0.84;
    Vmax(10) = 1.92;
    Vmax(11) = 0.576;
    Vmax(12) = 0.0;
    Vmax(13) = 0.444;
    Vmax(14) = 0.0;
    Vmax(15) = 0.64;
    Vmax(16) = 0.01;
    Vmax(17) = 1.088;
    Vmax(18) = 0.896;
    Vmax(19) = 0.008;
    Vmax(20) = 0.8;
    Vmax(21) = 15.62;
    Vmax(22) = 22.18;
    Vmax(23) = 0.0;
    Vmax(24) = 0.0;
    Vmax(25) = MR(5)*2.0;

    if (t>tstart) && (WR>0) 
        Vmax(4)=Vmax(4)*(1.0+lambda4*GIR^2.0/(alpha4+GIR^2.0));
        Vmax(5)=Vmax(5)*(1.0+lambda5*GIR^2.0/(alpha5+GIR^2.0));
        Vmax(6)=Vmax(6)*(1.0+lambda6*GIR^2.0/(alpha6+GIR^2.0));
        Vmax(8)=Vmax(8)*(1.0+lambda8*GIR^2.0/(alpha8+GIR^2.0));
        Vmax(15)=Vmax(15)*(1.0+lambda15*GIR^2.0/(alpha15+GIR^2.0));
    end 

    %Km values
    Km(1) = 10.0;  %GLC
    Km(2) = 0.37;  %PYR
    Km(3) = 0.82;  %LAC
    Km(4) = 0.23;  %ALA
    Km(5) = 0.07;  %GLR
    Km(6) = 0.57;  %FFA
    Km(7) = 2.93;  %TGL
    Km(8) = 7.0e-4;%O2
    Km(9) = 15.43; %CO2
    Km(10) = 0.2;  %G6P
    Km(11) = 417;  %GLY
    Km(12) = 0.11; %GAP
    Km(13) = 0.24; %GRP
    Km(14) = 0.035;%ACoA
    Km(15) = 0.14; %CoA
    Km(16) = 0.45; %NAD+
    Km(17) = 0.05; %NADH
    Km(18) = 2.74; %ATP
    Km(19) = 1.22; %ADP
    Km(20) = 4.60; %Pi
    Km(21) = 0.1;  %PCR
    Km(22) = 0.1;  %CR
    Km(23) = Km(16)/Km(17); %NAD/NADH
    Km(24) = Km(17)/Km(16); %NADH/NAD
    Km(25) = Km(18)/Km(19); %ATP/ADP
    Km(26) = Km(19)/Km(18); %ADP/ATP 

    [F5,P5,U5] = callflux(y,Vmax,Km,ptemp,utemp,5);

end