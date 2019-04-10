clear all
clc
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
load property
OriginData=property;
OriginData=zscore(OriginData);
OriginData=OriginData';
num1=numel(proteinB);
lag=9;
Auto_Pa=[];
Auto_Pb=[];
Auto_Na=[];
Auto_Nb=[];
for i=1:num1
[M1]=Auto1(P_proteinA{i},OriginData,lag);
[M2]=Auto2(P_proteinA{i},OriginData,lag);
[M3]=Auto3(P_proteinA{i},OriginData,lag);
M=[M1,M2,M3];
Auto_Pa=[Auto_Pa;M];
clear M;clear M1 M2 M3;
end
for i=1:num1
[M1]=Auto1(P_proteinB{i},OriginData,lag);
[M2]=Auto2(P_proteinB{i},OriginData,lag);
[M3]=Auto3(P_proteinB{i},OriginData,lag);
M=[M1,M2,M3];
Auto_Pb=[Auto_Pb;M];
clear M;clear M1 M2 M3;
end
for i=1:num1
[M1]=Auto1(proteinA{i},OriginData,lag);
[M2]=Auto2(proteinA{i},OriginData,lag);
[M3]=Auto3(proteinA{i},OriginData,lag);
M=[M1,M2,M3];
Auto_Na=[Auto_Na;M];
clear M;clear M1 M2 M3;
end
for i=1:num1
[M1]=Auto1(proteinB{i},OriginData,lag);
[M2]=Auto2(proteinB{i},OriginData,lag);
[M3]=Auto3(proteinB{i},OriginData,lag);
M=[M1,M2,M3];
Auto_Nb=[Auto_Nb;M];
clear M;clear M1 M2 M3;
end
data_Auto=[[Auto_Pa,Auto_Pb];[Auto_Nb,Auto_Na]];
data_Auto=[[ones(5594,1);zeros(5594,1)],data_Auto];
save data_Yeast_Auto_9_exchange.mat data_Auto
save Auto_Yeast_9.mat Auto_Pa Auto_Pb Auto_Na Auto_Nb