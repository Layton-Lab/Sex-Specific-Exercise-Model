%% Save the data
Y1(:,1:22)=Y(:,23:44);   %brain
Y2(:,1:22)=Y(:,45:66);   %heart
Y3(:,1:22)=Y(:,67:88);   %muscle
Y4(:,1:22)=Y(:,89:110);  %GI
Y5(:,1:22)=Y(:,111:132); %liver
Y6(:,1:22)=Y(:,133:154); %adipose
arterial = Y(:,1:22);    %arterial substrates
hormone = Y(:,155:156);  %glucagon and insulin

[dydt,bflow,MR,P,U,uprel,F,epi,sex] = cellfun(@(t,y) exerciseMod(t,y,WR,ins0,glu0,c0,tstart,tend,sex),num2cell(T),num2cell(Y,2),'uni',0);

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