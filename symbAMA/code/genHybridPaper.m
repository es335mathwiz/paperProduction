AbsoluteTiming[Timing[Needs["modDims`"]]]
(*{10.530689, {0.429934, modDims.mtex}}*)

AbsoluteTiming[Timing[Needs["preEvalTimes`"]]]
(*{360.125305, {351.138, preEvalTimes.mtex}}*)

AbsoluteTiming[Timing[Needs["ssSolnAllCompTimes`"]]]
(*{184.997570, {184.95, allCompTimes.mtex}}*)

AbsoluteTiming[Timing[Needs["linearCompTimes`"]]]
(*{25.762217, {22.5356, linearCompTimes.mtex}}*)

AbsoluteTiming[Timing[Needs["linCompMLB`"]]]
(*{83.751186, {73.7678, linCompMLB.mtex}}*)

AbsoluteTiming[Timing[Needs["linCompMLB`"]]]
(*{83.751186, {73.7678, linCompMLB.mtex}}*)


(*
AccelerateAMA.m       genMexCode.m	 nonLinCompMLB.m       timerLoop.m
allLinCompMLB.m       linCompMLB.m	 nonLinExeToMat.m      utilitiesSetUp.m
analyticTimerLoop.m   linExeToMat.m	 nonLinearCompTimes.m
docompareMLB.m	      linearCompTimes.m  preEvalTimes.m
docompareNonLinMLB.m  modDims.m		 
*)
