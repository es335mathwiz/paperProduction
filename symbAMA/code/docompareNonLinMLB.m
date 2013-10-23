function theRes=docompareNonLinMLB(modName)

manyTimes=1000;
load([modName 'Hmat']);
load([modName 'Dims']);
load([modName 'Prms']);
load([modName 'SS']);

fh=str2func([modName 'MexBRtsComp']);



theRes=[timerLoop(manyTimes,hmat,dims(1),dims(2),dims(3)) ...
		analyticTimerLoop(manyTimes,fh,params)];
end
