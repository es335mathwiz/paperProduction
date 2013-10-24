BeginPackage["nonLinearCompTimes`",{"ssSolnAllCompTimes`","modDims`"}]
EndPackage[]



Print["computing allNonLinear"]
Print["takes about 15 minutes"]
doThese10={2,3,5,10};
notAllNonLinearMods=allNonLinearMods[[doThese10]]

$tConst=10;
nonLinTimes=(Print[#];allNonLinear["dynareExamples/uniqueExamples/",#,"/tmp/"])& /@ 
notAllNonLinearMods;



getNonLinSSSoln[modName_String]:=
If[isLin[modName],{},With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,18]]]]

getNonLinVars[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,20]]]
getNonLinEqns[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,14]]]
getNonLinHmat[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,19]]]
getNonLinB[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,15]]]
getNonLinS[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,16]]]
getNonLinParamSubs[modName_String]:=
With[{idx=Position[notAllNonLinearMods,modName][[1,1]]},
nonLinTimes[[idx,13]]]
getNonLinParams[modName_String]:=Sort[First /@ getNonLinParamSubs[modName]]

Splice["nonLinearCompTimes.mtex"]
