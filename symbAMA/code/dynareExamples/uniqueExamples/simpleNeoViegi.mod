// new keynesian model with taylor rule 

var p, x, i;
varexo u;

parameters sigma beta, alpha, lambda, a, b;

sigma = 0.5;
beta = 0.99;
alpha = 0.2;
lambda = 0.8;
a = 0.5 ; 
b = 1.5;
phi = 0.1;
  

model;
i = a*x + b*p;
x = lambda*x(-1)+(1-lambda)*x(+1) - sigma*(i - p(+1))+ e;
p = beta*(lambda*p(-1)+(1-lambda)*p(+1)) + alpha*x + u; 
end;

initval;
p = 0;
x = 0;
u = 0;
end;

shocks;
var e; stderr 0.09;
var u; stderr 0.09;
var e, u = phi*0.09*0.09;
end;


stoch_simul(periods=210, irf=20);
