%% Comparing model simulation results to data
close all;
clear;
clc;

sex = 1; % female (male,0);
% call ODE solver for the main exercise model, exerciseMod.m
[T,Y,WR,c0,y0,ins0,glu0,tstart,tend,sex] = call_exerciseMod(sex);
% sort data for each organ 
driver_getdata;

%% Hirsch1991
% Time
t1 = [0 10 20 30 40 50 60]';
% Arterial insulin concentration (pM) 
ins = [59 46 37 35 32 29 29]';
ins_sd = [8 8 4 7 3 4 4]';
% Relative arterial FFA concentration (unitless)
ffa = [0.32 0.26 0.26 0.30 0.33 0.37 0.41]/0.32;
ffa_sd = [0.04 0.03 0.03 0.03 0.04 0.04 0.06]/0.32;

%% Horton et al. 2006
% Arterial glucagon concentration (pM)
% fractional change: starting point calculated by (HortonF/HortonM) * HirschM
% t = [-15	30	60	75	90	120	150	210	280];
% glu = [39.55	42.27	42.46	45.30	49.24	47.39	41.30	41.68	41.91]; %full data
% glu_sd = [2.01	3.57	2.34	2.68	2.90	2.90	2.57	2.35	1.79]; % full data
t2 = [-15 30 60 75 90]'; 
glu = [39.55	42.27	42.46	45.30	49.24]';
glu_sd = [2.01	3.57	2.34	2.68	2.90]';

% Glucagon-Insulin ratio (unitless)
t3 = [30 60]';
gir = glu([2,3])./ins([4,7]);
    % Standard Deviation (SD) in this case is the difference between the 
    % highest value that the GIR can take and the average GIR. 
    % The GIR is highest when glucagon is at a maximum and insulin is at a 
    % minimum -> (glu+glu_sd)./(ins-ins_sd) - gir
gir_sd = (glu([2,3])+glu_sd([2,3]))./(ins([4,7])-ins_sd([4,7])) - gir;

t4 = [0 15 30 45 60]';
% Whole body glucose production (mmol/min)
Ra = [0.74 1.25 1.19 1.17 1.19]';
Ra_sd =[0.06 0.28 0.28 0.28 0.28]';
% Whole body glucose utilization (mmol/min)
Rd = [0.77 1.28 1.25 1.19 1.25]';
Rd_sd =[0.06 0.28 0.28 0.28 0.28]';
% whole body glucoe balance Ra - Rd (mmol/min)
bal = Ra - Rd;
% SD in this case is the difference between the highest value that the
    % whole body glucose balance can take and the average glucose balance. 
    % The balance is highest when production is at its maximum while 
    % utilization is at its minimum -> (Ra+Ra_sd)-(Rd-Rd_sd)  
bal_sd = ((Ra+Ra_sd) - (Rd-Rd_sd)) - bal;

t5 = [0 10 20 30 45 60]';
% Relative arterial lactate concentration (unitless)
lac = [0.4 1.2 1.0 0.75 0.7 0.65]'/0.4;
lac_sd = [0.10 0.40 0.40 0.20 0.20 0.10]'/0.4;

%% vanHall2002
% Time of exercise
t6 = [20 40 60];
% Relative arterial glycerol concentration (unitless)
glr = [0.166 0.225 0.251]/0.075; % 0.075 is the measurement at t=-10. 
glr_sd = [0.0165 0.0174 0.0202]/0.075;

%% Horton et al. 2006
% Time of exercise
t7 = [-15 0 10 20 30 45 60 75 90 110 120 150 210 270];
% Arterial epinephrine concentration (pM)
% epi_exp_pg_pmol = [27 80 73 60 68 70 90 105 24 25 27 25 27]; % concentration in pg
epi_exp = [147 147 437 398 328 371 382 491 573 131 136 147 136 147]; % pmol
epi_exp_sd = [16 16 82 109 82 109 82 218 218 16 16 16 16 16];

%% Horton et al. 2002 
% Time of exercise
t8 = [-15 0 10 20 30 45 60 75 90];
% Arterial epinephrine concentration (pM)
epi_exp_pg_pmol_2 = [23 23 67 70 55 69 71 74 90];
epi_exp_2 = [126 126 366 382 300 377 388 404 491];
epi_exp_sd_2 = [20 20 55 136 109 66 109 109 136];

%% Campbell et al. 2001
t3camp = [0 30 60]';
% arterial glucose concentration (mM)
glc = [4.75 4.9 4.65]';
glc_sd = [0.2 0.4 0.3]';

%% Plotting
Time = T-10;

%-----------------------------------------------------------------
figure(1)
tiledlayout(1,2)
% Tile 1
nexttile
plot(Time,hormone(:,2),'--k','linewidth',2) % Insulin
hold on
plot(Time,hormone(:,1),'-k','linewidth',2)  %Glucagon
errorbar(t1,ins,ins_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % Insulin
errorbar(t2,glu,glu_sd,'^','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') %Glucagon
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([0,70])
xlabel('Time, min','FontWeight','B')
ylabel('Concentration, pM','FontWeight','B')
legend('Insulin','Glucagon','Insulin (experiment)','Glucagon (experiment)')
set(gca,'FontSize',15)
% Tile 2
nexttile
plot(Time,hormone(:,1)./hormone(:,2),'-k','linewidth',2) % GIR
hold on
errorbar(t3,gir,gir_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % GIR
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([0,2])
xlabel('Time, min','FontWeight','B')
ylabel('Glucagon-Insulin ratio','FontWeight','B')
legend('GIR','GIR (experiment)')
set(gca,'FontSize',15)

figure(2)
tiledlayout(1,2)
% Tile 1
nexttile
utilization = UR1+UR2+UR3+UR4+UR6+UR7;
production = -UR5; %UR5 is negative, thus we have production = (-)release rate.
plot(Time, production(:,1), '-k', 'linewidth', 2)
hold on
errorbar(t4,Ra,Ra_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % whole body GLC production
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([0,3])
xlabel('Time, min','FontWeight','B')
ylabel('Whole body glucose production','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)
% Tile 2
nexttile
balance = production - utilization; 
plot(Time, balance(:,1), '-k', 'linewidth', 2)
hold on
errorbar(t4,bal,bal_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % whole body GLC balance
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([-2,2])
xlabel('Time, min','FontWeight','B')
ylabel('Whole body glucose balance','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

figure(3)
tiledlayout(1,2)
% Tile 1
nexttile
plot(Time, arterial(:,1), '-k', 'linewidth', 2)
hold on
errorbar(t3camp,glc,glc_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % glucose
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([1,6])
xlabel('Time, min','FontWeight','B')
ylabel('GLC conc. (mM)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)
% Tile 2
nexttile
plot(Time, arterial(:,6)./arterial(1,6), '-k', 'linewidth', 2)
hold on
errorbar(t1,ffa,ffa_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative FFA
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([0,1.5])
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. FFA conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)
%-----------------------------------------------------------------

figure(4)
tiledlayout(1,2)
% Tile 1
nexttile
plot(Time, arterial(:,5)./arterial(1,5), '-k', 'linewidth', 2)
hold on
errorbar(t6,glr,glr_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative GLR
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. GLR conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)
% Tile 2
nexttile
plot(Time, arterial(:,3)./arterial(1,3), '-k', 'linewidth', 2)
hold on
errorbar(t5,lac,lac_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative LAC
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. LAC conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

figure(5)
plot(Time,epinephrine,'-','linewidth',2) % epinephrine
hold on
errorbar(t7,epi_exp,epi_exp_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') 
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130])
xticklabels({-10','0','10','20','30','40','50','60', '70', '80', '90', '100', '110', '120' , ''})
ylim([0,700])
xlabel('Time, min','FontWeight','B')
ylabel('Concentration of epinephrine, pM','FontWeight','B')
legend('Epinephrine', 'Epinephrine (experiment)')
set(gca,'FontSize',15)

%-----------------------------------------------------------------
figure(8)
plot(T,UR1(:,8),"LineWidth",2)
hold on
plot(T,UR2(:,8),"LineWidth",2)
plot(T,UR3(:,8),"LineWidth",2)
plot(T,UR4(:,8),"LineWidth",2)
plot(T,UR5(:,8),"LineWidth",2)
plot(T,UR6(:,8),"LineWidth",2)
hold off
ylabel('O2 flux')
xlabel('Time (min)')
legend('B','H','M','G','L','A')
set(gca,'FontName','Helvetica','FontSize',14)

figure(9)
plot(T,UR1(:,9),"LineWidth",2)
hold on
plot(T,UR2(:,9),"LineWidth",2)
plot(T,UR3(:,9),"LineWidth",2)
plot(T,UR4(:,9),"LineWidth",2)
plot(T,UR5(:,9),"LineWidth",2)
plot(T,UR6(:,9),"LineWidth",2)
hold off
ylabel('CO2 flux')
xlabel('Time (min)')
legend('B','H','M','G','L','A')
set(gca,'FontName','Helvetica','FontSize',14)

%% checking RQ at steady state
V = round(22.4*uprel{1,1}(:,8:9),4,'significant');
WB = sum(V,1);
RQ0_WB = -WB(2)/WB(1);