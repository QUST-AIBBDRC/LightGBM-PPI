clear all
clc
load('data_CTriad_NA.mat');
load('data_CTriad_NB.mat');
load('data_CTriad_PA.mat');
load('data_CTriad_PB.mat');
CTriad_yeast=[[data_CTriad_PA,data_CTriad_PB];[data_CTriad_NA,data_CTriad_NB]];
% CTriad_yeast=[[ones(5594,1);zeros(5594,1)],CTriad_yeast];
save Yeast_CTriad_lag9.mat CTriad_yeast