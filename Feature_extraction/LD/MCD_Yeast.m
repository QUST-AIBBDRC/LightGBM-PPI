clear all
clc
load N_proteinA.mat 
load N_proteinB.mat
load P_proteinA.mat
load P_proteinB.mat
num1=numel(P_proteinA)
MCD_Pa=[];
MCD_Pb=[];
MCD_Na=[];
MCD_Nb=[];
for i=1:num1
[M1]=MCDZD(P_proteinA{i});
M=[M1];
MCD_Pa=[MCD_Pa;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(P_proteinB{i});
M=[M1];
MCD_Pb=[MCD_Pb;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(proteinA{i});
M=[M1];
MCD_Na=[MCD_Na;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(proteinB{i});
M=[M1];
MCD_Nb=[MCD_Nb;M];
clear M;clear M1;
end
data_MCD=[[MCD_Pa,MCD_Pb];[MCD_Nb,MCD_Na]];
data_MCD=[[ones(5594,1);zeros(5594,1)],data_MCD];
save data_Yeast_MCD_GBM.mat data_MCD
save MCD_Yeast.mat MCD_Pa MCD_Pb MCD_Na MCD_Nb
