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
M_.fname = 'Fig1131';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'Fig1131.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.param_names = 'taui';
M_.param_names_tex = 'taui';
M_.param_names = char(M_.param_names, 'tauc');
M_.param_names_tex = char(M_.param_names_tex, 'tauc');
M_.param_names = char(M_.param_names, 'tauk');
M_.param_names_tex = char(M_.param_names_tex, 'tauk');
M_.param_names = char(M_.param_names, 'g');
M_.param_names_tex = char(M_.param_names_tex, 'g');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'gam');
M_.param_names_tex = char(M_.param_names_tex, 'gam');
M_.param_names = char(M_.param_names, 'del');
M_.param_names_tex = char(M_.param_names_tex, 'del');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names = char(M_.param_names, 'A');
M_.param_names_tex = char(M_.param_names_tex, 'A');
M_.param_names = char(M_.param_names, 'ko');
M_.param_names_tex = char(M_.param_names_tex, 'ko');
M_.exo_det_nbr = 0;
M_.exo_nbr = 0;
M_.endo_nbr = 2;
M_.param_nbr = 10;
M_.orig_endo_nbr = 2;
M_.aux_vars = [];
M_.Sigma_e = zeros(0, 0);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('Fig1131_dynamic');
M_.lead_lag_incidence = [
 0 2 4;
 1 3 0;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:0];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(2, 1);
M_.params = NaN(10, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 6;
M_.NNZDerivatives(2) = 0;
M_.NNZDerivatives(3) = -1;
M_.params( 4 ) = 0.2;
g = M_.params( 4 );
M_.params( 2 ) = 0;
tauc = M_.params( 2 );
M_.params( 1 ) = 0;
taui = M_.params( 1 );
M_.params( 3 ) = 0;
tauk = M_.params( 3 );
M_.params( 5 ) = .95;
bet = M_.params( 5 );
M_.params( 6 ) = 2;
gam = M_.params( 6 );
M_.params( 7 ) = .2;
del = M_.params( 7 );
M_.params( 8 ) = .33;
alpha = M_.params( 8 );
M_.params( 9 ) = 1;
A = M_.params( 9 );
M_.params( 10 ) = 1;
ko = M_.params( 10 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 2 ) = 1.5;
oo_.steady_state( 1 ) = 0.6;
oo_.endo_simul=[oo_.steady_state*ones(1,M_.maximum_lag)];
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
steady;
%
% ENDVAL instructions
%
ys0_= oo_.steady_state;
ex0_ = oo_.exo_steady_state;
oo_.steady_state( 2 ) = 1.5;
oo_.steady_state( 1 ) = 0.4;
steady;
options_.periods = 100;
simul();
co=ys0_(var_index('c'));
go = ex_(1,1);
rbig0=1/bet;
rbig=y_(var_index('c'),2:101).^(-gam)./(bet*y_(var_index('c'),3:102).^(-gam));
rq0=alpha*A*ko^(alpha-1);
rq=alpha*A*y_(var_index('k'),1:100).^(alpha-1);
wq0=A*ko^alpha-ko*alpha*A*ko^(alpha-1);
wq=A*y_(var_index('k'),1:100).^alpha-y_(var_index('k'),1:100).*alpha*A.*y_(var_index('k'),1:100).^(alpha-1);
sq0=(1-ex_(1,4))*A*alpha*ko^(alpha-1)+(1-del);
sq=(1-ex_(1:100,4)')*A*alpha.*y_(var_index('k'),1:100).^(alpha-1)+(1-del);
figure
subplot(2,3,1)
plot([ko*ones(100,1)  y_(var_index('k'),1:100)' ])
title('k')
subplot(2,3,2)
plot([co*ones(100,1)  y_(var_index('c'),2:101)' ])
title('c')
subplot(2,3,3)
plot([rbig0*ones(100,1) rbig' ])
title('R')
subplot(2,3,4)
plot([wq0*ones(100,1) wq' ])
title('w/q')
subplot(2,3,5)
plot([sq0*ones(100,1) sq' ])
title('s/q')
subplot(2,3,6)
plot([rq0*ones(100,1) rq' ])
title('r/q')
print -depsc fig1131.ps
save('Fig1131_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
