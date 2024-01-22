%% [4] - GI COMPARTMENT
function [F4,P4,U4] = gi(t,tstart,y,WR,MR,GIR,epi,epi0,c0,sex)
    
    %Initialize
    ptemp = zeros(22,1);
    utemp = zeros(22,1);

    %Assign parameters to estimate
    lambda19_gir = c0(29); alpha19_gir  = c0(30);
    lambda19_epi = c0(31); alpha19_epi  = c0(32);
    
    %Vmax values
    Vmax(1) = 0.167;
    Vmax(2) = 0.304;
    Vmax(3) = 2.432;
    Vmax(4) = 0.0;
    Vmax(5) = 0.0;
    Vmax(6) = 0.0;
    Vmax(7) = 0.0;
    Vmax(8) = 0.0;
    Vmax(9) = 0.8;
    Vmax(10) = 0.8;
    Vmax(11) = 0.0;
    Vmax(12) = 0.0;
    Vmax(13) = 0.0;
    Vmax(14) = 0.0;
    Vmax(15) = 0.0;
    Vmax(16) = 1.216;
    Vmax(17) = 0.0;
    Vmax(18) = 0.0;
    Vmax(19) = 0.08;
    Vmax(20) = 0.0;
    Vmax(21) = 2.432;
    Vmax(22) = 3.653;
    Vmax(23) = 8.0;
    Vmax(24) = 8.0;
    Vmax(25) = MR(4)*2.0;

    if (t>tstart) && (WR>0)
        Vmax(19)=Vmax(19)*(1.0+(lambda19_gir*GIR^2.0/(alpha19_gir+GIR^2.0)) + (lambda19_epi*(epi-epi0)^2.0/(alpha19_epi+(epi-epi0)^2.0)));
    end 

    %Km values
    Km(1) = 0.1;    %GLC
    Km(2) = 0.2;    %PYR
    Km(3) = 3.88;   %LAC
    Km(4) = 0.1;    %ALA
    Km(5) = 0.015;  %GLR
    Km(6) = 0.021;  %FFA
    Km(7) = 450.0;  %TGL
    Km(8) = 7.0e-4; %O2
    Km(9) = 15.43;  %CO2
    Km(10) = 0.17;  %G6P
    Km(11) = 33.0;  %GLY
    Km(12) = 0.01;  %GAP
    Km(13) = 0.29;  %GRP
    Km(14) = 0.0012;%ACoA
    Km(15) = 0.012; %CoA
    Km(16) = 0.4;   %NAD+
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

    [F4,P4,U4] = callflux(y,Vmax,Km,ptemp,utemp,4);

end