function [residual, g1, g2] = RBCEst_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 9, 1);

%
% Model equations
%

lhs =1/y(2);
rhs =1/y(2)*params(1)*(1+y(8)-params(3));
residual(1)= lhs-rhs;
lhs =y(2)*params(2)/(1-y(5));
rhs =y(7);
residual(2)= lhs-rhs;
lhs =y(2)+y(4);
rhs =y(1);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =y(3)^params(4)*(y(5)*exp(y(9)))^(1-params(4));
residual(4)= lhs-rhs;
lhs =y(7);
rhs =(1-params(4))*y(1)*(params(6)-1)/params(6)/y(5);
residual(5)= lhs-rhs;
lhs =y(8);
rhs =params(4)*y(1)*(params(6)-1)/params(6)/y(3);
residual(6)= lhs-rhs;
lhs =y(4);
rhs =y(3)-y(3)*(1-params(3));
residual(7)= lhs-rhs;
lhs =y(6);
rhs =y(1)/y(5);
residual(8)= lhs-rhs;
lhs =y(9);
rhs =y(9)*params(5)+x(1);
residual(9)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(9, 9);

%
% Jacobian matrix
%

  g1(1,2)=(-1)/(y(2)*y(2))-(1+y(8)-params(3))*params(1)*(-1)/(y(2)*y(2));
  g1(1,8)=(-(1/y(2)*params(1)));
  g1(2,2)=params(2)/(1-y(5));
  g1(2,5)=y(2)*params(2)/((1-y(5))*(1-y(5)));
  g1(2,7)=(-1);
  g1(3,1)=(-1);
  g1(3,2)=1;
  g1(3,4)=1;
  g1(4,1)=1;
  g1(4,3)=(-((y(5)*exp(y(9)))^(1-params(4))*getPowerDeriv(y(3),params(4),1)));
  g1(4,5)=(-(y(3)^params(4)*exp(y(9))*getPowerDeriv(y(5)*exp(y(9)),1-params(4),1)));
  g1(4,9)=(-(y(3)^params(4)*y(5)*exp(y(9))*getPowerDeriv(y(5)*exp(y(9)),1-params(4),1)));
  g1(5,1)=(-((1-params(4))*(params(6)-1)/params(6)/y(5)));
  g1(5,5)=(-((-((1-params(4))*y(1)*(params(6)-1)/params(6)))/(y(5)*y(5))));
  g1(5,7)=1;
  g1(6,1)=(-(params(4)*(params(6)-1)/params(6)/y(3)));
  g1(6,3)=(-((-(params(4)*y(1)*(params(6)-1)/params(6)))/(y(3)*y(3))));
  g1(6,8)=1;
  g1(7,3)=(-(1-(1-params(3))));
  g1(7,4)=1;
  g1(8,1)=(-(1/y(5)));
  g1(8,5)=(-((-y(1))/(y(5)*y(5))));
  g1(8,6)=1;
  g1(9,9)=1-params(5);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],9,81);
end
end
