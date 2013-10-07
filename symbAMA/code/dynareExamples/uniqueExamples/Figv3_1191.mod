%----------------------------------------------------------------
% Experiment  : Unforseen increase in g at t=0
%----------------------------------------------------------------


// This program replicates figure 11.9.1 from chapter 11 of RMT3 by Ljungqvist and Sargent

// Dynare records the endogenous variables with the following convention. Say N is the number of simulations(sample)
//Index 1 : Initial values (steady sate)
//Index 2 to N+1 : N simulated values
//Index N+2 : Temnial Value (Steady State)
// Warning:  we align c, k, and the taxes to exploit the dynare syntax. In Dynare the timing of the variable reflects the date 
//when the variable is decided. For instance the capital stock for time 't' is decided in time 't-1'(end of period). So a statement like 
// k(t+1) = i(t) + (1-del)*k(t) would translate to " k(t) = i(t) +(1-del)*k(t-1)" in the code. 

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

//Declares the endogenous variables consumption ('c') capital stock (k);
var c k n;
//declares the exogenous variables //  consumption tax ('tauc'), capital tax('tauk'), government spending('g')
//varexo tauc tauk taun g; make parameters
parameters tauc tauk taun g; 
g = .2;
tauc = 0;
tauk = 0;
taun=0;

parameters bet gam del alpha A B;

%----------------------------------------------------------------
% 2. Calibration and alignment convention
%----------------------------------------------------------------

bet=.95;  // discount factor
gam=1;    // CRRA parameter 
del=.2;  //  depreciation rate
alpha=.33; //  capital's share
A=1;    // productivity
B=3; // coeffecient on leisure




// Alignment convention:
// g tauc tauk taun are now columns of ex_. Because of a bad design decision
// the date of ex_(1,:) doesn't necessarily match the date in endogenous variables. Whether they match depends
// on the number of lag periods in endogenous versus exogenous variables.

// These decisions and the timing conventions mean that 
// k(1) records the initial steady state, while k(102) records the terminal steady state values.
// For j > 1, k(j) records the variables for j-1th smimulation where the capital stock decision 
//taken in j-1 th simulation i.e stock at the begining of period j.
// The variable ex_ also follows a different timing convention i.e ex_(j,:) records the value of exogenous variables in the j th simualtion. 
//The jump in the government policy is reflected in ex_(10,1) for instance.

%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model;


//Feasibility
k=A*k(-1)^alpha*n^(1-alpha)+(1-del)*k(-1)-c-g;

//Euler equation
c^(-gam)= bet*(c(+1)^(-gam))*((1+tauc)/(1+tauc(+1)))*((1-del) + (1-tauk(+1))*alpha*A*k^(alpha-1)*n(+1)^(1-alpha));

//Consumption leisure choice
B/c^(-gam)=(1-taun)*((1-alpha)*A*k(-1)^(alpha)*n^(-alpha))*(1+tauc)^-1;

end;

%----------------------------------------------------------------
% 4. Computation
%----------------------------------------------------------------

initval;
k=1.5;
c=0.6;
g = .2;
n=1.02;
tauc = 0;
tauk = 0;
taun=0;
end;
steady; // put this in if you want to start from the initial steady state, comment it out to start from the indicated values

endval; // The following values determine the new steady state after the shocks.
k=1.5;
c=0.6;
g =.4;
n=1.02;
tauc =0;
tauk =0;
taun=0;
end;

steady; // We use steady again and the enval provided are initial guesses for dynare to compute the ss.


// now solve the model
simul(periods=100);

