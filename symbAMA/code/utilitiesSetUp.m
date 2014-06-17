$antlrPath=
"/msu/res1/Software/mavenRepositories/tryRep/"<>
"org/antlr/antlr-runtime/3.2/antlr-runtime-3.2.jar";
$dynareParserPath="../../DynareParsers/target/classes/";
$dynareParserPath="/msu/home/m1gsa00/git/DynareParsers/target/classes/";
$dynareParserPath="/msu/res1/Software/mavenRepositories/tryRep/gov/frb/ma/msu/dynareAntlr/1.0/dynareAntlr-1.0.jar"
Print["utilitiesSetUp.m: after parser stable go back to relative path"]

$symPath="../../mathAMA/SymbolicAMA/SymbolicAMA/";
$numPath="../../mathAMA/NumericAMA/NumericAMA/";
$modPath="../../mathAMA/AMAModel/";
$fmtPath="../../FormatOptimize/";
$Path = Join[$Path, {$symPath,$numPath,$modPath,$fmtPath}];

AddToClassPath[$antlrPath];
AddToClassPath[$dynareParserPath];

BeginPackage["utilitiesSetUp`",{"AccelerateAMA`"}]
theDynareMods=FileBaseName/@
FileNames[{___~~".mod"},{"dynareExamples/uniqueExamples/"}];

src["AltEx1"]="Collard";
src["AssetPricingApproximation"]="Barillas";
src["AssetPricingEstimate"]="Barillas";
src["bkk"]="Dynare";
src["example1"]="Dynare";
src["example2"]="Dynare";
src["fs2000"]="Dynare";
src["fs2000_nonstationary"]="Dynare";
src["ramst"]="Dynare";
src["BansalYaronBayes"]="Barillas";;
src["BansalYaronML"]="Barillas";;
src["BGGViegi"]="Viegi";
src["Fig1131commented"]="Barillas";
src["Fig1131"]="Barillas";
src["Fig1132"]="Barillas";
src["Fig1151"]="Barillas";
src["Fig1152"]="Barillas";
src["Fig1171"]="Barillas";
src["Fig1172"]="Barillas";
src["Figv3_1161"]="Ljungqvist";
src["Figv3_1162"]="Ljungqvist";
src["Figv3_1163"]="Ljungqvist";
src["Figv3_1164"]="Ljungqvist";
src["Figv3_1165"]="Ljungqvist";
src["Figv3_1166"]="Ljungqvist";
src["Figv3_1191"]="Ljungqvist";
src["Figv3_1192"]="Ljungqvist";
src["Figv3_1193"]="Ljungqvist";
src["firmValue"]="FRB";
src["fs2000ns"]="Dynare";
src["fuhrerMoore"]="FRB";
src["GrowthApproximate"]="Barillas";
src["GrowthEstimate"]="Barillas";
src["hall1estimateBayes"]="Barillas";
src["hall1estimateML"]="Barillas";
src["hall1"]="Barillas";
src["HSTBayes"]="Barillas";
src["HSTML"]="Barillas";
src["ifs1"]="Ngalawa";
src["kiyotakiMooreViegi"]="Viegi";
src["lesothoViegi"]="Viegi";
src["lubikSchorfheide"]="";
src["RBC_Est"]="Dynare";
src["RBCEst"]="Dynare";
src["RBCMonopDet"]="Dynare";
src["RBCMonopJFV"]="Dynare";
src["RBCViegi"]="Viegi";
src["rosenestimateBayes"]="Barillas";
src["rosenestimateML"]="Barillas";
src["rosen"]="Barillas";
src["sargent77Bayes"]="Barillas";
src["sargent77ML"]="Barillas";
src["sargent77"]="Barillas";
src["simpleNeoViegi"]="Viegi";
src["TwocountryApprox"]="Barillas";
src["TwocountryEst"]="Barillas";
src["lubikSchorfheide"]="Lubik";
src["GLLSELB"]="Gust";

isLin[modName_String]:=Not[FreeQ[allLinearMods,modName]]
isNonLin[modName_String]:=Not[FreeQ[allNonLinearMods,modName]]

makeSSValSubs[modName_String]:=makeSSValSubs[getVars[modName]]
getVars[modName_String]:=If[isLin[modName],getLinVars[modName],
If[isNonLin[modName],getNonLinVars[modName],"unknown model"]]

compB[zf_?MatrixQ,{},neq_Integer]:={}

compB[zf_?MatrixQ,evs_?MatrixQ,neq_Integer]:=
With[{qmat=Join[zf,evs]},
With[{qcols=Length[qmat[[1]]],qrows=Length[qmat]},
With[{qr=qmat[[All,qcols-qrows+Range[qrows]]],
ql=qmat[[All,Range[qcols-qrows]]]},
(-Inverse[qr].ql)]]]

toLarge[{},lilCols_List,cols_Integer]:={}

toLarge[lil_?MatrixQ,lilCols_List,cols_Integer]:=
Module[{bigEvecs},
bigEvecs=ConstantArray[0,{Length[lil],cols}];
bigEvecs[[All,lilCols]]=lil;
bigEvecs]
EndPackage[]
