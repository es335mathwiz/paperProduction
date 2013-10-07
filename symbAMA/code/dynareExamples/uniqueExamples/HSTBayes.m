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
M_.fname = 'HSTBayes';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'HSTBayes.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'e_dhat';
M_.exo_names_tex = 'e\_dhat';
M_.exo_names = char(M_.exo_names, 'e_dbar');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_dbar');
M_.endo_names = 's';
M_.endo_names_tex = 's';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names = char(M_.endo_names, 'dhat');
M_.endo_names_tex = char(M_.endo_names_tex, 'dhat');
M_.endo_names = char(M_.endo_names, 'dbar');
M_.endo_names_tex = char(M_.endo_names_tex, 'dbar');
M_.endo_names = char(M_.endo_names, 'mus');
M_.endo_names_tex = char(M_.endo_names_tex, 'mus');
M_.endo_names = char(M_.endo_names, 'muc');
M_.endo_names_tex = char(M_.endo_names_tex, 'muc');
M_.endo_names = char(M_.endo_names, 'muh');
M_.endo_names_tex = char(M_.endo_names_tex, 'muh');
M_.endo_names = char(M_.endo_names, 'gamma');
M_.endo_names_tex = char(M_.endo_names_tex, 'gamma');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_7_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_7\_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_6_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_6\_1');
M_.param_names = 'lambda';
M_.param_names_tex = 'lambda';
M_.param_names = char(M_.param_names, 'deltah');
M_.param_names_tex = char(M_.param_names_tex, 'deltah');
M_.param_names = char(M_.param_names, 'deltak');
M_.param_names_tex = char(M_.param_names_tex, 'deltak');
M_.param_names = char(M_.param_names, 'mud');
M_.param_names_tex = char(M_.param_names_tex, 'mud');
M_.param_names = char(M_.param_names, 'b');
M_.param_names_tex = char(M_.param_names_tex, 'b');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'phi1');
M_.param_names_tex = char(M_.param_names_tex, 'phi1');
M_.param_names = char(M_.param_names, 'phi2');
M_.param_names_tex = char(M_.param_names_tex, 'phi2');
M_.param_names = char(M_.param_names, 'cdbar');
M_.param_names_tex = char(M_.param_names_tex, 'cdbar');
M_.param_names = char(M_.param_names, 'alpha1');
M_.param_names_tex = char(M_.param_names_tex, 'alpha1');
M_.param_names = char(M_.param_names, 'alpha2');
M_.param_names_tex = char(M_.param_names_tex, 'alpha2');
M_.param_names = char(M_.param_names, 'cdhat');
M_.param_names_tex = char(M_.param_names_tex, 'cdhat');
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 15;
M_.param_nbr = 12;
M_.orig_endo_nbr = 13;
M_.aux_vars(1).endo_index = 14;
M_.aux_vars(1).type = 1;
M_.aux_vars(1).orig_index = 8;
M_.aux_vars(1).orig_lead_lag = -1;
M_.aux_vars(2).endo_index = 15;
M_.aux_vars(2).type = 1;
M_.aux_vars(2).orig_index = 7;
M_.aux_vars(2).orig_lead_lag = -1;
options_.varobs = [];
options_.varobs = 'c';
options_.varobs = char(options_.varobs, 'i');
options_.varobs_id = [ 2 5  ];
M_.Sigma_e = zeros(2, 2);
M_.H = 0;
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('HSTBayes_dynamic');
M_.lead_lag_incidence = [
 0 7 0;
 0 8 0;
 1 9 0;
 2 10 0;
 0 11 0;
 0 12 0;
 3 13 0;
 4 14 0;
 0 15 22;
 0 16 23;
 0 17 24;
 0 18 0;
 0 19 0;
 5 20 0;
 6 21 0;]';
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
M_.params = NaN(12, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 43;
M_.NNZDerivatives(2) = 4;
M_.NNZDerivatives(3) = -1;
M_.params( 6 ) = 0.9971;
bet = M_.params( 6 );
M_.params( 2 ) = 0.682;
deltah = M_.params( 2 );
M_.params( 1 ) = 2.443;
lambda = M_.params( 1 );
M_.params( 10 ) = 0.813;
alpha1 = M_.params( 10 );
M_.params( 11 ) = 0.189;
alpha2 = M_.params( 11 );
M_.params( 7 ) = 0.998;
phi1 = M_.params( 7 );
M_.params( 8 ) = 0.704;
phi2 = M_.params( 8 );
M_.params( 4 ) = 13.710;
mud = M_.params( 4 );
M_.params( 12 ) = 0.155;
cdhat = M_.params( 12 );
M_.params( 9 ) = 0.108;
cdbar = M_.params( 9 );
M_.params( 5 ) = 32;
b = M_.params( 5 );
M_.params( 3 ) = 0.975;
deltak = M_.params( 3 );
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (1)^2;
M_.Sigma_e(2, 2) = (1)^2;
M_.sigma_e_is_diagonal = 1;
options_.irf = 0;
options_.periods = 500;
var_list_=[];
info = stoch_simul(var_list_);
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 5, .9499999999, 0.0288675134306, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 5, 0.45, 0.202072594216, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 5, 25.05, 14.4048892163, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 5, 0.8, 0.115470053809, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 5, 0.25, 0.144337567297, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 5, 0.8, 0.115470053809, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 5, 0.5, 0.288675134595, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 5, 24.5, 14.1450815951, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 5, 0.175, 0.0721687836487, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 5, 0.175, 0.0721687836487, NaN, NaN, NaN ];
options_.aim_solver = 1;
options_.first_obs = 1;
options_.mh_jscale = 0.3;
options_.mh_nblck = 1;
options_.mh_replic = 5000;
options_.mode_check = 1;
options_.mode_compute = 4;
options_.datafile = 'dataHST';
options_.nobs = 500;
var_list_=[];
dynare_estimation(var_list_);
save('HSTBayes_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
