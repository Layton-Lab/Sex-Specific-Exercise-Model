%% [1] - BRAIN COMPARTMENT
function [F1,P1,U1] = brain(t,y,MR,sex)
    
    %Initialize
    ptemp = zeros(22,1);
    utemp = zeros(22,1);

    %Vmax values
    Vmax(1) = 0.79;
    Vmax(2) = 1.52;
    Vmax(3) = 12.16;
    Vmax(4) = 0.0;
    Vmax(5) = 0.0;
    Vmax(6) = 0.0;
    Vmax(7) = 0.012;
    Vmax(8) = 0.024;
    Vmax(9) = 2.8;
    Vmax(10) = 2.8;
    Vmax(11) = 0.0;
    Vmax(12) = 0.0;
    Vmax(13) = 0.0;
    Vmax(14) = 0.0;
    Vmax(15) = 0.0;
    Vmax(16) = 6.08;
    Vmax(17) = 0.0;
    Vmax(18) = 0.0;
    Vmax(19) = 0.0;
    Vmax(20) = 0.0;
    Vmax(21) = 12.16;
    Vmax(22) = 18.71;
    Vmax(23) = 7.44;
    Vmax(24) = 7.44;
    Vmax(25) = MR(1)*2.0;

    %Km values
    Km(1) = 0.05; %GLC
    Km(2) = 0.15; %PYR
    Km(3) = 1.45; %LAC
    Km(4) = 0.1;  %ALA
    Km(5) = 0.1;  %GLR
    Km(6) = 0.1;  %FA
    Km(7) = 0.1;  %TGL
    Km(8) = 7.0e-4; %O2
    Km(9) = 15.43; %CO2
    Km(10) = 0.16; %G6P
    Km(11) = 2.0; %GLY
    Km(12) = 0.15; %GAP
    Km(13) = 0.1; %GRP
    Km(14) = 0.0068; %ACoA
    Km(15) = 0.060; %CoA
    Km(16) = 0.064; %NAD+
    Km(17) = 0.026; %NADH
    Km(18) = 2.45; %ATP
    Km(19) = 0.54; %ADP
    Km(20) = 2.40; %Pi
    Km(21) = 4.60; %PCR
    Km(22) = 5.60; %CR
    Km(23) = Km(16)/Km(17); %NAD/NADH
    Km(24) = Km(17)/Km(16); %NADH/NAD
    Km(25) = Km(18)/Km(19); %ATP/ADP
    Km(26) = Km(19)/Km(18); %ADP/ATP

    [F1,P1,U1] = callflux(y,Vmax,Km,ptemp,utemp,1);
    
end