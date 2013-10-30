BeginPackage["nonLinCompMLB`",{"ssSolnAllCompTimes`","nonLinearCompTimes`","linearCompTimes`","genMexCode`"}]
EndPackage[]



Print["splicingnonLinearccompMLB"]
Print["takes 23 minutes"]
Print["should take about 40 seconds"]



$tConst=10;




$tConst=10;
doThese10={2,3,5,10};
(*
forMex10=allNonLinear["dynareExamples/uniqueExamples/",#,
"theLinRes/"]& /@ allNonLinearMods[[doThese10]];
*)
Print["put formex10 back in!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"]
doMexSplice /@ notAllNonLinearMods;
mexComp/@ notAllNonLinearMods
expHMat/@ notAllNonLinearMods
(*
forMex10=allNonLinear["dynareExamples/uniqueExamples/",#,
"theLinRes/"]& /@ allNonLinearMods;
doMexSplice /@ allNonLinearMods;
mexComp/@ allNonLinearMods;
expHMat/@ allNonLinearMods;


Run["matlab -nodesktop -nodisplay -nosplash -r nonLinExeToMat"]
{nonLinExeTimes}=Import["nonLinExeTimes.mat"];
Splice["nonLinCompMLB.mtex"]




$tConst=20;
doThese20={1};
forMex11=allNonLinear["dynareExamples/uniqueExamples/",#,
"theLinRes/"]& /@ allNonLinearMods[[doThese20]];
doMexSplice /@ allNonLinearMods[[doThese20]];
mexComp/@ allNonLinearMods[[doThese20]];
expHMat/@ allNonLinearMods[[doThese20]];
*)
