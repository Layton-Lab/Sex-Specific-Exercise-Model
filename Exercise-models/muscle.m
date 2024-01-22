%% [3] - MUSCLE COMPARTMENT
function [F3,P3,U3] = muscle(t,tstart,y,WR,MR,RMR,epi,epi0,c0,sex)

    %Initialize
    ptemp = zeros(22,1);
    utemp = zeros(22,1);

    %Assign parameters to estimate
    lambda1  = c0(19); alpha1  = c0(20);
    lambda8  = c0(21); alpha8  = c0(22);
    lambda14 = c0(23); alpha14 = c0(24);
    lambda17 = c0(25); alpha17 = c0(26);
    lambda19 = c0(27); alpha19 = c0(28);

    if sex == 0 %male
        lactate_muscle = 1;
    else % female
        lactate_muscle = 0.85; % >1
    end

    %Vmax values
    Vmax(1) = 0.398;
    Vmax(2) = 0.66;
    Vmax(3) = 5.28;
    Vmax(4) = 0.0;
    Vmax(5) = 0.0;
    Vmax(6) = 0.0;
    Vmax(7) = 0.5;
    Vmax(8) = 1.0;
    Vmax(9) = 14.85*lactate_muscle;
    Vmax(10) = 12.51;
    Vmax(11) = 0.508;
    Vmax(12) = 0.0;
    Vmax(13) = 0.0;
    Vmax(14) = 0.08;
    Vmax(15) = 0.0;
    Vmax(16) = 2.745;
    Vmax(17) = 0.701;
    Vmax(18) = 0.0;
    Vmax(19) = 0.26;
    Vmax(20) = 3.048;
    Vmax(21) = 9.968;
    Vmax(22) = 14.68;
    Vmax(23) = 80.0;
    Vmax(24) = 80.0;
    Vmax(25) = MR(3)*2.0;
    
    % RMR = Relative Metabolic Rate --> ATP Hydrolysis Related to Work Rate
    if (t>tstart) && (WR>0)
        Vmax(1)=Vmax(1)*(1.0+lambda1*(epi-epi0)^2.0/(alpha1+(epi-epi0)^2.0));
        Vmax(2)=Vmax(2)*RMR;
        Vmax(3)=Vmax(3)*RMR;
        Vmax(8)=Vmax(8)*RMR*(1.0+lambda8*(epi-epi0)^2.0/(alpha8+(epi-epi0)^2.0));
        Vmax(14)=Vmax(14)*(1.0+lambda14*(epi-epi0)^2.0/(alpha14+(epi-epi0)^2.0));
        Vmax(16)=Vmax(16)*RMR;
        Vmax(17)=Vmax(17)*(1.0+lambda17*(epi-epi0)^2.0/(alpha17+(epi-epi0)^2.0));
        Vmax(19)=Vmax(19)*(1.0+lambda19*(epi-epi0)^2.0/(alpha19+(epi-epi0)^2.0));
        Vmax(21)=Vmax(21)*RMR; 
        Vmax(22)=Vmax(22)*RMR; 
    end 

    %Km values
    Km(1) = 0.1;    %GLC
    Km(2) = 0.048;  %PYR
    Km(3) = 1.44;   %LAC
    Km(4) = 1.3;    %ALA
    Km(5) = 0.064;  %GLR
    Km(6) = 0.53;   %FFA
    if sex == 0 %male
        Km(7) = 14.8;   %TGL
    else % female
        Km(7) = 14.8*1.28; %TGL % Km is chosen to match the IC for TG in female; see y3(7) in call_exerciseMod 
    end
    Km(8) = 7.0e-4; %O2
    Km(9) = 15.43;  %CO2
    Km(10) = 0.24;  %G6P
    Km(11) = 95.0;  %GLY
    Km(12) = 0.08;  %GAP
    Km(13) = 0.15;  %GRP
    Km(14) = 0.0022;%ACoA
    Km(15) = 0.018; %CoA
    Km(16) = 0.45;  %NAD+
    Km(17) = 0.05;  %NADH
    Km(18) = 6.15;  %ATP
    Km(19) = 0.02;  %ADP
    Km(20) = 2.70;  %Pi
    Km(21) = 20.1;  %PCR
    Km(22) = 10.45; %CR
    Km(23) = Km(16)/Km(17); %NAD/NADH
    Km(24) = Km(17)/Km(16); %NADH/NAD
    Km(25) = Km(18)/Km(19); %ATP/ADP
    Km(26) = Km(19)/Km(18); %ADP/ATP

    [F3,P3,U3] = callflux(y,Vmax,Km,ptemp,utemp,3);

end