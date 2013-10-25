
function totTime=timerLoop(manyTimes,theMat,neq,nlag,nlead)
totTime=0;
for ii=0:manyTimes
tstart=tic;
[b,rts,ia,nexact,nnumeric,lgroots,aimcode] = ...
                       SPAmalg(theMat,neq,nlag,nlead,1.0e-8,1);
totTime=totTime+toc(tstart);
end
end
