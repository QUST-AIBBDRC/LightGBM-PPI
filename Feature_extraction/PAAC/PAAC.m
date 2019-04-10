function [paac]=PAAC(str,lambda) 
str = strrep(str,'X',''); 
len=length(str);
tt={'A', 'R', 'N', 'D', 'C', 'E', 'Q', 'G', 'H', 'I',  'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V'};
%"Hydrophobicity", "Hydrophilicity", "SideChainMass"
 A = [0.62,  -0.5, 15];R = [-2.53,   3, 101];
 N = [-0.78,  0.2, 58];D = [-0.9,    3, 59];
 C = [0.29,    -1, 47]; E = [-0.74,   3, 73];                  
 Q = [-0.85,  0.2, 72]; G =[0.48,    0, 1]; 
 H = [-0.4,  -0.5, 82]; I = [1.38, -1.8, 57]; 
 L = [1.06,  -1.8, 57];  K = [-1.5,    3, 73]; 
 M = [0.64,  -1.3, 75];  F =[1.19, -2.5, 91]; 
 P = [0.12,     0, 42];  S = [-0.18, 0.3, 31];
 T = [-0.05, -0.4, 45];  W = [0.81, -3.4, 130]; 
 Y = [0.26,  -2.3, 107]; V = [1.08, -1.5, 43];        
H1=[A(1),R(1),N(1),D(1),C(1),E(1),Q(1),G(1),H(1),I(1),L(1),K(1),M(1),F(1),P(1),S(1),T(1),W(1),Y(1),V(1)];
H2=[A(2),R(2),N(2),D(2),C(2),E(2),Q(2),G(2),H(2),I(2),L(2),K(2),M(2),F(2),P(2),S(2),T(2),W(2),Y(2),V(2)];
M=[A(3),R(3),N(3),D(3),C(3),E(3),Q(3),G(3),H(3),I(3),L(3),K(3),M(3),F(3),P(3),S(3),T(3),W(3),Y(3),V(3)];
%Normalization
mean_H1=mean(H1);
std_H1=std(H1,1);
H1=(H1-mean_H1)./(std_H1);

mean_H2=mean(H2);
std_H2=std(H2,1);
H2=(H2-mean_H2)./(std_H2);

mean_M=mean(M);
std_M=std(M,1);
M=(M-mean_M)./(std_M);
data=zeros(1,len);
f=zeros(1,20);
for j=1:len
    for k=1:20
        if strcmp(str(j),tt(k))==1
            data(j)=k; f(k)=f(k)+1 ;
        end
    end
end
Theta=zeros(lambda,len);
H=[H1;H2;M];
for i=1:lambda
    for j=1:len-i
        Theta(i,j)=mean(mean((H(:, data(j))-H(:, data(j+i))).^2));
    end
end
theta=zeros(1,lambda);
for j=1:lambda
    theta(j)=mean(Theta(j,1:(len-j)));
end
f=f/len;
XC=f./(1+0.05*sum(theta));
XC2=(0.05.*theta)./(1+0.05*sum(theta));

paac=[XC,XC2];
paac=paac;
end