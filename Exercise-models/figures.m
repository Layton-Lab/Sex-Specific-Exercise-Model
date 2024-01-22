%% SET UP
clearvars; clc;

addpath( './helper_functions' );

%% LINE COLORS 
N=4; 
C = brewermap(N,'PuOr');
colour_grey = [0.22 0.25 0.32];

%% Table 5: Whole-body sex-specific RQ during exercise at 60% VO2max
load("male.mat")
times = [-10 15 30 45 60];
idx3 = arrayfun( @(x)( find(Time==x) ), times); % indices for times
o2_consumption_male = UR1(idx3,8)+UR2(idx3,8)+UR3(idx3,8)+UR4(idx3,8)+UR5(idx3,8)+UR6(idx3,8)+UR7(idx3,8);
co2_production_male = -(UR1(idx3,9)+UR2(idx3,9)+UR3(idx3,9)+UR4(idx3,9)+UR5(idx3,9)+UR6(idx3,9)+UR7(idx3,9));
rq_male = (co2_production_male)./(o2_consumption_male)
percent_carbs_male = ((rq_male-0.7)./0.3)*100;
percent_fats_male = 100-percent_carbs_male;

load("female.mat")
times = [-10 15 30 45 60];
idx4 = arrayfun( @(x)( find(Time==x) ), times); % indices for times
o2_consumption_female = UR1(idx4,8)+UR2(idx4,8)+UR3(idx4,8)+UR4(idx4,8)+UR5(idx4,8)+UR6(idx4,8)+UR7(idx4,8);
co2_production_female = -(UR1(idx4,9)+UR2(idx4,9)+UR3(idx4,9)+UR4(idx4,9)+UR5(idx4,9)+UR6(idx4,9)+UR7(idx4,9));
rq_female = (co2_production_female)./(o2_consumption_female)
percent_carbs_female = ((rq_female-0.7)./0.3)*100;
percent_fats_female = 100-percent_carbs_female;

load("male-with-Fmatched-adipose.mat")
times = [-10 15 30 45 60];
idx3 = arrayfun( @(x)( find(Time==x) ), times); % indices for times
o2_consumption_male = UR1(idx3,8)+UR2(idx3,8)+UR3(idx3,8)+UR4(idx3,8)+UR5(idx3,8)+UR6(idx3,8)+UR7(idx3,8);
co2_production_male = -(UR1(idx3,9)+UR2(idx3,9)+UR3(idx3,9)+UR4(idx3,9)+UR5(idx3,9)+UR6(idx3,9)+UR7(idx3,9));
rq_male_matched = (co2_production_male)./(o2_consumption_male)
percent_carbs_male_matched = ((rq_male_matched-0.7)./0.3)*100;
percent_fats_male = 100-percent_carbs_male_matched;

%% FIG3: whole body RQ
figure(1)
percents = [percent_carbs_male(2) percent_fats_male(2);
    percent_carbs_female(2) percent_fats_female(2);
    0 0;
    percent_carbs_male(3) percent_fats_male(3);
    percent_carbs_female(3) percent_fats_female(3);
    0 0;
    percent_carbs_male(4) percent_fats_male(4);
    percent_carbs_female(4) percent_fats_female(4);
    0 0;
    percent_carbs_male(5) percent_fats_male(5);
    percent_carbs_female(5) percent_fats_female(5);
    0 0];
b = bar(percents,'stacked');  % Create a stacked histogram
legend('Carbohydrates', 'Lipids','Location','north','Orientation','horizontal',...
    'NumColumns',2)
xlabel('Time, min')
ylabel('Percent contribution')
xtips2 = b(2).XEndPoints;
ytips2 = b(1).YEndPoints;
labels2 = {'M', 'F', '', 'M', 'F', '', 'M', 'F', '', 'M', 'F',''};
text(xtips2, ytips2, labels2, 'HorizontalAlignment','center', ...
    'VerticalAlignment','bottom', 'FontWeight','bold', 'Color', 'black',...
    'FontSize', 14)
set(gca, 'XLim', [0 12], 'XTick', [1.5,4.5,7.5,10.5],...
    'XTickLabel', {'15' '30' '45' '60'}, 'YLim', [0 120]);
N = 2;
C = linspecer(N,'qualitative');
newcolors = [C(1,:); C(2,:)];
colororder(newcolors)
set(gca, 'FontSize', 16);
% exportgraphics(gcf,'Fig3.png','resolution',600)

%% Table 6: Organ/tissue specific RQ over 60 min of exercise at 60% VO2max
load("male.mat")
times = [0 60];
idx3 = arrayfun( @(x)( find(Time==x) ), times); % indices for times
t0=idx3(1); t1=idx3(2);
o2_consumption_male = sum(UR1(t0:t1,8)+UR2(t0:t1,8)+UR3(t0:t1,8)+UR4(t0:t1,8)+UR5(t0:t1,8)+UR6(t0:t1,8)+UR7(t0:t1,8));
co2_production_male = -sum(UR1(t0:t1,9)+UR2(t0:t1,9)+UR3(t0:t1,9)+UR4(t0:t1,9)+UR5(t0:t1,9)+UR6(t0:t1,9)+UR7(t0:t1,9));
rq_male_wholebody = (co2_production_male)./(o2_consumption_male) 
% rq_male_wholebody = 0.8987;

UR = {UR1 UR2 UR3 UR4 UR5 UR6 UR7};
for i=1:7
    rq_male(i)=(sum(-UR{i}(t0:t1,9)))/(sum(UR{i}(t0:t1,8)));
end
rq_male_organs = round(rq_male,2,'significant')
% rq_male=[1.0000    0.8700    0.9100    1.0000    0.7300    0.7600    0.7300];

load("female.mat")
times = [0 60];
idx3 = arrayfun( @(x)( find(Time==x) ), times); % indices for times
t0=idx3(1); t1=idx3(2);
o2_consumption_female = sum(UR1(t0:t1,8)+UR2(t0:t1,8)+UR3(t0:t1,8)+UR4(t0:t1,8)+UR5(t0:t1,8)+UR6(t0:t1,8)+UR7(t0:t1,8));
co2_production_female = -sum(UR1(t0:t1,9)+UR2(t0:t1,9)+UR3(t0:t1,9)+UR4(t0:t1,9)+UR5(t0:t1,9)+UR6(t0:t1,9)+UR7(t0:t1,9));
rq_female_wholebody = (co2_production_female)./(o2_consumption_female)
% rq_female_wholebody = 0.8821;

UR = {UR1 UR2 UR3 UR4 UR5 UR6 UR7};
for i=1:7
    rq_female(i)=(sum(-UR{i}(t0:t1,9)))/(sum(UR{i}(t0:t1,8)));
end
rq_female_organs = round(rq_female,2,'significant')
% rq_female_organs = [1.0000    0.8700    0.8900    1.0000    0.7200    0.7100    0.7300];

%% FIG4: Dynamic responses of (a) epinephrine, (b) insulin and glucagon
N=4; 
C = brewermap(N,'PuOr');
colour_grey = [0.22 0.25 0.32];

figure(2);
%-----------------------------------------%
subplot(2,2,[1,3]);
load("female.mat")
% Horton et al. 2006
% Time of exercise
t1 = [-10 0 20 30 45 60];
% Female Arterial epinephrine concentration (pM)
epi_exp = [147 147 398 328 371 382];
epi_exp_sd = [16 16 109 82 109 82];
plot(Time,epinephrine,'-','linewidth', 3, 'color', C(1,:)) % epinephrine
hold on
errorbar(t1,epi_exp,epi_exp_sd,'d','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') 
load("male.mat")
% Hirsch et al. 1991
t2 = [-10 0 10 20 30 40 50 60];
% Male Arterial epinephrine concentration (pM)
epi_exp_m = [250 380 600 800 960 1000 1150 1180];
epi_exp_sd_m = [30 60 110 130 260 130 130 130];
plot(Time,epinephrine,'-','linewidth', 3, 'color', C(4,:)) % epinephrine
errorbar(t2,epi_exp_m,epi_exp_sd_m,'s','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
hold off
xlim([-10,63])
xticks(-10:10:60)
ylim([0,1300])
xlabel({'Time, min'})
ylabel('Epinephrine, pM')
legend('Female', 'Female (experiment)', 'Male', 'Male (experiment)','Location','northwest')
set(gca,'FontSize',16)
%-----------------------------------------%
subplot(2,2,2);
load("female.mat")
% Hirsch et al. 1991
t1 = [0 10 20 30 40 50 60]';
ins = [59 46 37 35 32 29 29]'; % using male values, no significant sex diff 
ins_sd = [8 8 4 7 3 4 4]';
plot(Time,hormone(:,2), 'linewidth', 3, 'color', C(1,:)) % Insulin
hold on
load("male.mat")
% % Hirsch et al. 1991 - same as female
% t1 = [0 10 20 30 40 50 60];
% ins = [59 46 37 35 32 29 29];
% ins_sd = [8 8 4 7 3 4 4];
plot(Time,hormone(:,2), 'linewidth', 3, 'color', C(4,:)) % Insulin
errorbar(t1,ins,ins_sd,'o','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') 
hold off
ylabel('Insulin, pM')
xlim([-10 63])
xticks(-10:10:60)
ylim([20 67])
legend('Female', 'Male','Experiment', 'Location','northeast','Orientation',...
    'vertical','NumColumns',1)
set(gca, 'FontSize', 16)
%-----------------------------------------%
subplot(2,2,4);
load("female.mat")
% Horton et al. 2006
t2 = [0 30 60 75 90]'; 
glu = [39.62 41.07 40.78 43.38 48.59]';  
glu_sd = [1.3 6.98 4.58 4.36 4.07]';
plot(Time,hormone(:,1),'--','linewidth', 3, 'color', C(1,:))  %Glucagon
hold on
errorbar(t2,glu,glu_sd,'d','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
load("male.mat")
% Hirsch et al. 1991
t1 = [0 10 20 30 40 50 60];
glu = [26.99 28.14 25.84 27.56 27.56 29.28 30.15];
glu_sd = [2.87 2.30 2.01 2.01 2.01 2.87 1.72];
plot(Time,hormone(:,1),'--','linewidth', 3, 'color', C(4,:))  %Glucagon
errorbar(t1,glu,glu_sd,'s','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
hold off
xlim([-10,63])
xticks(-10:10:60)
ylim([20 67])
xlabel({'Time, min'})
ylabel('Glucagon, pM')
legend('Female', 'Female (experiment)', 'Male', 'Male (experiment)', 'Orientation',...
    'horizontal','NumColumns',2,'location','NorthEast')
set(gca,'FontSize',16)
% exportgraphics(gcf,'Fig4.png','Resolution',600) 

%% FIG5: Dynamic responses of (a) whole-body glucose production, (b) net hepatic glycogen breakdown & gluconeogenesis
figure(3)
%-----------------------------------------%
subplot(1,2,1)
load("female.mat")
production = -UR5; 
plot(Time, production(:,1), 'linewidth', 3, 'color', C(1,:))
hold on
% Horton et al. 2006
texp = [0 15 30 45 60]; 
Ra = [0.74 1.25 1.19 1.17 1.19];
Ra_sd =[0.06 0.28 0.28 0.28 0.28];
errorbar(texp,Ra,Ra_sd,'d','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color', 'k')
load("male.mat")
production = -UR5; 
plot(Time, production(:,1), 'linewidth', 3, 'color', C(4,:))
% Hirsch1991
texp = [0 10 20 30 40 50 60];
Ra = [0.74 0.82 1.09 1.55 1.75 1.95 1.95];
Ra_sd =[0.15 0.20 0.15 0.20 0.20 0.20 0.27];
errorbar(texp,Ra,Ra_sd,'s','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color', 'k')
hold off
xlim([-10,63])
xticks([-10 0 10 20 30 40 50 60])
xticklabels({'-10','0','10','20','30','40','50','60'})
ylim([0,2.5])
xlabel('Time, min')
ylabel('Whole-body glucose production, mM/min')
legend('Female', 'Female (experiment)', 'Male', 'Male (experiment)', 'Orientation',...
    'horizontal','NumColumns',2,'location','NorthWest')
set(gca,'FontSize',16)
%-----------------------------------------%
subplot(1,2,2)
load("female.mat")
gng_female = (F5(:,5)./2)-F5(:,2);
glyg_female = F5(:,8)-F5(:,7);
plot(Time, glyg_female, 'linewidth', 3, 'color', C(1,:)) % hep glyg breakdown
hold on
plot(Time, gng_female, '--', 'linewidth', 3, 'color', C(1,:)) % hep gluconeogenesis
load("male.mat")
gng_male = (F5(:,5)./2)-F5(:,2);
glyg_male = F5(:,8)-F5(:,7);
plot(Time, glyg_male, 'linewidth', 3, 'color', C(4,:)) % hep glyg breakdown
plot(Time, gng_male, '--', 'linewidth', 3, 'color', C(4,:)) % hep gluconeogenesis
L1 = plot(nan, nan, '-k', 'linewidth', 3);
L2 = plot(nan, nan, '--k', 'linewidth', 2.5);
hold off
xlim([-10,63])
xticks([-10 0 10 20 30 40 50 60])
xticklabels({'-10','0','10','20','30','40','50','60'})
ylim([0,1.8])
xlabel('Time, min')
ylabel('Flux rate, mmol/min')
legend('Female','','Male','','Net hepatic glycogen breakdown', ...
    'Net hepatic gluconeogenesis','Orientation','vertical',...
    'NumColumns',2,'location','NorthWest')
set(gca,'FontSize',16)
% exportgraphics(gcf,'Fig5.png','Resolution',600) 

%% FIG5: (a) GIR, (b) fractional change in GIR and Vmax_glycogenolysis, (c) glucose
figure(4)
%-----------------------------------------%
subplot(2,2,1)
load("female.mat")
% Glucagon-Insulin ratio (unitless)
% Horton et al. 2006
t1 = [0 10 20 30 40 50 60];
ins = [59 46 37 35 32 29 29]';
ins_sd = [8 8 4 7 3 4 4]';
glu = [39.55	42.27	42.46	45.30	49.24]';
glu_sd = [2.01	3.57	2.34	2.68	2.90]';
t3 = [0 30 60]';
gir = glu(1:3)./ins([1,4,7]);
gir_sd = (glu(1:3)+glu_sd(1:3))./(ins([1,4,7])-ins_sd([1,4,7])) - gir;
plot(Time(1:8001),hormone(1:8001,1)./hormone(1:8001,2), 'linewidth', 3, 'color', C(1,:)) % GIR
hold on
errorbar(t3,gir,gir_sd,'s','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k') 
load("male.mat")
% Hirsch et al. 1991
% t1 = [0 10 20 30 40 50 60];
ins = [59 46 37 35 32 29 29];
ins_sd = [8 8 4 7 3 4 4];
glu = [26.99 28.14 25.84 27.56 27.56 29.28 30.15];
glu_sd = [2.87 2.30 2.01 2.01 2.01 2.87 1.72];
gir = glu./ins;
gir_sd = (glu+glu_sd)./(ins-ins_sd) - gir;
plot(Time,hormone(:,1)./hormone(:,2), 'linewidth', 3, 'color', C(4,:)) % GIR
errorbar(t1,gir,gir_sd,'^','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
hold off
xlim([-10 63])
xticks(-10:10:60)
ylim([0 2])
xlabel('Time, min')
ylabel('GIR, unitless')
legend('Female', 'Female (experiment)', 'Male', 'Male (experiment)', 'Orientation',...
    'vertical','NumColumns',1,'location','NorthWest')
set(gca,'FontSize',16)
%-----------------------------------------%
subplot(2,2,2)
% female
load('female.mat')
tf=Time;
times = [15 30 45 60];
idf = arrayfun( @(x)( find(Time==x) ), times);
GIR_F = Y(:,155)./Y(:,156);
GIR_F0 = Y(1,155)./Y(1,156);
change_F = (GIR_F(idf)-GIR_F0)./GIR_F0; % incremental change
% Vmax(8) --> glycogenolysis max rate coefficient
GIR = (Y(:,155)./Y(:,156))-GIR_F0;
lambda8  = c0(39); alpha8  = c0(40); Vmax8 = 3.84;
Vmax8_F=Vmax8*(1.0+(lambda8*GIR.^2)./(alpha8+GIR.^2));
change_VF = (Vmax8_F-Vmax8)/Vmax8;

% male
load('male.mat')
tm=Time;
times = [15 30 45 60];
idm = arrayfun( @(x)( find(Time==x) ), times);
GIR_M = Y(:,155)./Y(:,156);
GIR_M0 = Y(1,155)./Y(1,156);
change_M = (GIR_M(idm)-GIR_M0)./GIR_M0; % incremental change
% Vmax(8) --> glycogenolysis max rate coefficient
GIR = (Y(:,155)./Y(:,156))-GIR_M0;
lambda8  = c0(39); alpha8  = c0(40); Vmax8 = 3.84;
Vmax8_M=Vmax8*(1.0+(lambda8*GIR.^2)./(alpha8+GIR.^2));
change_VM = (Vmax8_M-Vmax8)/Vmax8;

x = [15 30 45 60];
y = [change_F(1) change_M(1);
     change_F(2) change_M(2);
     change_F(3) change_M(3);
     change_F(4) change_M(4)];
b = bar(x,y,1); 
xlabel('Time, min')
ylabel('Fractional change')
xticks([-10 0 15 30 45 60])
xticklabels
N=4; 
C = brewermap(N,'PuOr');
newcolors = [C(2,:); C(3,:)];
colororder(newcolors)
hold on
plot(tf(1:8001),change_VF(1:8001),'LineWidth',3,'Color',C(1,:))
%---------------------------------------------%
load("female-matching-vmax8-sensitivities.mat")
GIR = (Y(:,155)./Y(:,156))-39/60;
lambda8  = 3; alpha8  = 0.05; Vmax8 = 3.84; % male-matched values
Vmax8_F2=Vmax8*(1.0+(lambda8*GIR.^2)./(alpha8+GIR.^2));
change_VF2 = (Vmax8_F2-Vmax8)/Vmax8;
plot(Time,change_VF2,':','LineWidth',4,'Color',C(1,:))
%---------------------------------------------%
plot(tm,change_VM,'LineWidth',3,'Color',C(4,:))
xlim([0 70])
xticks(0:10:60)
ylim([0 3.8])
legend('Female GIR', 'Male GIR', 'Vmax_{GLY \rightarrow G6P}^{F}',...
    'Vmax_{GLY \rightarrow G6P}^{F-matched}','Vmax_{GLY \rightarrow G6P}^{M}', ...
    'Location','northwest','Orientation','vertical','NumColumns',3)
set(gca, 'FontSize', 16);
%-----------------------------------------%
subplot(2,2,3)
load("female.mat")
% Campbell et al. 2001
t1 = [0 30 60]';
% arterial glucose concentration (mM)
glc = [4.75 4.9 4.65]';
glc_sd = [0.2 0.4 0.3]';
plot(Time,Y(:,1),'-','linewidth', 3, 'color', C(1,:)) % GLC
hold on
errorbar(t1,glc,glc_sd,'d','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
load("male.mat")
% Hirsch et al. 1991
t1 = [0 10 20 30 40 50 60];
% Relative arterial glucose concentration (mM)
glc = [5.1 5.1 5.1 5.1 5.1 5 4.8];
glc_sd = [0.1 0.1 0.1 0.1 0.2 0.2 0.2];
plot(Time,Y(:,1),'-','linewidth', 3, 'color', C(4,:)) % GLC
errorbar(t1,glc,glc_sd,'s','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
load('female-matching-vmax8-sensitivities.mat')
plot(Time,Y(:,1),'--','LineWidth',3,'Color',C(1,:))
xlabel('Time, min')
ylabel('Glucose, mM')
xlim([-10 63])
ylim([4 7])
legend('Female', 'Female (experiment)', 'Male', 'Male (experiment)',...
   'Female (matched)','Location','northwest','orientation','horizontal','NumColumns',2)
set(gca,'FontSize',16)
% exportgraphics(gcf,'Fig6.png','Resolution',600)

%% FIG8: (a) glucose uptake, (b) net glycogen breakdown, (c) FFA uptake, (d) net triglyceride breakdown
figure(5)
N=4; 
C = brewermap(N,'PuOr');
colour_grey = [0.22 0.25 0.32];
newcolors_f = [colour_grey; C(2,:)];
newcolors_m = [colour_grey; C(3,:)];
tiledlayout(2,2)
%-----------------------------------------%
ax1=nexttile;
load("male.mat")
times = [0 10 20 30 40 50 60]';
idx2 = arrayfun( @(x)( find(Time==x) ), times); % indices for times 
net_gly_breakdown_m = F3(idx2,8)-F3(idx2,7);
glucose_uptake_m = UR3(idx2, 1);
bar(times, [glucose_uptake_m net_gly_breakdown_m], 0.75, 'stacked')
colororder(ax1,newcolors_m)
xlabel('Time, min')
ylabel('Rate, mmol/min')
axis([-7.5 67.5 0 10])
legend('Glucose uptake', 'Net glycogen breakdown')
set(gca,'FontSize',16)
%-----------------------------------------%
ax2=nexttile;
load("female.mat")
times = [0 10 20 30 40 50 60];
idx1 = arrayfun( @(x)( find(Time==x) ), times); % indices for times 
net_gly_breakdown_f = F3(idx1,8)-F3(idx1,7);
glucose_uptake_f = UR3(idx1, 1);
bar(times, [glucose_uptake_f net_gly_breakdown_f], 0.75, 'stacked')
colororder(ax2,newcolors_f)
xlabel('Time, min')
ylabel('Rate, mmol/min')
axis([-7.5 67.5 0 10])
legend('Glucose uptake', 'Net glycogen breakdown')
set(gca,'FontSize',16)
%-----------------------------------------%
ax3=nexttile;
load('male.mat')
times = [0 10 20 30 40 50 60];
idx2 = arrayfun( @(x)( find(Time==x) ), times); % indices for times 
net_tg_breakdown_m = U3(idx2,7)-P3(idx2,7);
ffa_uptake_m = UR3(idx2, 6);
bar(times, [ffa_uptake_m net_tg_breakdown_m], 0.75, 'stacked')
colororder(ax3,newcolors_m)
xlabel('Time, min')
ylabel('Rate, mmol/min')
axis([-7.5 67.5 0 10])
ylim([0,1.3]);
legend('Fatty acid uptake', 'Net triglyceride breakdown','location','northwest')
set(gca,'FontSize',16)
FFAcontibution_m=mean(UR3(1001:7001, 6)./(UR3(1001:7001, 6)+(U3(1001:7001,7)-P3(1001:7001,7))))
% = 0.4526
%-----------------------------------------%
ax4=nexttile;
load('female.mat')
times = [0 10 20 30 40 50 60];
idx1 = arrayfun( @(x)( find(Time==x) ), times); % indices for times 
net_tg_breakdown_f = U3(idx1,7)-P3(idx1,7);
ffa_uptake_f = UR3(idx1, 6);
bar(times, [ffa_uptake_f net_tg_breakdown_f], 0.75, 'stacked')
colororder(ax4,newcolors_f)
xlabel('Time, min')
ylabel('Rate, mmol/min')
axis([-7.5 67.5 0 10])
ylim([0,1.3]);
legend('Fatty acid uptake', 'Net triglyceride breakdown','location','northwest')
set(gca,'FontSize',16)
FFAcontibution_f=mean(UR3(1001:7001, 6)./(UR3(1001:7001, 6)+(U3(1001:7001,7)-P3(1001:7001,7))))
% = 0.8865
% exportgraphics(gcf,'Fig8.png','Resolution',600)

%% FIG9: Whole-body lipolysis
figure(6)
N=3; 
C = brewermap(N,'PuBuGn');
newcolors = [C(1,:);C(2,:);C(3,:)];
%-----------------------------------------%
subplot(1,2,1)
load('male.mat')
wholebody_lipolysis_m=F1(:,19)+F2(:,19)+F3(:,19)+F4(:,19)+F5(:,19)+F6(:,19); 
hold on
a1= 100*(F3(:,19)+F2(:,19))./wholebody_lipolysis_m;
a2= 100*(F4(:,19)+F5(:,19))./wholebody_lipolysis_m;
a3= 100*F6(:,19)./wholebody_lipolysis_m;
area(Time,[a1 a2 a3])
hold off
colororder(newcolors)
xlim([0,60])
ylim([0 100])
xlabel('Time, min')
ylabel('% of total lipolysis')
legend('Heart + Muscle','GI + Liver','Adipose tissue')
set(gca,'FontSize',16)
% % average contribution over 60 mins of exercise
% idx1 = arrayfun( @(x)( find(Time==x) ), 0);
% idx2 = arrayfun( @(x)( find(Time==x) ), 60);
% mean([a1(idx1:idx2),a2(idx1:idx2),a3(idx1:idx2)])
% ans = [58.6115   15.3470   26.0415]
%-----------------------------------------%
subplot(1,2,2)
load('female.mat')
wholebody_lipolysis_f=F1(:,19)+F2(:,19)+F3(:,19)+F4(:,19)+F5(:,19)+F6(:,19); 
hold on
a1= 100*(F3(:,19)+F2(:,19))./wholebody_lipolysis_f;
a2= 100*(F4(:,19)+F5(:,19))./wholebody_lipolysis_f;
a3= 100*F6(:,19)./wholebody_lipolysis_f;
a=area(Time,[a1 a2 a3]);
hold off
colororder(newcolors)
xlim([0,60])
ylim([0 100])
xlabel('Time, min')
ylabel('% of total lipolysis')
legend('Heart + Muscle','GI + Liver','Adipose tissue')
set(gca,'FontSize',16)
% % average contribution over 60 mins of exercise
% idx1 = arrayfun( @(x)( find(Time==x) ), 0);
% idx2 = arrayfun( @(x)( find(Time==x) ), 60);
% mean([a1(idx1:idx2),a2(idx1:idx2),a3(idx1:idx2)])
% ans = [26.1295   19.5492   54.3213]
% exportgraphics(gcf,'Fig9.png','resolution',600)