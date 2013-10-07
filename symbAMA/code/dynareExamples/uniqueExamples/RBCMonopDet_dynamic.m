function [residual, g1, g2, g3] = RBCMonopDet_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(8, 1);
lhs =1/y(3);
rhs =params(2)*1/y(10)*(1+y(11)-params(4));
residual(1)= lhs-rhs;
lhs =y(3)*params(3)/(1-y(6));
rhs =y(8);
residual(2)= lhs-rhs;
lhs =y(3)+y(5);
rhs =y(2);
residual(3)= lhs-rhs;
lhs =y(2);
rhs =y(1)^params(5)*(y(6)*exp(params(1)))^(1-params(5));
residual(4)= lhs-rhs;
lhs =y(8);
rhs =(1-params(5))*y(2)*(params(7)-1)/params(7)/y(6);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =params(5)*y(2)*(params(7)-1)/params(7)/y(1);
residual(6)= lhs-rhs;
lhs =y(5);
rhs =y(4)-y(1)*(1-params(4));
residual(7)= lhs-rhs;
lhs =y(7);
rhs =y(2)/y(6);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 11);

%
% Jacobian matrix
%

g1(1,3)=(-1)/(y(3)*y(3));
g1(1,10)=(-((1+y(11)-params(4))*params(2)*(-1)/(y(10)*y(10))));
g1(1,11)=(-(params(2)*1/y(10)));
g1(2,3)=params(3)/(1-y(6));
g1(2,6)=y(3)*params(3)/((1-y(6))*(1-y(6)));
g1(2,8)=(-1);
g1(3,2)=(-1);
g1(3,3)=1;
g1(3,5)=1;
g1(4,2)=1;
g1(4,1)=(-((y(6)*exp(params(1)))^(1-params(5))*getPowerDeriv(y(1),params(5),1)));
g1(4,6)=(-(y(1)^params(5)*exp(params(1))*getPowerDeriv(y(6)*exp(params(1)),1-params(5),1)));
g1(5,2)=(-((1-params(5))*(params(7)-1)/params(7)/y(6)));
g1(5,6)=(-((-((1-params(5))*y(2)*(params(7)-1)/params(7)))/(y(6)*y(6))));
g1(5,8)=1;
g1(6,2)=(-(params(5)*(params(7)-1)/params(7)/y(1)));
g1(6,1)=(-((-(params(5)*y(2)*(params(7)-1)/params(7)))/(y(1)*y(1))));
g1(6,9)=1;
g1(7,1)=1-params(4);
g1(7,4)=(-1);
g1(7,5)=1;
g1(8,2)=(-(1/y(6)));
g1(8,6)=(-((-y(2))/(y(6)*y(6))));
g1(8,7)=1;
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],8,121);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],8,1331);
end
end
