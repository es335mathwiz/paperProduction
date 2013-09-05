var                  PI
                     WDOT
                     RHO
                     V
                     F
                     ONE;
parameters LAMBDA, CRHO, RHOBAR, ALPHAPI, PIBAR;
LAMBDA=0.9;
RHOBAR=0.05;
//PSI=0.02;
PIBAR=0.03;
//SIGMA=0.2;
//VBAR=1.0;
//QBAR=1.0;
//GBAR=0.0;
CRHO=0.02;
//CQ=0.01;
//CG=0.5;
ALPHAPI=1.2;
//ALPHAV=0;
//ALPHAQ=0;
//ALPHAS=0;
//RBAR=RHOBAR+PIBAR+PSI;

model;
  ONE = ONE(-1);

  PI = (1-LAMBDA)*PI(-1) + LAMBDA*WDOT;

   WDOT = (1-LAMBDA)*(WDOT(1) ) 
           + LAMBDA * (PI  - CRHO*(RHO-RHOBAR*ONE));

   RHO(1) - RHO = RHOBAR*(RHO - F + PI(1));

  V(1) - V = RHOBAR*V - (F - PI(1) - RHOBAR*ONE);

   F - F(-1) = ALPHAPI*(PI(-1) - PIBAR*ONE); /*should be elag of pi*/
end;

