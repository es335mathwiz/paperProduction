// Lesotho's RBC Model: Indivisible Domestic and Exported Labour 
% *************************************************************************

% PhD Thesis Work by T. Tlelima, 
% School of Economics, University of Cape Town
% Date: 30 July 2009


% The following variables and parameters are defined.  
                    
// VARIABLES: 
// Deviations from steady state values.
                                                          
% y = output (gdp);                                                        
% c = consumption;
% x = net exports;
% k = capital; 
% b = foreign claims;
% h = total hours of labour;
% hd = hours of labour to domestic economy; 
% hf = hours of labour exports; 
% r = rate of return on capital;                                               
% wd = domestic wage rate;
% wf = foreign wage rate;                                                    
% z = productivity/technology.                                                
                                 
// Steady State Variables
                                                                           
% Ybar = output; 
% Cbar = consumption;                                                               
% Xbar = net exports;                                          
% Kbar = capital;
% Bbar = foreign claims;
% Hbar = total hours of labour; 
% Hdbar = domestic hours of labour;
% Hfbar = foreign hours of labour;
% Rbar = return on capital;                                         
% Wdbar = domestic wage rate;
% Wfbar = foreign wage rate;


// PARAMETERS OF THE MODEL

% alpha1 = disutility of domestic labour parameter;
% alpha2 = disutility of foreign labour parameter;
% beta = discount factor;
% delta = annual rate of depreciation; 
% theta = share of capital in output; 
% rstar = interntaional interest rate; 
% psi = capital adjustment cost parameter;
% phi = elasticity of interest rate to external debt;  
% rhoz = AR(1) coefficient of TP;
% rhow = AR(1) coefficient of foreign wage;                                           
%**************************************************************************

%-----------------------------------------------------
% 0. Housekeeping (close graphics windows)
%-----------------------------------------------------

close all;

%-----------------------------------------------------
% 1. Define variables
% Endogenous (var) and exogenous (varexo)
%-----------------------------------------------------

var c wd k b r hd x hf y wf z; 

varexo ez ew; 

%-----------------------------------------------------
% 3. Define parameters and asign parameter values 
%-----------------------------------------------------

parameters 

alpha1, alpha2, beta, delta, theta, phi, psi, rstar, rhow, rhoz,

Cbar, Bbar, Hdbar, Hfbar, Hbar, Kbar, Rbar, Wdbar, Wfbar, Xbar, Ybar; 

  
% Setting parameter values; annual frequency is assumed.

% Parameter and exogenous variable values
 
alpha1 = -2;
alpha2 = 2*alpha1; //disutility of mine labour assumed 2times of domestic labour.
beta = 0.95;
delta = 0.10;
theta = 0.30;  //Consistent with SA's reported values im Liu and Gupta 2007
phi = 0.01;
psi = 0.028;  //Mendoza's value 
rstar = 0.04;
rhow = 0.41;  //OLS estimate from detrended real miners earnings.
rhoz = 0.41;  //Mendoza's average for developing countries in Uribe 2007.

% Steady State values

Wdbar = 0.94;
Wfbar = 1.88;  // =Wdbar*alpha2/alpha1;
Hdbar = 0.143;
Hfbar = 0.190;
Hbar = 0.333;
Cbar = 0.47;
Bbar =  -1.0;
Kbar = 0.38; 
Rbar = 0.15;
Xbar = -0.31;
Ybar = 0.20; 

%-----------------------------------------------------
% 4. Defining the model 
%-----------------------------------------------------

model(linear);

/* Model of 9 variables + 2 stochastic processes: 
{c, k, b, r, wd, x, hf, hd, y} and {wf, z} */
 
(alpha1-alpha2)*Cbar*c = Wfbar*wf - Wdbar*wd;
(1+beta)*psi*Kbar*k = c - c(+1) + beta*Rbar*r(+1)+ beta*psi*Kbar*k(+1) 
+ psi*Kbar*k(-1);
beta*phi*Bbar*b = c - c(+1); 
r = z + (theta-1)*k(-1) + (1-theta)*hd;
wd = z + theta*k(-1)- theta*hd ;
Xbar*x = Bbar*b -(1+rstar)*Bbar*b(-1) + (2*phi*Bbar^2)*b(-1) - Wfbar*Hfbar*(wf+hf);
Wfbar*Hfbar*hf = Bbar*b + Cbar*c + Kbar*k - (1-delta)*Kbar*k(-1) + 
(2*phi*Bbar^2)*b(-1)-(1+rstar)*Bbar*b(-1)- Wfbar*Hfbar*wf - Ybar*y; //reorganised aggregate resource constraint
Hdbar*hd = -Hfbar*hf;
y = z + theta*k(-1) + (1-theta)*hd;
wf = rhow*wf(-1) + ew;
z =  rhoz*z(-1) + ez;

end;

steady;


%-----------------------------------------------------
% 6. Calibration of Shocks
%-----------------------------------------------------

shocks;

var ew = 0.0015; 
var ez; stderr 0.04; // Mendoza's.

end;

%-----------------------------------------------------
% 7. Simulation
% check command prints eigenvalues
%-----------------------------------------------------

check;
stoch_simul(periods = 2000);
%stoch_simul(hp_filter = 1600, periods = 2000); 
