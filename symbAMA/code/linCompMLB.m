BeginPackage["linCompMLB`",{"ssSolnAllCompTimes`","nonLinearCompTimes`","linearCompTimes`","genMexCode`"}]
EndPackage[]



$tConst=10;
forMex=allNonLinear["dynareExamples/uniqueExamples/",#,"theLinRes/"]&/@ 
smallLinearMods;
doMexSplice /@ smallLinearMods;
mexComp/@ smallLinearMods;
expHMat/@ smallLinearMods;

Run["matlab -nodesktop -nodisplay -nosplash -r linExeToMat"]
{linExeTimes}=Import["linExeTimes.mat"];
Splice["linCompMLB.mtex"]
