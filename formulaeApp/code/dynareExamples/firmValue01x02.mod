var dd vv;
parameters rr delta lrd fd;

lrd=1.;
delta = .3;
rr= .2;
fd = .01;

model;
(1 + rr)*vv=vv(1)+dd(1) + fd*dd(2);
(dd-lrd)=(1-delta)*(dd(-1)-lrd);
end;
