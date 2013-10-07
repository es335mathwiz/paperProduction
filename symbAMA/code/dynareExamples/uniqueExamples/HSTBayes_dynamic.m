function [residual, g1, g2, g3] = HSTBayes_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(15, 1);
lhs =y(19);
rhs =params(3)+y(18);
residual(1)= lhs-rhs;
lhs =y(19)*params(6);
rhs =1;
residual(2)= lhs-rhs;
lhs =y(7);
rhs =(1+params(1))*y(8)-params(1)*y(1);
residual(3)= lhs-rhs;
lhs =y(9);
rhs =y(1)*params(2)+y(8)*(1-params(2));
residual(4)= lhs-rhs;
lhs =y(10);
rhs =params(3)*y(2)+y(11);
residual(5)= lhs-rhs;
lhs =y(8)+y(11);
rhs =y(18)*y(2)+y(12);
residual(6)= lhs-rhs;
lhs =y(15);
rhs =params(5)-y(7);
residual(7)= lhs-rhs;
lhs =y(16);
rhs =(1+params(1))*y(15)+(1-params(2))*y(17);
residual(8)= lhs-rhs;
lhs =y(17);
rhs =params(6)*(params(2)*y(24)-params(1)*y(22));
residual(9)= lhs-rhs;
lhs =y(16);
rhs =y(19)*params(6)*y(23);
residual(10)= lhs-rhs;
lhs =y(12);
rhs =params(4)+y(14)+y(13);
residual(11)= lhs-rhs;
lhs =y(14);
rhs =params(9)*x(it_, 2)+(params(7)+params(8))*y(4)-params(7)*params(8)*y(5);
residual(12)= lhs-rhs;
lhs =y(13);
rhs =params(12)*x(it_, 1)+(params(10)+params(11))*y(3)-params(10)*params(11)*y(6);
residual(13)= lhs-rhs;
lhs =y(20);
rhs =y(4);
residual(14)= lhs-rhs;
lhs =y(21);
rhs =y(3);
residual(15)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(15, 26);

%
% Jacobian matrix
%

g1(1,18)=(-1);
g1(1,19)=1;
g1(2,19)=params(6);
g1(3,7)=1;
g1(3,8)=(-(1+params(1)));
g1(3,1)=params(1);
g1(4,8)=(-(1-params(2)));
g1(4,1)=(-params(2));
g1(4,9)=1;
g1(5,2)=(-params(3));
g1(5,10)=1;
g1(5,11)=(-1);
g1(6,8)=1;
g1(6,2)=(-y(18));
g1(6,11)=1;
g1(6,12)=(-1);
g1(6,18)=(-y(2));
g1(7,7)=1;
g1(7,15)=1;
g1(8,15)=(-(1+params(1)));
g1(8,16)=1;
g1(8,17)=(-(1-params(2)));
g1(9,22)=(-(params(6)*(-params(1))));
g1(9,17)=1;
g1(9,24)=(-(params(6)*params(2)));
g1(10,16)=1;
g1(10,23)=(-(y(19)*params(6)));
g1(10,19)=(-(params(6)*y(23)));
g1(11,12)=1;
g1(11,13)=(-1);
g1(11,14)=(-1);
g1(12,4)=(-(params(7)+params(8)));
g1(12,14)=1;
g1(12,26)=(-params(9));
g1(12,5)=params(7)*params(8);
g1(13,3)=(-(params(10)+params(11)));
g1(13,13)=1;
g1(13,25)=(-params(12));
g1(13,6)=params(10)*params(11);
g1(14,4)=(-1);
g1(14,20)=1;
g1(15,3)=(-1);
g1(15,21)=1;
end
if nargout >= 3,
%
% Hessian matrix
%

  v2 = zeros(4,3);
v2(1,1)=6;
v2(1,2)=444;
v2(1,3)=(-1);
v2(2,1)=6;
v2(2,2)=44;
v2(2,3)=v2(1,3);
v2(3,1)=10;
v2(3,2)=491;
v2(3,3)=(-params(6));
v2(4,1)=10;
v2(4,2)=591;
v2(4,3)=v2(3,3);
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),15,676);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],15,17576);
end
end
