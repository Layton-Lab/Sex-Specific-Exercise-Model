 %% Comparing model simulation results to data
close all;
clear;
clc;

sex = 0; % male (female,1);
% call ODE solver for the main exercise model, exerciseMod.m
[T,Y,WR,c0,y0,ins0,glu0,tstart,tend,sex] = call_exerciseMod(sex);
% sort data for each organ 
driver_getdata;

%% Hirsch1991
% Time
t1 = [0 10 20 30 40 50 60];
% Arterial insulin concentration (pM)
ins = [59 46 37 35 32 29 29];
ins_sd = [8 8 4 7 3 4 4];
% Arterial glucagon concentration (pM)
glu = [26.99 28.14 25.84 27.56 27.56 29.28 30.15];
glu_sd = [2.87 2.30 2.01 2.01 2.01 2.87 1.72];
% Glucagon-Insulin ratio (unitless)
gir = glu./ins;
    % Standard Deviation (SD) in this case is the difference between the 
    % highest value that the GIR can take and the average GIR. 
    % The GIR is highest when glucagon is at a maximum and insulin is at a 
    % minimum -> (glu+glu_sd)./(ins-ins_sd)
gir_sd = (glu+glu_sd)./(ins-ins_sd) - gir;
% Whole body glucose production (mmol/min)
Ra = [0.74 0.82 1.09 1.55 1.75 1.95 1.95];
Ra_sd =[0.15 0.20 0.15 0.20 0.20 0.20 0.27];
% Whole body glucose utilization (mmol/min)
Rd = [0.78 0.85 1.13 1.55 1.75 1.95 2.06];
Rd_sd =[0.12 0.15 0.20 0.23 0.20 0.20 0.27];
% whole body glucoe balance Ra - Rd (mmol/min)
bal = Ra - Rd;
    % SD in this case is the difference between the highest value that the
    % whole body glucose balance can take and the average glucose balance. 
    % The balance is highest when production is at its maximum while 
    % utilization is at its minimum -> (Ra+Ra_sd)-(Rd-Rd_sd)  
bal_sd = ((Ra+Ra_sd) - (Rd-Rd_sd)) - bal;
% Relative arterial glucose concentration (mM)
glc = [5.1 5.1 5.1 5.1 5.1 5 4.8]/5.1;
glc_sd = [0.1 0.1 0.1 0.1 0.2 0.2 0.2]/5.1;
% Relative arterial FFA concentration (unitless)
ffa = [0.32 0.26 0.26 0.30 0.33 0.37 0.41]/0.32;
ffa_sd = [0.04 0.03 0.03 0.03 0.04 0.04 0.06]/0.32;

%% vanHall2002
% Time of exercise
t2 = [20 40 60];
% Relative arterial glycerol concentration (unitless)
glr = [0.166 0.225 0.251]/0.075; % 0.075 is the measurement at t=-10. 
glr_sd = [0.0165 0.0174 0.0202]/0.075;
tg=[0.84 0.81 0.80]'./0.79;	% 0.79 is the measurement at t=-10. 
tg_sd=[0.15	0.16 0.16]'./0.79; 

%% Bergman1999
% Time of exercise
t4 = [0 15 30 45 60];
% Relative arterial lactate concentration (unitless)
lac = [1.33 3.69 4.09 3.24 2.29]/1.33;
lac_sd = [0.15 0.30 0.66 0.46 0.17]/1.33;


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
errorbar(t1,glu,glu_sd,'^','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') %Glucagon
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({-10','0','10','20','30','40','50','60','',})
ylim([0,70])
xlabel('Time, min','FontWeight','B')
ylabel('Concentration, pM','FontWeight','B')
legend('Insulin','Glucagon','Insulin (experiment)','Glucagon (experiment)')
set(gca,'FontSize',15)
% Tile 2
nexttile
plot(Time,hormone(:,1)./hormone(:,2),'-k','linewidth',2) % GIR
hold on
errorbar(t1,gir,gir_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % GIR
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
ylim([0,1.2])
xlabel('Time, min','FontWeight','B')
ylabel('Glucagon-Insulin ratio','FontWeight','B')
legend('GIR','GIR (experiment)')
set(gca,'FontSize',15)

figure(2)
tiledlayout(1,2)
% Tile 1
nexttile
utilization = UR1+UR2+UR3+UR4+UR6+UR7;
production = -UR5; %UR5 is negative, thus we have production as -release rate.
plot(Time, production(:,1), '-k', 'linewidth', 2)
hold on
errorbar(t1,Ra,Ra_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % whole body GLC production
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
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
errorbar(t1,bal,bal_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % whole body GLC balance
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
ylim([-2,2])
xlabel('Time, min','FontWeight','B')
ylabel('Whole body glucose balance','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

figure(3)
tiledlayout(1,2)
% Tile 1
nexttile
plot(Time, arterial(:,1)/arterial(1,1), '-k', 'linewidth', 2)
hold on
errorbar(t1,glc,glc_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % glucose
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
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
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
ylim([-2,2])
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. FFA conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)
%-----------------------------------------------------------------

figure(4)
plot(Time, arterial(:,5)./arterial(1,5), '-k', 'linewidth', 2)
hold on
errorbar(t2,glr,glr_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative GLR
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. GLR conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

%-----------------------------------------------------------------

figure(6)
plot(Time, arterial(:,3)./arterial(1,3), '-k', 'linewidth', 2)
hold on
errorbar(t4,lac,lac_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative LAC
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. LAC conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

%-----------------------------------------------------------------

figure(7)
plot(Time, arterial(:,7)./arterial(1,7), '-k', 'linewidth', 2)
hold on
errorbar(t2,tg,tg_sd,'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') % relative TG
hold off
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
xlabel('Time, min','FontWeight','B')
ylabel('Rel. art. TG conc. (unitless)','FontWeight','B')
legend('Simulation','Experiment')
set(gca,'FontSize',15)

%-----------------------------------------------------------------

figure(7)
plot(T,UR1(:,8),"LineWidth",2)
hold on
plot(T,UR2(:,8),"LineWidth",2)
plot(T,UR3(:,8),"LineWidth",2)
plot(T,UR4(:,8),"LineWidth",2)
plot(T,UR5(:,8),"LineWidth",2)
plot(T,UR6(:,8),"LineWidth",2)
hold off
ylabel('O2 flux')
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
xlabel('Time, min','FontWeight','B')
legend('B','H','M','G','L','A')
set(gca,'FontName','Helvetica','FontSize',14)

figure(8)
plot(T,UR1(:,9),"LineWidth",2)
hold on
plot(T,UR2(:,9),"LineWidth",2)
plot(T,UR3(:,9),"LineWidth",2)
plot(T,UR4(:,9),"LineWidth",2)
plot(T,UR5(:,9),"LineWidth",2)
plot(T,UR6(:,9),"LineWidth",2)
hold off
ylabel('CO2 flux')
xlim([-10,120])
xticks([-10 0 10 20 30 40 50 60 70])
xticklabels({'-10','0','10','20','30','40','50','60',''})
xlabel('Time, min','FontWeight','B')
legend('B','H','M','G','L','A')
set(gca,'FontName','Helvetica','FontSize',14)

%% checking RQ at steady state
V = round(22.4*uprel{1,1}(:,8:9),4,'significant');
WB = sum(V,1);
RQ0_WB = -WB(2)/WB(1);

