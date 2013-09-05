var dd vv;
parameters rr delta lrd;

lrd=1.;
delta = .3;
rr= .2;


model;
(1 + rr)*vv=vv(1)+dd(1);
(dd-lrd)=(1-delta)*(dd(-1)-lrd);
end;
