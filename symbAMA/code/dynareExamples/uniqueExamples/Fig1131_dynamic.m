function [residual, g1, g2, g3] = Fig1131_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(2, 1);
T35 = params(5)*y(4)^(-params(6))*(1+params(2))/(1+params(2));
T50 = (1-params(7))*(1-params(1))/(1-params(1))+params(9)*params(8)*(1-params(3))/(1-params(1))*y(1)^(params(8)-1);
lhs =y(3);
rhs =params(9)*y(1)^params(8)+y(1)*(1-params(7))-y(2)-params(4);
residual(1)= lhs-rhs;
lhs =y(2)^(-params(6));
rhs =T35*T50;
residual(2)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(2, 4);

%
% Jacobian matrix
%

g1(1,2)=1;
g1(1,1)=(-(1-params(7)+params(9)*getPowerDeriv(y(1),params(8),1)));
g1(1,3)=1;
g1(2,2)=getPowerDeriv(y(2),(-params(6)),1);
g1(2,4)=(-(T50*(1+params(2))/(1+params(2))*params(5)*getPowerDeriv(y(4),(-params(6)),1)));
g1(2,1)=(-(T35*params(9)*params(8)*(1-params(3))/(1-params(1))*getPowerDeriv(y(1),params(8)-1,1)));
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],2,16);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],2,64);
end
end
