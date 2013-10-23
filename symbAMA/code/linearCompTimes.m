BeginPackage["linearCompTimes`",{"modDims`"}]
EndPackage[]
Print["splicing linearcomptimes"]
Print["requires 41 seconds"]



smallLinearMods=DeleteCases[Cases[theData,
{xx_,{_,_,_,_,True},_}->xx],"BGGViegi"];
mkNewDir["theLinRes"]
linTimes=allLinear["dynareExamples/uniqueExamples/",#,
"theLinRes/"]& /@ smallLinearMods;

getLinVars[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,16]]]
getLinEqns[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,12]]]
getLinHmat[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,15]]]
getLinB[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,13]]]
getLinS[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,14]]]
getLinParamSubs[modName_String]:=
With[{idx=Position[allLinearMods,modName][[1,1]]},
linTimes[[idx,11]]]
getLinParams[modName_String]:=Sort[First /@ getLinParamSubs[modName]]

Splice["linearCompTimes.mtex"]


