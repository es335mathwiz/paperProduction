
var xx pi RR gg zz;



parameters psi1 psi2 rhoR kappa tau rhog rhoz beta;

psi1=2.19;
psi2=.30;
rhoR=.84;
kappa=.58;
tau=1/1.86;
rhog=.83;
rhoz=.85;
beta=(1+3.01/100)^-.25;


model; 
0=-gg - tau*pi(+1) + tau*RR + xx - xx(+1);
0= pi - beta*pi(+1) - kappa*xx + kappa*zz; 
0= -(psi1*(1 - rhoR)*pi) - rhoR*RR(-1) + RR - 
   psi2*(1 - rhoR)*xx + psi2*(1 - rhoR)*zz; 
0= -(rhog*gg(-1)) + gg; 
0=-(rhoz*zz(-1)) + zz;
end;
