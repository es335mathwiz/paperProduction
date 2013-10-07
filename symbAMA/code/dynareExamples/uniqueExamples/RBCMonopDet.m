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
M_.fname = 'RBCMonopDet';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'RBCMonopDet.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names = char(M_.endo_names, 'y_l');
M_.endo_names_tex = char(M_.endo_names_tex, 'y\_l');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.param_names = 'z';
M_.param_names_tex = 'z';
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names = char(M_.param_names, 'epsilon');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon');
M_.exo_det_nbr = 0;
M_.exo_nbr = 0;
M_.endo_nbr = 8;
M_.param_nbr = 7;
M_.orig_endo_nbr = 8;
M_.aux_vars = [];
M_.Sigma_e = zeros(0, 0);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('RBCMonopDet_dynamic');
M_.lead_lag_incidence = [
 0 2 0;
 0 3 10;
 1 4 0;
 0 5 0;
 0 6 0;
 0 7 0;
 0 8 0;
 0 9 11;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:0];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(8, 1);
M_.params = NaN(7, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 24;
M_.NNZDerivatives(2) = 0;
M_.NNZDerivatives(3) = -1;
M_.params( 1 ) = 0;
z = M_.params( 1 );
M_.params( 5 ) = 0.33;
alpha = M_.params( 5 );
M_.params( 2 ) = 0.99;
beta = M_.params( 2 );
M_.params( 4 ) = 0.023;
delta = M_.params( 4 );
M_.params( 3 ) = 1.75;
psi = M_.params( 3 );
M_.params( 6 ) = 0.007/(1-M_.params(5));
sigma = M_.params( 6 );
M_.params( 7 ) = 10;
epsilon = M_.params( 7 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 9;
oo_.steady_state( 2 ) = 0.7;
oo_.steady_state( 5 ) = 0.3;
oo_.steady_state( 7 ) = 2.0;
oo_.steady_state( 8 ) = 0;
oo_.endo_simul=[oo_.steady_state*ones(1,M_.maximum_lag)];
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
steady;
check;
options_.periods = 2100;
simul();
save('RBCMonopDet_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
