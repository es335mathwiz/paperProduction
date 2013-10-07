% Kiyotaki - Moore "Credit Cycle" JPE 1997  
%
% Nicola Viegi
% Pretoria, 2010

%----------------------------------------------------------------
% 0. Housekeeping (close all graphic windows)
%----------------------------------------------------------------

close all;

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var q b k;
varexo e;

parameters a, phi, R, lamda, pai, v, qss, bss, kss;

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------

a   = 1;
phi = 20;
R   = 1.01;
lamda = 0.975;
pai = 0.1 ;  
v  = 2;
qss  = (R/(R-1))*(pai*a - (1-lamda)*(1- R + pai*R)*phi )/(lamda*pai + (1-lamda)*(1- R + pai*R));
kss  = qss * (R-1)/R + v;
bss  = ((a + lamda*phi - phi)/(R-1)) * kss ;

%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model; 
q = q(+1)/R + (k - v);
k = (pai/(q + phi - q(+1)/R))*( (a+lamda*phi + q)*k(-1) - R*b(-1)) + (1-pai)*lamda*k(-1);
b =  R*b(-1) + q*(k - k(-1)) + phi*(k -lamda*k(-1)) - a*(1+e)*k(-1);
end;

%----------------------------------------------------------------
% 4. Computation
%----------------------------------------------------------------

initval;
q = qss;
k = kss;
b = bss;
e = 0;
end;

steady;
check;

shocks;
var e;
periods 1;
values 0.01;
end;

check;

steady;

simul(periods=400);

figure
plot(k(2:40)/kss)
hold on
plot(b(2:40)/bss,'.')
plot(q(2:40)/qss,'--')
legend('K/K*','B/B*','Q/Q*')

