%=========================================================================%
% Bernanke et al. (1999, Handbook of Macroeconomics)
% Ambrogio Cesa-Bianchi, July 2012
%=========================================================================%
% If you find any bugs when using this file or want to give me comments 
% and suggestions you can email me at ambrogio.cesabianchi@gmail.com


var y c i g ce n rk r q k x a h pi rn ;

varexo eM eG eA;

parameters beta eta alpha delta omega eps G_Y C_Y I_Y Ce_Y Y_N X rhoA rhoG psi K_N R gamma mu nu theta rho S kappa;
    C_Y	    =	0.61        ; 
    Ce_Y	  =	0.01        ; 
    I_Y 	  =	0.18    	;
    G_Y 	  =	0.20        ;
    K_N 	  =	2.00        ;
    Y_N 	  =	0.28        ;       
    X   	  =	1.10        ;
    beta      = 0.99        ;
    R         = 1/beta      ;
    alpha     = 0.35        ;
    eta       = 3           ;
    omega     = 0.99        ;
    delta     = 0.025       ;
    rhoA      = 0.999       ;
    rhoG      = 0.95        ;
    psi       = 0.25        ;
    Rk        = R + 0.02    ;   % 200 b.p.
    gamma     = 1 - 0.0272  ;
    mu        = 0.12        ;
    theta     = 0.75        ;
    rho       = 0.90        ;
    S         = 0.11        ;
    kappa     = ((1-theta)/theta)*(1-theta*beta);
    eps       = (1-delta)/((1-delta) + ((alpha/X)*(Y_N/K_N)));
    nu        = 0.5         ;


model;
    y = C_Y*c + I_Y*i + G_Y*g + Ce_Y*ce;            //4.14
    c = -r + c(+1);                                 //4.15       
    rn = r + pi(+1);                                //nominal int. rate
    ce = n;                                         //4.16
    rk(+1) - r = -nu*(n -(q + k));                  //4.17
    rk = (1-eps)*(y - k(-1) - x) + eps*q - q(-1);   //4.18
    q = psi*(i - k(-1));                            //4.19    
    y = a + alpha*k(-1) + (1-alpha)*omega*h;        //4.20
    y - h - x - c = (eta^(-1))*h;                   //4.21
    pi = kappa*(-x) + beta*pi(+1);                  //4.22
    k = delta*i + (1-delta)*k(-1);                  //4.23
    n = gamma*R*K_N*(rk - r(-1)) + r(-1) + n(-1);   //4.24
    rn = rho*rn(-1) + S*pi(-1) + eM;                //4.25
    g = rhoG*g(-1) + eG;                            //4.26
    a = rhoA*a(-1) + eA;                            //4.27
end;

check;
steady;

shocks;
    var eG; stderr 0.1;
    var eA; stderr 0.1;
    var eM; stderr 0.1;
end;

stoch_simul(order=1,irf=24,nograph); 

