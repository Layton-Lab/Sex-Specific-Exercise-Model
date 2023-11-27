%% CALL FUNCTION
% ---------------------------------------------------------------------- 
% Main simulation code for the whole body model during exercise
% Stéphanie Abo, last updated 11/27/2023
%----------------------------------------------------------------------

close all;
clear;
clc;

%NEQ = Number of Equations 
    neq = 156;
%simulation time
    t0 = 0;
    tstart=10; % start time of exercise
    tend=70;   % end of exercise 
    tspan = t0:0.01:tend+60; % total simulation time

%SET INITIAL CONDITIONS
%Initial tissue concentrations for the substrates.
%There is one set of initial conditions for each tissue compartment. 
% The order of substrates are as follows: 
% S1 = Glucose (GLC)
% S2 = Pyruvate (PYR)
% S3 = Lactate (LAC)
% S4 = Alanine (ALA)
% S5 = Glycerol (GLR)
% S6 = Free Fatty Acid (FFA)
% S7 = Triglyceride (TG)
% S8 = O2
% S9 = CO2
% S10 = Glucose-6-Phosphate (G6P)
% S11 = Glycogen (GLY)
% S12 = Glyceraldehyde 3-Phosphate (GAP)
% S13 = Glycerol-3oPhosphate (GRP)
% S14 = Acetyl CoA (ACoA)
% S15 = CoA
% S16 = NAD+
% S17 = NADH
% S18 = ATP
% S19 = ADP
% S20 = Pi
% S21 = Phospho Creatine(PCR) 
% S22 = Creatine(CR)

%Initial arterial concentrations of substrates
    Ca0(1) = 5.0;    %GLC 
    Ca0(2) = 0.068;  %PYR 
    Ca0(3) = 0.7;    %LAC 
    Ca0(4) = 0.192;  %ALA 
    Ca0(5) = 0.07;   %GLR 
    Ca0(6) = 0.66;   %FFA 
    Ca0(7) = 0.99;   %TG 
    Ca0(8) = 8.0;    %O2 (assumed constant)
    Ca0(9) = 21.7;   %CO2 (assumed constant)
    Ca0(10:22) = 0.0;

% Initial conditions for the brain (B) compartment - y1(x)
    y10(1) = 1.12;     %GLC     
    y10(2) = 0.15;     %PYR
    y10(3) = 1.45;     %LAC
    y10(4) = 0.0;      %ALA
    y10(5) = 0.0;      %GLR
    y10(6) = 0.0;      %FFA
    y10(7) = 0.0;      %TGL
    y10(8) = 0.027;    %O2
    y10(9) = 15.43;    %CO2
    y10(10) = 0.16;    %G6P
    y10(11) = 2.0;     %GLY
    y10(12) = 0.15;    %GAP
    y10(13) = 0.0;     %GRP
    y10(14) = 0.0068;  %ACoA
    y10(15) = 0.06;    %CoA
    y10(16) = 0.064;   %NAD+
    y10(17) = 0.026;   %NADH
    y10(18) = 2.45;    %ATP
    y10(19) = 0.54;    %ADP
    y10(20) = 2.40;    %Pi
    y10(21) = 4.60;    %PCR
    y10(22) = 5.60;    %CR

%Initial conditions for the heart (H) compartment - y2(x)
    y20(1) = 1.0;      %GLC
    y20(2) = 0.2;      %PYR
    y20(3) = 3.88;     %LAC
    y20(4) = 0.0;      %ALA
    y20(5) = 0.015;    %GLR
    y20(6) = 0.021;    %FFA
    y20(7) = 3.12;     %TGL
    y20(8) = 0.96;     %O2
    y20(9) = 20.0;     %CO2
    y20(10) = 0.17;    %G6P
    y20(11) = 33.0;    %GLY
    y20(12) = 0.01;    %GAP
    y20(13) = 0.29;    %GRP
    y20(14) = 0.0012;  %AcoA
    y20(15) = 0.012;   %CoA
    y20(16) = 0.40;    %NAD+
    y20(17) = 0.045;   %NADH
    y20(18) = 3.4;     %ATP
    y20(19) = 0.02;    %ADP
    y20(20) = 1.66;    %Pi
    y20(21) = 8.3;     %PCR
    y20(22) = 3.5;     %CR

%Initial conditions for the skeletal muscle (M) compartment - y3(x)
    y30(1) = 0.48;     %GLC
    y30(2) = 0.048;    %PYR
    y30(3) = 1.44;     %LAC
    y30(4) = 1.3;      %ALA 
    y30(5) = 0.064;    %GLR 
    y30(6) = 0.53;     %FFA 
    y30(7) = 14.8;     %TGL 
    y30(8) = 0.49;     %O2 
    y30(9) = 15.43;    %CO2 
    y30(10) = 0.24;    %G6P 
    y30(11) = 95.0;    %GLY 
    y30(12) = 0.08;    %GAP 
    y30(13) = 0.15;    %GRP 
    y30(14) = 0.0022;  %ACoA 
    y30(15) = 0.018;   %CoA 
    y30(16) = 0.45;    %NAD+ 
    y30(17) = 0.05;    %NADH 
    y30(18) = 6.15;    %ATP 
    y30(19) = 0.02;    %ADP 
    y30(20) = 2.70;    %Pi 
    y30(21) = 20.1;    %PCR 
    y30(22) = 10.45;   %CR

%Initial conditions for the GI (G) compartment - y4(x)
    y40(1) = 1.0;     %GLC 
    y40(2) = 0.2;     %PYR 
    y40(3) = 3.88;    %LAC 
    y40(4) = 0.0;     %ALA 
    y40(5) = 0.015;   %GLR 
    y40(6) = 0.021;   %FFA 
    y40(7) = 450.0;   %TGL 
    y40(8) = 0.49;    %O2 
    y40(9) = 15.43;   %CO2 
    y40(10) = 0.17;   %G6P 
    y40(11) = 33.0;   %GLY 
    y40(12) = 0.01;   %GAP 
    y40(13) = 0.29;   %GRP 
    y40(14) = 0.0012; %ACoA 
    y40(15) = 0.012;  %CoA 
    y40(16) = 0.40;   %NAD+ 
    y40(17) = 0.045;  %NADH 
    y40(18) = 3.4;    %ATP 
    y40(19) = 0.02;   %ADP 
    y40(20) = 1.66;   %Pi 
    y40(21) = 8.3;    %PCR 
    y40(22) = 3.5;    %CR

%Initial conditions for the liver (L) compartment - y5(x)
    y50(1) = 8.0;     %GLC
    y50(2) = 0.37;    %PYR
    y50(3) = 0.82;    %LAC
    y50(4) = 0.23;    %ALA
    y50(5) = 0.07;    %GLR
    y50(6) = 0.57;    %FFA
    y50(7) = 2.93;    %TGL
    y50(8) = 0.027;   %O2
    y50(9) = 15.43;   %C02
    y50(10) = 0.2;    %G6P
    y50(11) = 417;    %GLY
    y50(12) = 0.11;   %GAP
    y50(13) = 0.24;   %GRP
    y50(14) = 0.035;  %ACoA 
    y50(15) = 0.14;   %CoA 
    y50(16) = 0.45;   %NAD+ 
    y50(17) = 0.05;   %NADH 
    y50(18) = 2.74;   %ATP 
    y50(19) = 1.22;   %ADP 
    y50(20) = 4.60;   %Pi 
    y50(21) = 0.0;    %PCR 
    y50(22) = 0.0;    %CR

%Initial conditions for the adipose tissue (H) compartment - y6(x)
    y60(1) = 2.54;   %GLC 
    y60(2) = 0.37;   %PYR 
    y60(3) = 0.82;   %LAC 
    y60(4) = 0.0;    %ALA 
    y60(5) = 0.22;   %GLR 
    y60(6) = 0.57;   %FA 
    y60(7) = 990.0;  %TGL 
    y60(8) = 0.027;  %O2 
    y60(9) = 15.43;  %CO2 
    y60(10) = 0.2;   %G6P 
    y60(11) = 0.0;   %GLY 
    y60(12) = 0.11;  %GAP 
    y60(13) = 0.24;  %GRP 
    y60(14) = 0.035; %ACoA 
    y60(15) = 0.14;  %CoA 
    y60(16) = 0.45;  %NAD+ 
    y60(17) = 0.05;  %NADH 
    y60(18) = 2.74;  %ATP 
    y60(19) = 1.22;  %ADP 
    y60(20) = 4.60;  %Pi 
    y60(21) = 0.0;   %PCR 
    y60(22) = 0.0;   %CR

%Gather initial conditions   
    y0(1:22)    = Ca0(1:22);
    y0(23:44)   = y10(1:22); 
    y0(45:66)   = y20(1:22); 
    y0(67:88)   = y30(1:22); 
    y0(89:110)  = y40(1:22); 
    y0(111:132) = y50(1:22); 
    y0(133:154) = y60(1:22); 
    y0(155) = 27; %Glucagon
    y0(156) = 45; %Insulin
    ins0 = y0(156);
    glu0 = y0(155);

%Set work rate (WR)
    WR = 150;

%model parameters
c0=[0.75 7.621	-0.2231	0.1	2.930	0.133	0.2757	0.027	0.2	0.1	0.0012	0.1	4	1210000	1.200	1210000	0.66	1440000	23.30	1440000	0.014	1705	2.2	1000000	5	912	2.3	198000	2	0.08	2	2161000	2	0.06	0.6	0.1	1	0.02	3	0.05	1.450	0.01	0.28	0.8	0.58	121000	2 0.1];
c0 = round(c0,4,'significant');

%Set ODEsolver Parameter Values
tic;
    options = odeset('RelTol',1e-6,'AbsTol',1e-8,'Stats','on','NonNegative',1:neq,'Events',@myEventsFcn); 
    lastwarn('');
    [T,Y,te,ye,ie] = ode15s(@(t,y) exerciseMod(t,y,WR,ins0,glu0,c0,tstart,tend),tspan,y0,options);
    [msg,msgID] = lastwarn;
    if ~isempty(msg)
            T=tspan';
            Y=zeros(length(T), length(y0));
    end
toc;

%% Save the data
Y1(:,1:22)=Y(:,23:44);   %brain
Y2(:,1:22)=Y(:,45:66);   %heart
Y3(:,1:22)=Y(:,67:88);   %muscle
Y4(:,1:22)=Y(:,89:110);  %GI
Y5(:,1:22)=Y(:,111:132); %liver
Y6(:,1:22)=Y(:,133:154); %adipose
arterial = Y(:,1:22);    %arterial substrates
hormone = Y(:,155:156);  %glucagon and insulin

[dydt,bflow,MR,P,U,uprel,F,epi] = cellfun(@(t,y) exerciseMod(t,y,WR,ins0,glu0,c0,tstart,tend),num2cell(T),num2cell(Y,2),'uni',0);

bflow = cell2mat(bflow); %blood flow
MR = cell2mat(MR);       %metabolic rate of ATP -> ADP
epinephrine = cell2mat(epi);

%preallocation
P1=zeros(size(T,1),22); P2=P1; P3=P1; P4=P1; P5=P1; P6=P1;
U1=zeros(size(T,1),22); U2=U1; U3=U1; U4=U1; U5=U1; U6=U1;
F1=zeros(size(T,1),25); F2=F1; F3=F1; F4=F1; F5=F1; F6=F1;
UR1=zeros(size(T,1),9); UR2=UR1; UR3=UR1; UR4=UR1; UR5=UR1; UR6=UR1; UR7=UR1;

deriv=zeros(size(Y));
for j=1:size(T,1)
    %production
    P1(j,:) = P{j}(1,:);
    P2(j,:) = P{j}(2,:);
    P3(j,:) = P{j}(3,:);
    P4(j,:) = P{j}(4,:);
    P5(j,:) = P{j}(5,:);
    P6(j,:) = P{j}(6,:);
    
    %utilization
    U1(j,:) = U{j}(1,:);
    U2(j,:) = U{j}(2,:);
    U3(j,:) = U{j}(3,:);
    U4(j,:) = U{j}(4,:);
    U5(j,:) = U{j}(5,:);
    U6(j,:) = U{j}(6,:);
    
    %uptake-release rates
    UR1(j,:) = uprel{j}(1,1:9);
    UR2(j,:) = uprel{j}(2,1:9);
    UR3(j,:) = uprel{j}(3,1:9);
    UR4(j,:) = uprel{j}(4,1:9);
    UR5(j,:) = uprel{j}(5,1:9);
    UR6(j,:) = uprel{j}(6,1:9);
    UR7(j,:) = uprel{j}(7,1:9); % other tissues
    
    %metabolic fluxes
    F1(j,:) = F{j}(1,:);
    F2(j,:) = F{j}(2,:);
    F3(j,:) = F{j}(3,:);
    F4(j,:) = F{j}(4,:);
    F5(j,:) = F{j}(5,:);
    F6(j,:) = F{j}(6,:);

    %miscellaneous
    deriv(j,1:156) = dydt{j};
end    

% control output for sanity check
timestep = diff(T);
maxstep  = max(diff(T));
minstep  = min(diff(T));
maxdydt  = max(deriv,[],'all');

% save('male.mat','arterial','Y1','Y2','Y3','Y4','Y5','Y6','Y','uprel',...
%     'P1','P2','P3','P4','P5','P6','U1','U2','U3','U4','U5','U6',...
%     'UR1','UR2','UR3','UR4','UR5','UR6','UR7','F1','F2','F3','F4','F5','F6','hormone','T','deriv',...
%      'MR','bflow','epinephrine','c0','y0','t0','tend','WR','ins0','glu0') 
