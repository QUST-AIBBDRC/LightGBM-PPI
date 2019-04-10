function [MBA]=Auto3(proteinA,OriginData,lag)
AAindex = 'ACDEFGHIKLMNPQRSTVWY';
proteinA= strrep(proteinA,'X','');  % omit 'X'
L1=length(proteinA); 
AAnum1= [];
for i=1:L1
AAnum1 = [AAnum1,OriginData(:,findstr(AAindex,proteinA(i)))];
end
mean_=mean(AAnum1,2);
mean_AAnum1=repmat(mean_,1,L1);
AAnum=AAnum1-mean_AAnum1;
MBA_denominator=(1/L1)*sum(AAnum.^2,2);
for i=1:lag
sum_term=(AAnum(:,1:end-i)-AAnum(:,i+1:end)).^2;
MBA_numorator(:,i)=1/2*(1/(L1-i)).*sum(sum_term,2);
end
endMBA_de=repmat(MBA_denominator,1,lag);
MBA1=MBA_numorator./endMBA_de;
MBA=MBA1';
MBA=reshape(MBA1,1,lag*7);