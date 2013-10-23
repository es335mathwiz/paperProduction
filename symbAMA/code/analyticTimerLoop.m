
function totTime=timerLoop(manyTimes,handle,params)
totTime=0;
for ii=0:manyTimes
tstart=tic;
[bb,aa] = handle(params);
totTime=totTime+toc(tstart);
end
end
