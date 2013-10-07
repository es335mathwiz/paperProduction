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
M_.fname = 'fs2000';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'fs2000.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'e_a';
M_.exo_names_tex = 'e\_a';
M_.exo_names = char(M_.exo_names, 'e_m');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_m');
M_.endo_names = 'm';
M_.endo_names_tex = 'm';
M_.endo_names = char(M_.endo_names, 'P');
M_.endo_names_tex = char(M_.endo_names_tex, 'P');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names = char(M_.endo_names, 'e');
M_.endo_names_tex = char(M_.endo_names_tex, 'e');
M_.endo_names = char(M_.endo_names, 'W');
M_.endo_names_tex = char(M_.endo_names_tex, 'W');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names = char(M_.endo_names, 'gy_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gy\_obs');
M_.endo_names = char(M_.endo_names, 'gp_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gp\_obs');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names = char(M_.endo_names, 'dA');
M_.endo_names_tex = char(M_.endo_names_tex, 'dA');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_65');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_65');
M_.param_names = 'alp';
M_.param_names_tex = 'alp';
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'gam');
M_.param_names_tex = char(M_.param_names_tex, 'gam');
M_.param_names = char(M_.param_names, 'mst');
M_.param_names_tex = char(M_.param_names_tex, 'mst');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names = char(M_.param_names, 'del');
M_.param_names_tex = char(M_.param_names_tex, 'del');
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 15;
M_.param_nbr = 7;
M_.orig_endo_nbr = 14;
M_.aux_vars(1).endo_index = 15;
M_.aux_vars(1).type = 0;
options_.varobs = [];
options_.varobs = 'gp_obs';
options_.varobs = char(options_.varobs, 'gy_obs');
options_.varobs_id = [ 12 11  ];
M_.Sigma_e = zeros(2, 2);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('fs2000_dynamic');
M_.lead_lag_incidence = [
 1 5 0;
 2 6 20;
 0 7 21;
 0 8 0;
 0 9 0;
 0 10 0;
 3 11 0;
 0 12 0;
 0 13 0;
 0 14 0;
 0 15 0;
 0 16 0;
 4 17 0;
 0 18 0;
 0 19 22;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(15, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(7, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 66;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
M_.params( 1 ) = 0.33;
alp = M_.params( 1 );
M_.params( 2 ) = 0.99;
bet = M_.params( 2 );
M_.params( 3 ) = 0.003;
gam = M_.params( 3 );
M_.params( 4 ) = 1.011;
mst = M_.params( 4 );
M_.params( 5 ) = 0.7;
rho = M_.params( 5 );
M_.params( 6 ) = 0.787;
psi = M_.params( 6 );
M_.params( 7 ) = 0.02;
del = M_.params( 7 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 7 ) = 6;
oo_.steady_state( 1 ) = M_.params(4);
oo_.steady_state( 2 ) = 2.25;
oo_.steady_state( 3 ) = 0.45;
oo_.steady_state( 4 ) = 1;
oo_.steady_state( 5 ) = 4;
oo_.steady_state( 6 ) = 1.02;
oo_.steady_state( 8 ) = 0.85;
oo_.steady_state( 9 ) = 0.19;
oo_.steady_state( 10 ) = 0.86;
oo_.steady_state( 13 ) = 0.6;
oo_.steady_state( 11 ) = exp(M_.params(3));
oo_.steady_state( 12 ) = exp((-M_.params(3)));
oo_.steady_state( 14 ) = exp(M_.params(3));
oo_.steady_state(15)=oo_.steady_state(2)*M_.params(2)*(oo_.steady_state(9)^(1-M_.params(1))*M_.params(1)*exp((-M_.params(1))*(M_.params(3)+log(oo_.steady_state(4))))*oo_.steady_state(7)^(M_.params(1)-1)+(1-M_.params(7))*exp((-(M_.params(3)+log(oo_.steady_state(4))))))/(oo_.steady_state(1)*oo_.steady_state(2)*oo_.steady_state(3));
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
M_.Sigma_e(1, 1) = (0.014)^2;
M_.Sigma_e(2, 2) = (0.005)^2;
M_.sigma_e_is_diagonal = 1;
steady;
check;
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 1, 0.356, 0.02, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 1, 0.993, 0.002, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 3, 0.0085, 0.003, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 3, 1.0002, 0.007, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.129, 0.223, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.65, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 1, 0.01, 0.005, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.035449, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.008862, Inf, NaN, NaN, NaN ];
options_.loglinear = 1;
options_.mh_jscale = 0.8;
options_.mh_nblck = 2;
options_.mh_replic = 2000;
options_.order = 1;
options_.datafile = 'fsdat_simul';
options_.nobs = 192;
var_list_=[];
dynare_estimation(var_list_);
save('fs2000_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
