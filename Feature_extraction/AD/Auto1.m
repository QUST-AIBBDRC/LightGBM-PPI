function [MBA]=Auto1(proteinA,OriginData,lag)

AAindex = 'ACDEFGHIKLMNPQRSTVWY';
proteinA= strrep(proteinA,'X','');  % omit 'X' 
L1=length(proteinA); 
AAnum1= [];
for i=1:L1
AAnum1 = [AAnum1,OriginData(:,findstr(AAindex,proteinA(i)))];
end

% Matrix1=[];
% Matrix2=[];
% bsxfun(@times,H(:,data),[H(:,shuju(i,i:end)),zeros(1,i-1)])
for i=1:lag
sum_term=bsxfun(@times,AAnum1(:,1:end-i),AAnum1(:,i+1:end));
MBA1(:,i)=(1/(L1-i)).*sum(sum_term,2);
end
MBA1=MBA1';
MBA=reshape(MBA1,1,lag*7);