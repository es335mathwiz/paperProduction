
// FILENAME: ifs1.mod: Dynare program for positive production technology 
//                     and monetary policy shocks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%      Essays on the Monetary Economics of Low Income Countries           %
%                                                                         % 
% Essay Number 2: The Interaction of formal and Informal Financial Markets%
%                 in Quasi-Emerging Market Economies                      %
%                                                                         %
%                     Harold P.E. Ngalawa                                 %
%                                                                         %
%     School of Economics, University of cape Town                        %
%                                                                         %
%                        February 2010                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%--------------------------------------------------------------------------
% 0. Housekeeping (close graphics windows)
%--------------------------------------------------------------------------

close all;

%--------------------------------------------------------------------------
% 1. Set simulation periods                                 
%--------------------------------------------------------------------------

periods 5000;

%--------------------------------------------------------------------------
% 2. Define variables
% Endogenous (var) and exogenous (varexo)
%--------------------------------------------------------------------------

var A C epie K Lf Li M N P Rrr Rdf Rlf Rli Rnr varpi W Y;

//A     : Technology factor
//C     : Consumption
//epie  : expected inflation
//K     : Capital stock
//Lf    : Formal financial sector loans
//Li    : Informal financial sector loans
//M     : Money supply
//N     : Labour supply/demand
//P     : Price level
//Rrr   : Real interest rates
//Rdf   : Commercial bank deposit rates
//Rlf   : Commercial bank base lending rates
//Rli   : Informal financial sector lending rates
//Rnr   : Bank rate
//varpi : Proportion of aggregate demand for FFS loans that succeeeds in 
//        getting the FFS loans
//W     : Wage rate
//Y     : Output

varexo eA mu;

//eA    : Technology shock
//mu    : Monetary policy shock

%--------------------------------------------------------------------------
% 3. Define parameters and assign parameter values 
%--------------------------------------------------------------------------

parameters alpha beta delta eta gamma kyu phi psi rho vah val zeta chi1 chi2;

%--------------------------------------------------------------------------
% 4. Calibration
%--------------------------------------------------------------------------

//The first five are determined from the literature
alpha = 0.37; //Share of capital in production function 
beta = 0.99; //discount rate
delta = 1; //depreciation
eta = 0.91; //autoregressive parameter shock 
phi = 3; //utility function; leisure parameter

//The next nine are calibrated
gamma = 3; //weight on real money balances
kyu = 0.85; //Probability of IFS loan repayment
psi = 0.8; //lagrangian multiplier in a firm's cost minimisation function
rho = 0.15; //proportion of high risk borrowers 
vah = 0.8; //risk factor for high risk borrowers (substitution factor of FFSL and IFSL)
val = 0.95; //risk factor (probability of success) for low risk individuals
zeta = 0.1; //mark-up over the bank rate to obtain the base lending rate
chi1 = 0.98; //factor of inertia in the base lending rate
chi2 = 0.3; //weight of expected change in output in the monetary policy rule

%--------------------------------------------------------------------------
% 5. Model
%--------------------------------------------------------------------------

model;

 1/C = beta*(1+Rdf)*(1/C(+1));  //1-intertemporal consumption function

 N = 1-((phi*C)/W);  //2-labour supply equation 

 M = P*gamma*beta*((C(+1))/Rdf);  //3-money demand function

 1 + Rdf = (1 + Rli)*kyu;  //4-equilibrium position of a household's financial portfolio

 K = ((rho*vah(-1))+((1-rho)*val(-1)))*(Lf(-1)+Li(-1));  //5-aggregate capital stock equation

 Y = exp(A)*(K^alpha)*(N^(1-alpha));  //6-production function

 A = eta*A(-1) + eA;  //7-equation describing evolution of technology factor 

 W =(1-alpha)*psi*(Y/N);  //8-wage equation

 Lf = (varpi/vah)*((((1-alpha)*(1+Rlf)*(K(+1)^alpha))/
      (alpha*vah*W(+1)*N(+1)))^(1/(alpha-1)));  //9-FFS loans supply

 Li = (2-varpi)*(((rho/vah)*((1/vah)^(1/(alpha-1))))+
      (((1-rho)/val)*((1/val)^(1/(alpha-1)))))*
      ((((1-alpha)*(1+Rli)*kyu*(K(+1)^alpha))/(alpha*W(+1)*N(+1)))^(1/(alpha-1)));
      //10-IFS loans supply

 varpi*Rlf = Rnr; //11-proportion of demand for FFS loans that succeeds in getting the loans
 
 Rlf = Rnr + zeta; //12-base lending rate
  
 Rrr = alpha*exp(A(+1))*(K(+1)^(alpha-1))*(N(+1)^(1-alpha)); //13-real interest rate
 
 Y = C + K(+1)-(1-delta)*K; //14-income accounting identity
 
 Rnr = chi1*Rrr+chi2*(Y(+1)-Y)+(1-chi2)*epie+mu; //14-monetary policy rule

 epie=Rnr(+1)-Rrr(+1); //15-Expected inflation

 P*C = M; //16-post-equilibrium identity
 
end;

initval;

C = 0.8;
K = 0.2;
N = 0.3;    
Rdf = 0.075;
varpi = 0.7;
W = 0.3;

end;

shocks;
 var eA; stderr 0.25;
 var mu; stderr 0.25;
end;

check;

steady;

//stoch_simul(hp_filter = 1600, order = 1, IRF=40);
