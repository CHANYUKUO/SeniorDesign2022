%% Final
Q=3;%ml/min
L=50;%cm
D=2;%cm
E=0.25;
Keq1=10;
Keq2=12;
w=2;%min
miu1=(Q/(pi*(D/2)^2))/(E+(1-E)*Keq1)
t1=L/miu1
miu2=(Q/(pi*(D/2)^2))/(E+(1-E)*Keq2)
t2=L/miu2
Rs=(t2-t1)/w
%% Q4
E=2;
n=4;
xf=1;
x=(E-1)/(E^(n+1)-1)*xf