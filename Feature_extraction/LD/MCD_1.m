clear all
clc
load('CTriad_Yeast.mat');
label=[ones(5594,1);zeros(5594,1)];
A4=[[CTriad_Pa,CTriad_Pb];[CTriad_Na,CTriad_Nb]];
CTriad_1Y=[A4];
CTriad_1_new=[label,CTriad_1Y];
save  CTriad_1Y CTriad_1_new