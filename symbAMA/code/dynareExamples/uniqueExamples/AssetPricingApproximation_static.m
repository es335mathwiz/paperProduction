function [residual, g1, g2] = AssetPricingApproximation_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 5, 1);

%
% Model equations
%

T25 = exp(y(1)*(-params(2))/params(3)+(params(2)-1)*log(exp(y(1))*(1+y(3))/y(3)));
T26 = params(1)^params(2)*T25;
T57 = params(1)^params(2)*T25*((-params(2))/params(3)+params(2)-1);
T73 = params(1)^params(2)*T25*(params(2)-1)*(y(3)*exp(y(1))-exp(y(1))*(1+y(3)))/(y(3)*y(3))/(exp(y(1))*(1+y(3))/y(3));
lhs =y(3);
rhs =exp(y(1))*(1+y(3))*T26;
residual(1)= lhs-rhs;
lhs =y(4);
rhs =T26*(1+y(4))*exp(y(2));
residual(2)= lhs-rhs;
lhs =y(1);
rhs =params(4)+y(5)+x(1);
residual(3)= lhs-rhs;
lhs =y(2);
rhs =params(5)+y(5)*params(7)+x(3);
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(6)+x(2);
residual(5)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(5, 5);

%
% Jacobian matrix
%

  g1(1,1)=(-(exp(y(1))*(1+y(3))*T26+exp(y(1))*(1+y(3))*T57));
  g1(1,3)=1-exp(y(1))*(T26+(1+y(3))*T73);
  g1(2,1)=(-(exp(y(2))*(1+y(4))*T57));
  g1(2,2)=(-(T26*(1+y(4))*exp(y(2))));
  g1(2,3)=(-(exp(y(2))*(1+y(4))*T73));
  g1(2,4)=1-T26*exp(y(2));
  g1(3,1)=1;
  g1(3,5)=(-1);
  g1(4,2)=1;
  g1(4,5)=(-params(7));
  g1(5,5)=1-params(6);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],5,25);
end
end
