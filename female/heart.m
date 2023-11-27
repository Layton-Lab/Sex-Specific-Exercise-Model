%% [2] - HEART COMPARTMENT

function [F2,P2,U2] = heart(t,tstart,y,WR,epi,epi0,MR,RMR,c0)

    %Initialize
    ptemp = zeros(22,1);
    utemp = zeros(22,1);

    %Assign parameters to estimate
    lambda1  = c0(13); alpha1  = c0(14);
    lambda17 = c0(15); alpha17 = c0(16);
    lambda19 = c0(17); alpha19 = c0(18);

    %Vmax value
    Vmax(1) = 0.088;
    Vmax(2) = 0.16;
    Vmax(3) = 1.28;
    Vmax(4) = 0.0;
    Vmax(5) = 0.0;
    Vmax(6) = 0.0;
    Vmax(7) = 0.16;
    Vmax(8) = 0.32;
    Vmax(9) = 0.352;
    Vmax(10) = 0.512;
    Vmax(11) = 0.016;
    Vmax(12) = 0.0;
    Vmax(13) = 0.0;
    Vmax(14) = 0.0;
    Vmax(15) = 0.0;
    Vmax(16) = 0.96;
    Vmax(17) = 0.28;
    Vmax(18) = 0.0;
    Vmax(19) = 0.008;
    Vmax(20) = 0.096;
    Vmax(21) = 6.4;
    Vmax(22) = 9.327;
    Vmax(23) = 8.0;
    Vmax(24) = 8.0;
    Vmax(25) = MR(2)*2.0;

    if (t>tstart) && (WR>0) 
        Vmax(1) = Vmax(1)*(1.0+lambda1*(epi-epi0)^2.0/(alpha1+(epi-epi0)^2.0));
        Vmax(2) = Vmax(2)*RMR; 
        Vmax(3) = Vmax(3)*RMR; 
        Vmax(8) = Vmax(8)*RMR; 
        Vmax(16)= Vmax(16)*RMR;  
        Vmax(17)= Vmax(17)*(1.0+lambda17*(epi-epi0)^2.0/(alpha17+(epi-epi0)^2.0));
        Vmax(19)= Vmax(19)*(1.0+lambda19*(epi-epi0)^2.0/(alpha19+(epi-epi0)^2.0));
        Vmax(21)= Vmax(21)*RMR; 
        Vmax(22)= Vmax(22)*RMR; 
        % Notes: 
        % 1) RMR slowly returns to basal levels after exercise ends --> consequently, Vmax([2,3,8,16,21,22]) do too
        % 2) epinephrine also slowly returns to basal levels after exercise ends --> Vmax([1,8,14,17,19]) do too
    end

    %Km values
    Km(1) = 0.1;    %GLC
    Km(2) = 0.2;    %PYR
    Km(3) = 3.88;   %LAC
    Km(4) = 0.1;    %ALA
    Km(5) = 0.015;  %GLR
    Km(6) = 0.021;  %FFA
    Km(7) = 3.12;   %TGL
    Km(8) = 7.0e-4; %O2
    Km(9) = 20.00;  %CO2
    Km(10) = 0.17;  %G6P
    Km(11) = 33.0;  %GLY
    Km(12) = 0.01;  %GAP
    Km(13) = 0.29;  %GRP
    Km(14) = 0.0012;%ACoA
    Km(15) = 0.012; %CoA
    Km(16) = 0.40;  %NAD+
    Km(17) = 0.045; %NADH
    Km(18) = 3.4;   %ATP
    Km(19) = 0.02;  %ADP
    Km(20) = 1.66;  %Pi
    Km(21) = 8.3;   %PCR
    Km(22) = 3.5;   %CR
    Km(23) = Km(16)/Km(17); %NAD/NADH
    Km(24) = Km(17)/Km(16); %NADH/NAD
    Km(25) = Km(18)/Km(19); %ATP/ADP
    Km(26) = Km(19)/Km(18); %ADP/ATP

    [F2,P2,U2] = callflux(y,Vmax,Km,ptemp,utemp,2);

end