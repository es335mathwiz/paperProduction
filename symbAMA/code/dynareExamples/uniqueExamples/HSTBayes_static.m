function [residual, g1, g2] = HSTBayes_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 15, 1);

%
% Model equations
%

lhs =y(13);
rhs =params(3)+y(12);
residual(1)= lhs-rhs;
lhs =y(13)*params(6);
rhs =1;
residual(2)= lhs-rhs;
lhs =y(1);
rhs =(1+params(1))*y(2)-params(1)*y(3);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =y(3)*params(2)+y(2)*(1-params(2));
residual(4)= lhs-rhs;
lhs =y(4);
rhs =params(3)*y(4)+y(5);
residual(5)= lhs-rhs;
lhs =y(2)+y(5);
rhs =y(12)*y(4)+y(6);
residual(6)= lhs-rhs;
lhs =y(9);
rhs =params(5)-y(1);
residual(7)= lhs-rhs;
lhs =y(10);
rhs =(1+params(1))*y(9)+(1-params(2))*y(11);
residual(8)= lhs-rhs;
lhs =y(11);
rhs =params(6)*(params(2)*y(11)-params(1)*y(9));
residual(9)= lhs-rhs;
lhs =y(10);
rhs =y(13)*params(6)*y(10);
residual(10)= lhs-rhs;
lhs =y(6);
rhs =params(4)+y(8)+y(7);
residual(11)= lhs-rhs;
lhs =y(8);
rhs =params(9)*x(2)+y(8)*(params(7)+params(8))-params(7)*params(8)*y(14);
residual(12)= lhs-rhs;
lhs =y(7);
rhs =params(12)*x(1)+y(7)*(params(10)+params(11))-params(10)*params(11)*y(15);
residual(13)= lhs-rhs;
lhs =y(14);
rhs =y(8);
residual(14)= lhs-rhs;
lhs =y(15);
rhs =y(7);
residual(15)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(15, 15);

%
% Jacobian matrix
%

  g1(1,12)=(-1);
  g1(1,13)=1;
  g1(2,13)=params(6);
  g1(3,1)=1;
  g1(3,2)=(-(1+params(1)));
  g1(3,3)=params(1);
  g1(4,2)=(-(1-params(2)));
  g1(4,3)=1-params(2);
  g1(5,4)=1-params(3);
  g1(5,5)=(-1);
  g1(6,2)=1;
  g1(6,4)=(-y(12));
  g1(6,5)=1;
  g1(6,6)=(-1);
  g1(6,12)=(-y(4));
  g1(7,1)=1;
  g1(7,9)=1;
  g1(8,9)=(-(1+params(1)));
  g1(8,10)=1;
  g1(8,11)=(-(1-params(2)));
  g1(9,9)=(-(params(6)*(-params(1))));
  g1(9,11)=1-params(6)*params(2);
  g1(10,10)=1-y(13)*params(6);
  g1(10,13)=(-(params(6)*y(10)));
  g1(11,6)=1;
  g1(11,7)=(-1);
  g1(11,8)=(-1);
  g1(12,8)=1-(params(7)+params(8));
  g1(12,14)=params(7)*params(8);
  g1(13,7)=1-(params(10)+params(11));
  g1(13,15)=params(10)*params(11);
  g1(14,8)=(-1);
  g1(14,14)=1;
  g1(15,7)=(-1);
  g1(15,15)=1;
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],15,225);
end
end
