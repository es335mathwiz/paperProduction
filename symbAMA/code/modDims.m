BeginPackage["modDims`",{"utilitiesSetUp`"}]
EndPackage[]

Print["no prerequisites"]
Print["takes about 10 seconds"]


Print["parsing all models now. this takes about 2 min"]
theData={#,getModelDims["dynareExamples/uniqueExamples/",#],
		src[#]}&/@theDynareMods;
allLinearMods=DeleteCases[Cases[theData,{xx_,{_,_,_,_,True},_}->xx],"BGGViegi"];
allNonLinearMods=Cases[theData,{xx_,{_,_,_,_,False},_}->xx];

Splice["modDims.mtex"]

