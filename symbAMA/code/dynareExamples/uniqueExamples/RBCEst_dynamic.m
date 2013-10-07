function [residual, g1, g2, g3] = RBCEst_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(9, 1);
T33 = y(1)^params(4);
T38 = (y(7)*exp(y(11)))^(1-params(4));
T94 = exp(y(11))*getPowerDeriv(y(7)*exp(y(11)),1-params(4),1);
T106 = y(7)*exp(y(11))*getPowerDeriv(y(7)*exp(y(11)),1-params(4),1);
lhs =1/y(4);
rhs =params(1)*1/y(12)*(1+y(13)-params(3));
residual(1)= lhs-rhs;
lhs =y(4)*params(2)/(1-y(7));
rhs =y(9);
residual(2)= lhs-rhs;
lhs =y(4)+y(6);
rhs =y(3);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =T33*T38;
residual(4)= lhs-rhs;
lhs =y(9);
rhs =(1-params(4))*y(3)*(params(6)-1)/params(6)/y(7);
residual(5)= lhs-rhs;
lhs =y(10);
rhs =params(4)*y(3)*(params(6)-1)/params(6)/y(1);
residual(6)= lhs-rhs;
lhs =y(6);
rhs =y(5)-y(1)*(1-params(3));
residual(7)= lhs-rhs;
lhs =y(8);
rhs =y(3)/y(7);
residual(8)= lhs-rhs;
lhs =y(11);
rhs =params(5)*y(2)+x(it_, 1);
residual(9)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(9, 14);

%
% Jacobian matrix
%

g1(1,4)=(-1)/(y(4)*y(4));
g1(1,12)=(-((1+y(13)-params(3))*params(1)*(-1)/(y(12)*y(12))));
g1(1,13)=(-(params(1)*1/y(12)));
g1(2,4)=params(2)/(1-y(7));
g1(2,7)=y(4)*params(2)/((1-y(7))*(1-y(7)));
g1(2,9)=(-1);
g1(3,3)=(-1);
g1(3,4)=1;
g1(3,6)=1;
g1(4,3)=1;
g1(4,1)=(-(T38*getPowerDeriv(y(1),params(4),1)));
g1(4,7)=(-(T33*T94));
g1(4,11)=(-(T33*T106));
g1(5,3)=(-((1-params(4))*(params(6)-1)/params(6)/y(7)));
g1(5,7)=(-((-((1-params(4))*y(3)*(params(6)-1)/params(6)))/(y(7)*y(7))));
g1(5,9)=1;
g1(6,3)=(-(params(4)*(params(6)-1)/params(6)/y(1)));
g1(6,1)=(-((-(params(4)*y(3)*(params(6)-1)/params(6)))/(y(1)*y(1))));
g1(6,10)=1;
g1(7,1)=1-params(3);
g1(7,5)=(-1);
g1(7,6)=1;
g1(8,3)=(-(1/y(7)));
g1(8,7)=(-((-y(3))/(y(7)*y(7))));
g1(8,8)=1;
g1(9,2)=(-params(5));
g1(9,11)=1;
g1(9,14)=(-1);
end
if nargout >= 3,
%
% Hessian matrix
%

  v2 = zeros(25,3);
v2(1,1)=1;
v2(1,2)=46;
v2(1,3)=(y(4)+y(4))/(y(4)*y(4)*y(4)*y(4));
v2(2,1)=1;
v2(2,2)=166;
v2(2,3)=(-((1+y(13)-params(3))*params(1)*(y(12)+y(12))/(y(12)*y(12)*y(12)*y(12))));
v2(3,1)=1;
v2(3,2)=180;
v2(3,3)=(-(params(1)*(-1)/(y(12)*y(12))));
v2(4,1)=1;
v2(4,2)=167;
v2(4,3)=v2(3,3);
v2(5,1)=2;
v2(5,2)=88;
v2(5,3)=params(2)/((1-y(7))*(1-y(7)));
v2(6,1)=2;
v2(6,2)=49;
v2(6,3)=v2(5,3);
v2(7,1)=2;
v2(7,2)=91;
v2(7,3)=(-(y(4)*params(2)*((-(1-y(7)))-(1-y(7)))))/((1-y(7))*(1-y(7))*(1-y(7))*(1-y(7)));
v2(8,1)=4;
v2(8,2)=1;
v2(8,3)=(-(T38*getPowerDeriv(y(1),params(4),2)));
v2(9,1)=4;
v2(9,2)=85;
v2(9,3)=(-(getPowerDeriv(y(1),params(4),1)*T94));
v2(10,1)=4;
v2(10,2)=7;
v2(10,3)=v2(9,3);
v2(11,1)=4;
v2(11,2)=91;
v2(11,3)=(-(T33*exp(y(11))*exp(y(11))*getPowerDeriv(y(7)*exp(y(11)),1-params(4),2)));
v2(12,1)=4;
v2(12,2)=141;
v2(12,3)=(-(getPowerDeriv(y(1),params(4),1)*T106));
v2(13,1)=4;
v2(13,2)=11;
v2(13,3)=v2(12,3);
v2(14,1)=4;
v2(14,2)=147;
v2(14,3)=(-(T33*(T94+y(7)*exp(y(11))*exp(y(11))*getPowerDeriv(y(7)*exp(y(11)),1-params(4),2))));
v2(15,1)=4;
v2(15,2)=95;
v2(15,3)=v2(14,3);
v2(16,1)=4;
v2(16,2)=151;
v2(16,3)=(-(T33*(T106+y(7)*exp(y(11))*y(7)*exp(y(11))*getPowerDeriv(y(7)*exp(y(11)),1-params(4),2))));
v2(17,1)=5;
v2(17,2)=87;
v2(17,3)=(-((-((1-params(4))*(params(6)-1)/params(6)))/(y(7)*y(7))));
v2(18,1)=5;
v2(18,2)=35;
v2(18,3)=v2(17,3);
v2(19,1)=5;
v2(19,2)=91;
v2(19,3)=(-((-((-((1-params(4))*y(3)*(params(6)-1)/params(6)))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7))));
v2(20,1)=6;
v2(20,2)=3;
v2(20,3)=(-((-(params(4)*(params(6)-1)/params(6)))/(y(1)*y(1))));
v2(21,1)=6;
v2(21,2)=29;
v2(21,3)=v2(20,3);
v2(22,1)=6;
v2(22,2)=1;
v2(22,3)=(-((-((-(params(4)*y(3)*(params(6)-1)/params(6)))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
v2(23,1)=8;
v2(23,2)=87;
v2(23,3)=(-((-1)/(y(7)*y(7))));
v2(24,1)=8;
v2(24,2)=35;
v2(24,3)=v2(23,3);
v2(25,1)=8;
v2(25,2)=91;
v2(25,3)=(-((-((-y(3))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7))));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),9,196);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],9,2744);
end
end
