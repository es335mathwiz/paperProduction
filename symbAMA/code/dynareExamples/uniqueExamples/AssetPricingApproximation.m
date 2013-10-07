%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
clear global
tic;
global M_ oo_ options_ ys0_ ex0_
options_ = [];
M_.fname = 'AssetPricingApproximation';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'AssetPricingApproximation.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'e_c';
M_.exo_names_tex = 'e\_c';
M_.exo_names = char(M_.exo_names, 'e_x');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_x');
M_.exo_names = char(M_.exo_names, 'e_d');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_d');
M_.endo_names = 'dc';
M_.endo_names_tex = 'dc';
M_.endo_names = char(M_.endo_names, 'dd');
M_.endo_names_tex = char(M_.endo_names_tex, 'dd');
M_.endo_names = char(M_.endo_names, 'v_c');
M_.endo_names_tex = char(M_.endo_names_tex, 'v\_c');
M_.endo_names = char(M_.endo_names, 'v_d');
M_.endo_names_tex = char(M_.endo_names_tex, 'v\_d');
M_.endo_names = char(M_.endo_names, 'x');
M_.endo_names_tex = char(M_.endo_names_tex, 'x');
M_.param_names = 'DELTA';
M_.param_names_tex = 'DELTA';
M_.param_names = char(M_.param_names, 'THETA');
M_.param_names_tex = char(M_.param_names_tex, 'THETA');
M_.param_names = char(M_.param_names, 'PSI');
M_.param_names_tex = char(M_.param_names_tex, 'PSI');
M_.param_names = char(M_.param_names, 'MU_C');
M_.param_names_tex = char(M_.param_names_tex, 'MU\_C');
M_.param_names = char(M_.param_names, 'MU_D');
M_.param_names_tex = char(M_.param_names_tex, 'MU\_D');
M_.param_names = char(M_.param_names, 'RHO_X');
M_.param_names_tex = char(M_.param_names_tex, 'RHO\_X');
M_.param_names = char(M_.param_names, 'LAMBDA_DX');
M_.param_names_tex = char(M_.param_names_tex, 'LAMBDA\_DX');
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 5;
M_.param_nbr = 7;
M_.orig_endo_nbr = 5;
M_.aux_vars = [];
M_.Sigma_e = zeros(3, 3);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('AssetPricingApproximation_dynamic');
M_.lead_lag_incidence = [
 0 2 7;
 0 3 8;
 0 4 9;
 0 5 10;
 1 6 0;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(5, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(7, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 18;
M_.NNZDerivatives(2) = 33;
M_.NNZDerivatives(3) = -1;
options_.periods = 500;
M_.params( 1 ) = .99;
DELTA = M_.params( 1 );
M_.params( 3 ) = 1.5;
PSI = M_.params( 3 );
M_.params( 2 ) = (-6.5)/(1-1/M_.params(3));
THETA = M_.params( 2 );
M_.params( 4 ) = 0.0015;
MU_C = M_.params( 4 );
M_.params( 5 ) = 0.0015;
MU_D = M_.params( 5 );
M_.params( 6 ) = .979;
RHO_X = M_.params( 6 );
M_.params( 7 ) = 3;
LAMBDA_DX = M_.params( 7 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 104.20915537119257;
oo_.steady_state( 4 ) = 104.20915537119257;
oo_.steady_state( 1 ) = M_.params(4);
oo_.steady_state( 2 ) = M_.params(5);
oo_.steady_state( 5 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
oo_.exo_steady_state( 2 ) = 0;
oo_.exo_steady_state( 3 ) = 0;
oo_.endo_simul=[oo_.steady_state*ones(1,M_.maximum_lag)];
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (.0078)^2;
M_.Sigma_e(2, 2) = (0.0003431999999999999)^2;
M_.Sigma_e(3, 3) = (0.0351)^2;
M_.sigma_e_is_diagonal = 1;
steady;
datasaver('simudata',[]);
save('AssetPricingApproximation_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
