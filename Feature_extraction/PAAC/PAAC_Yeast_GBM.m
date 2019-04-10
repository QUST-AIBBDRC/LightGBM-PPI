clear all
clc
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
num1=numel(P_proteinA);
result_1=[];
result_11=[];
result_2=[];
result_22=[];
lambda=3;
 for i=1:num1
     result1=PAAC(P_proteinA{i},lambda);
     result11=PAAC(P_proteinB{i},lambda);
     result_1=[result_1;result1];
     result1=[];
     result_11=[result_11;result11];
     result11=[];
 end
  for i=1:num1
     result2=PAAC(proteinA{i},lambda);
     result22=PAAC(proteinB{i},lambda);
     result_2=[result_2;result2];
     result2=[];
     result_22=[result_22;result22];
     result22=[];
  end
  Pa=result_1;
  Pb=result_11;
  Na=result_2;
  Nb=result_22;
 Yeast_PAAC=[[Pa,Pb];[Nb,Na]];
Yeast_PAAC=[[ones(5594,1);zeros(5594,1)],Yeast_PAAC];
save data_Yeast_PAAC_3_exchange.mat Yeast_PAAC
save PAAC_Yeast_3.mat  Pa Pb Na Nb

