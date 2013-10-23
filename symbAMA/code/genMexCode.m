BeginPackage["genMexCode`",{"Experimental`", "Format`","nonLinearCompTimes`","linearCompTimes`"}]

!gfortran -c -fdefault-real-8 -fPIC rpoly493.f 

(*
!gfortran -c -fdefault-real-8 -fPIC /msu/res2/m1gsa00/conferences/sce11/generatedMexFiles/rpoly493.f 

!gcc -c  rpoly.cpp -fPIC
!gfortran -c  -fno-range-check rpoly493.f -fPIC
!mex fuhrerMooreMexBRtsComp.c  -lgfortran rpoly493.o 

{rVal1->(w1+w2/I)/2,rVal2->(w1-w2/I)/2}//Simplify//Expand

{rVal1->(w1+I w2),rVal2->(w1-I w2)}//Simplify//Expand
huh=getB["fuhrerMoore"];

huh=getB["fuhrerMoore"];
duh=repRoots[huh];
well=duh[[2]];
well/.{rVal1->(w1+I w2),rVal2->(w1-I w2)}//Simplify//Expand

{rVal1->(w1+w2/I)/2,rVal2->(w1-w2/I)/2}//FullSimplify//Expand

prodSubs={
times[aa___,(xx_+I yy_),oo___,(xx_-I yy_),zz___]->Times[aa,(xx^2+yy^2),oo,zz],
Times[aa___,1/(xx_+I yy_),oo___,1/(xx_-I yy_),zz___]->Times[aa,1/(xx^2+yy^2),oo,zz],
Times[aa___,(xx_-I yy_),oo___,(xx_+I yy_),zz___]->Times[aa,(xx^2+yy^2),oo,zz]
}

try=(CRHO (-1 + LAMBDA) LAMBDA  (-2 + w1 - I w2) (w1 - I w2) (-2 + w1 + I w2) (w1 + I w2))
*)

(*
getB::usage="getB[modName_String]"
makeShockSubs::usage="makeShockSubs[name_String]"
genCode::usage="genCode[modName_String]";
getEqns::usage="getEqns[modName_String]"
*)
doMexSplice::usage="doMexSplice[modName_String]";

mexComp::usage="mexComp[modName_String]";
expHMat::usage="expHMat[modName_String]";
foB::usage="target name for assignments";
bb::usage="target name for assignments";
forCoeffs::usage="used in splicing";
coeff::usage="used in splicing";


$modNameNow::usage="used in splicing";
$bRowsNow::usage="used in splicing";
$bColsNow::usage="used in splicing";
$numRootsNow::usage="used in splicing";
$theMexCodeNow::usage="used in splicing";



Begin["`Private`"]

genCode[modName_String]:=
With[{muchCode=genLinAssigns[modName]},
mexHeader<>
muchCode[[1]]<>
funcDef[modName<>"BComp"]<>
defineLinParamsDouble[modName]<>
muchCode[[2]]<>
muchCode[[4]]<>
bCompEnd];




mexHeader=
"#include \"mex.h\"\n#include <complex.h>\n#include <math.h>\n";


bCompEnd="\n}\n"

funcDef[name_String]:=
"void	"<> name<>"(double*params,double * bb ){\n"

defineDouble[name_String]:=
"double "<>name<>";\n"

defineComplex[name_String]:=
"complex "<>name<>";\n"

getParams[modName_String]:=Sort[First /@ Global`getParamSubs[modName]]



defineLinParamsDouble[modName_String]:=
With[{prms=getParams[modName]},
StringJoin @@ 
MapIndexed[ToString[StringForm["double `` = params[``];\n",#,#2[[1]]-1]]&,prms]]

repRoots[eqns_List]:=With[{rVals=Union[Cases[eqns,Root[___],Infinity]]},
With[{rSubs=makeRootSubs[rVals]},
{rSubs,eqns/.rSubs}]]

makeRootSubs[rVals_List]:=
MapIndexed[#1->ToExpression["rVal"<>ToString[#2[[1]]]]&,rVals]


doMexSplice[modName_String]:=
Module[{mexName=modName<>"MexBRtsComp.c",splicedCode,chnl,allCode,
bMat=getB[modName]},
With[{bRows=Length[bMat],bCols=Length[bMat[[1]]]},
$modNameNow=modName;
$bRowsNow=bRows;
$bColsNow=bCols;
$theMexCodeNow=genCode[modName];
Splice["mexTemplate.mc",mexName,PageWidth->800000,FormatType->OutputForm];
str=OpenRead[mexName];
splicedCode=ReadList[str,Record,RecordSeparators->{}];
allCode=$theMexCodeNow <> splicedCode;
Close[str];Close[mexName];
chnl=OpenWrite[mexName];
WriteString[chnl,allCode];
allCode
]]

makeShockSubs[name_String]:=With[
{shks=Global`AMAModelDefinition[name][[-2]]},
#[[1]]->0&/@shks]

getB[modName_String]:=If[utilitiesSetUp`isLin[modName],Global`getLinB[modName],
If[utilitiesSetUp`isNonLin[modName],Global`getNonLinB[modName],"unknown model"]]
getEqns[modName_String]:=If[utilitiesSetUp`isLin[modName],Global`getLinEqns[modName],
If[utilitiesSetUp`isNonLin[modName],Global`getNonLinEqns[modName],"unknown model"]]


genLinAssigns[modName_String]:=
Module[{prmDefs=defineLinParamsDouble[modName]},
With[{linB=getB[modName]/.makeShockSubs[modName]},
With[{bSubbedPair=repRoots[linB]},
With[{collected=collectedRts[bSubbedPair]},
With[{rpolyStuff=If[Length[collected]==0,{"","",""},Transpose[
MapIndexed[genOneGroup[#,prmDefs,#2[[1]]]&,collected]]]},
With[{
subrs=StringJoin @@ rpolyStuff[[1]],
defs=StringJoin @@ rpolyStuff[[2]],
assns=StringJoin @@ rpolyStuff[[3]]
},
SetOptions[$Output,PageWidth->500000];
theStr=ToString[CAssign[bb,Flatten[Transpose[bSubbedPair[[2]]]],OptimizationSymbol->foB]];
SetOptions[$Output,PageWidth->80];
{subrs,defs,assns, genRValDefns[bSubbedPair[[1]]]<>genFoBDefns[theStr]<>
defineSSVecDouble[modName]<>
defineSSValDouble[modName]<>
defineSSValAssign[modName]<>
assns<>theStr}
]]]]]]

genRValDefns[theSubs_List]:=
(StringJoin @@ (defineComplex[ToString[#[[2]]]]&/@theSubs))<>"\n"

genFoBDefns[theStr_String]:=
With[{toDef=Union[StringCases[theStr,RegularExpression["foB[0-9]+"]]]},
"\n"<>(StringJoin @@ (defineComplex /@toDef))<>"\n"]

(*genRtAssigns[rtSubs_List]:=*)

getCoefficientList[Root[xx_Function,yy_Integer]->zz_Symbol]:=
With[{varSym=Unique[]},
{Reverse[CoefficientList[xx[varSym],varSym]],{{yy,zz}}}]

grouperSubs={{xx_,y1_},mm___,{xx_,y2_}}->{{xx,Join[y1,y2]},mm};

collectedRts[subbedPair_List]:=
(getCoefficientList/@subbedPair[[1]])//.grouperSubs

genOneGroup[{coeffs_List,ordValPairs_List},prmDefs_String,indx_Integer]:=
Module[{degree=Length[coeffs]-1,
header=ToString[
StringForm["void callRPoly``(double*params,double* zeroR,double*zeroI)",indx]]},
coeffDef=ToString[StringForm["double coeff[`1`];int degree=`2`;int info[`1`];\n",degree+1,degree]];
SetOptions[$Output,PageWidth->500000];
theStr=ToString[CAssign[coeff,coeffs,OptimizationSymbol->forCoeffs]];
SetOptions[$Output,PageWidth->80];
{header<>"{"<>
coeffDef<>
prmDefs<>
genForCoeffsDefns[theStr]<>
theStr<>
"rpoly_(coeff,&degree,zeroR,zeroI,info);"<>
"}\n",
genRValAssignPre[degree,indx],
genRValAssignPost[ordValPairs,indx]}
]
genRValAssignPre[degree_Integer,indx_Integer]:=
ToString[StringForm["double rPtrRe`2`[`1`],rPtrIm`2`[`1`];\n",degree,indx]]


genRValAssignPost[ovPairs_List,indx_Integer]:=
ToString[StringForm["callRPoly`1`(params,rPtrRe`1`,rPtrIm`1`);\n",indx]]<>
StringJoin @@ (genAnRVal[#,indx]&/@ovPairs)

genAnRVal[{num_Integer,name_Symbol},indx_Integer]:=
ToString[StringForm["`1`=rPtrRe`3`[`2`]+I*rPtrIm`3`[`2`];\n",name,num-1,indx]]

genForCoeffsDefns[theStr_String]:=
With[{toDef=Union[StringCases[theStr,RegularExpression["forCoeffs[0-9]+"]]]},
"\n"<>(StringJoin @@ (defineDouble /@toDef))<>"\n"]


defineSSValDouble[modName_String]:=
With[{ssVars=Sort[Last/@AccelerateAMA`makeSSValSubs[utilitiesSetUp`getVars[modName]]]},
StringJoin @@ 
Map[ToString[StringForm["double `` ;\n",#]]&,ssVars]]



defineSSValAssign[modName_String]:=
If[utilitiesSetUp`isLin[modName],"",
With[{ssVars=Sort[Last/@AccelerateAMA`makeSSValSubs[utilitiesSetUp`getVars[modName]]]},
StringJoin @@ 
MapThread[ToString[StringForm[" `` = ``;\n",#1,#2]]&,{ssVars,Chop[ssVars/.
Global`getNonLinSSSoln[modName]]}]]]

(*generic assign
defineSSValAssign[modName_String]:=
With[{ssVars=Sort[Last/@AccelerateAMA`makeSSValSubs[utilitiesSetUp`getVars[modName]]]},
StringJoin @@ 
MapIndexed[ToString[StringForm[" `` = ssVec[``];\n",#,#2[[1]]-1]]&,ssVars]]
*)

defineSSVecDouble[modName_String]:=
ToString[StringForm["double ssVec[``];\n",Length[utilitiesSetUp`getVars[modName]]]]


genSSEqns[modName_String]:=
With[{params=getParams[modName],vars=utilitiesSetUp`getVars[modName]},
With[{ssSubsNow=AccelerateAMA`makeSSValSubs[vars]},
With[{ssVars=Last/@ssSubsNow,eqns=(getEqns[modName]/.
ssSubsNow)/.makeShockSubs[modName]},
With[{drvs=eqDrv[#,ssVars]&/@eqns},
{eqns,drvs}]]]]

eqDrv[anEq_,vars_List]:=D[anEq,#]&/@vars

breakEven[pp_?NumberQ,ts_?NumberQ,tf_?NumberQ]:=(pp/tf)/((ts/tf)-1)
(*
speedup={
   37.2384
   36.3243
   36.2833
   34.9830
   51.7941
   35.9251
   36.3419
   36.4733
   34.6525
   50.6319
   35.1654
   43.0925
   45.1017
}

totTimes={0.7938780000000634, 3.2475060000001577, 3.254505999999992, 3.2725020000000313, 
 3.269504000000097, 3.2715039999998226, 3.2605049999999665, 0.8488700000000335, 
 0.8448719999996683, 0.4699279999999817, 3.698440000000005, 81.54760400000009, 
 81.53660399999978};
evTimes={
{    0.4834  ,  0.0130},
{    0.6906  ,  0.0190},
{    0.6896  ,  0.0190},
{    0.6836  ,  0.0195},
{    0.6909  ,  0.0133},
{    0.6902  ,  0.0192},
{    0.6938  ,  0.0191},
{    0.7183  ,  0.0197},
{    0.7237  ,  0.0209},
{    0.6963  ,  0.0138},
{    0.7132  ,  0.0203},
{    1.0400  ,  0.0241},
{    0.7905  ,  0.0175}
};
*)

(*


collectedRts[repRoots[getB["fuhrerMoore"]]]
*)

(*
bRowsNow, bColsNow, numRoots,  modNameNow
doMexSplice /@ allLinearMods
mexComp/@allLinearMods

doMexSplice /@ allNonLinearMods
mexComp/@allNonLinearMods



{#,getExampleParams[#]}&/@allLinearMods
{#,getExampleParams[#]}&/@allLinearMods
*)

getExampleParams[modName_String]:=
getParams[modName]/.Global`getParamSubs[modName]
getExampleB[modName_String]:=
getB[modName]//.Global`getParamSubs[modName]


mexComp[modName_String]:=
With[{cmd=ToString[StringForm["mex ``MexBRtsComp.c  -lgfortran rpoly493.o ",modName]]},
Run[cmd]]

compEigen[mat_?MatrixQ]:=
Module[{code,vars,seq,optExp,locals},
optExp=OptimizeExpression[mat,OptimizationSymbol->forEig];
{locals,code}=ReleaseHold[ Hold @@ optExp/.Verbatim[Block][vars_,seq_]:>{vars,Hold[seq]}];
code01=code/.Hold[CompoundExpression[seq___]]:>Hold[{seq}];
code02=code01//.Hold[{aa___Hold, bb_, cc___}] /;
And[Head[Unevaluated[bb]] =!= Hold, Head[Unevaluated[bb]] =!= List] :> Hold[{aa, Hold[bb], cc}];
evs=Eigenvalues[code02[[-1,-1]]];
codeNow=ReleaseHold[code];
evs]






expHMat[modName_String]:=
Module[{eqns=getEqns[modName],hmat=Global`getHmat[modName],numhmat,prms,dims},
With[{matName=modName<>"Hmat.mat",matNameDims=modName<>"Dims.mat",matNamePrms=modName<>"Prms.mat",matNameSS=modName<>"SS.mat"},
numhmat=hmat//.Global`getParamSubs[modName]/.Global`getNonLinSSSoln[modName]/.makeShockSubs[modName];
With[{ssSubsNow=AccelerateAMA`makeSSValSubs[utilitiesSetUp`getVars[modName]]},
With[{ssVars=DeleteCases[(Last/@ssSubsNow)/.Global`getNonLinSSSoln[modName],_Symbol]},
dims={{neq=Length[hmat],nlags=AccelerateAMA`getLags[eqns],nleads=AccelerateAMA`getLeads[eqns]}};
prms=(getExampleParams[modName]/.$noDefaultValue->0)//.Global`getParamSubs[modName];
Print["ss"];
Export[matNameSS,{"ss"->ssVars},"LabeledData"];
Print["params"];
Export[matNamePrms,{"params"->prms},"LabeledData"];
Print["hmat"];
Export[matName,{"hmat"->numhmat},"LabeledData"];
Print["dims"];
Export[matNameDims,{"dims"->dims},"LabeledData"]]]]]
End[]
EndPackage[]
