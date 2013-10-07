/* the gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
double* theParams;
double* theLilA;
double* theQ;
double theIaVal=<*$lilARowsNow*>;
double theJsVals[<*Length[$jsNow]*>]=<*$jsNow*>;
double theIqVal=<*$zfRows*>;
double theNeqVal=<*$theNeqNow*>;
double* theIa;
double* theJs;
double* theIq;
double* theNeq;
int ii;



  /*mexPrintf("Hello, world!\n"); */
  /*  get the params */
theParams=mxGetPr(prhs[0]);


  /*  set the output pointer to the ll matrix */
  plhs[0] = mxCreateDoubleMatrix(<*$lilARowsNow*>,<*$lilAColsNow*>, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theLilA = mxGetPr(plhs[0]);
   /*  call the C subroutine */
    <*$modNameNow*>LilAComp(theParams,theLilA);
  

  /*  set the output pointer to the ll matrix */
  plhs[1] = mxCreateDoubleMatrix(1,1, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theIa = mxGetPr(plhs[1]);
theIa[0]=theIaVal;

  /*  set the output pointer to the ll matrix */
  plhs[2] = mxCreateDoubleMatrix(1,<*Length[$jsNow]*>, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theJs = mxGetPr(plhs[2]);
   /*  call the C subroutine */
for(ii=0;ii<<*Length[$jsNow]*>;ii++)theJs[ii]=theJsVals[ii];

  

  /*  set the output pointer to the ll matrix */
  plhs[3] = mxCreateDoubleMatrix(<*$qRowsNow*>,<*$qColsNow*>, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theQ = mxGetPr(plhs[3]);
   /*  call the C subroutine */
    <*$modNameNow*>QComp(theParams,theQ);

  

  /*  set the output pointer to the ll matrix */
  plhs[4] = mxCreateDoubleMatrix(1,1, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theIq = mxGetPr(plhs[4]);
   /*  call the C subroutine */
   theIq[0]=theIqVal;

  

  /*  set the output pointer to the ll matrix */
  plhs[5] = mxCreateDoubleMatrix(1,1, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  theNeq = mxGetPr(plhs[5]);
   /*  call the C subroutine */
   theNeq[0]=theNeqVal;

  
}

