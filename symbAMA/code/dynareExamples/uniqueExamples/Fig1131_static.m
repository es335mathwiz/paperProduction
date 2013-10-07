function [residual, g1, g2] = Fig1131_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 2, 1);

%
% Model equations
%

T41 = (1-params(7))*(1-params(1))/(1-params(1))+params(9)*params(8)*(1-params(3))/(1-params(1))*y(2)^(params(8)-1);
lhs =y(2);
rhs =params(9)*y(2)^params(8)+y(2)*(1-params(7))-y(1)-params(4);
residual(1)= lhs-rhs;
lhs =y(1)^(-params(6));
rhs =y(1)^(-params(6))*params(5)*T41;
residual(2)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(2, 2);

%
% Jacobian matrix
%

  g1(1,1)=1;
  g1(1,2)=1-(1-params(7)+params(9)*getPowerDeriv(y(2),params(8),1));
  g1(2,1)=getPowerDeriv(y(1),(-params(6)),1)-T41*params(5)*getPowerDeriv(y(1),(-params(6)),1);
  g1(2,2)=(-(y(1)^(-params(6))*params(5)*params(9)*params(8)*(1-params(3))/(1-params(1))*getPowerDeriv(y(2),params(8)-1,1)));
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],2,4);
end
end
