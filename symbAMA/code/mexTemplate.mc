/* the gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
double* theParams;
double* theB;
double* theRts;
int aimCode=1;
int ia,nexact,nnumeric,lgroots,aimcode;



  double *bPtr;
  double *rPtrRe;
  double *rPtrIm;
  double *acPtr;
  double  x;
  mwSize mrows,ncols;
  /*mexPrintf("Hello, world!\n"); */
 
  /*  get the params */
theParams=mxGetPr(prhs[0]);

  /* [bb,rts,ia,nexact,nnumeric,lgroots,aimcode]*/
  
  /*mexPrintf("done bb!\n"); */



  /*  set the output pointer to the bb output matrix */
  plhs[0] = mxCreateDoubleMatrix(<*$bRowsNow*>,<*$bColsNow*>, mxREAL);
   /*  create a C pointer to a copy of the output matrix */
  bPtr = mxGetPr(plhs[0]);
   /*  call the C subroutine */
    <*$modNameNow*>BComp(theParams,bPtr);
  
    /*mexPrintf("done rts!\n"); */

  /*  set the output pointer to the rts output matrix */
  plhs[1] = mxCreateDoubleMatrix(<*4*>,1, mxCOMPLEX);
  /*  create a C pointer to a copy of the output matrix */
     rPtrRe = mxGetPr(plhs[1]);
     rPtrIm = mxGetPi(plhs[1]);
  /*  call the C subroutine */
/*     callRPoly1(theParams,rPtrRe,rPtrIm);*/

     /*mexPrintf("done bb!\n"); */
   

  /*  set the output pointer to the rts output matrix */
     plhs[6] = mxCreateDoubleMatrix(1,1, mxREAL);
  /*  create a C pointer to a copy of the output matrix */
     acPtr = mxGetPr(plhs[6]);
  /*  call the C subroutine */
     *acPtr=1;

     /*mexPrintf("done aimcode!\n"); */
  

  /*  set the output pointer to the rts output matrix */
     plhs[2] = mxCreateDoubleMatrix(1,1, mxREAL);
  /*  create a C pointer to a copy of the output matrix */
     acPtr = mxGetPr(plhs[2]);
  /*  call the C subroutine */
     *acPtr=1;

     /*mexPrintf("done aimcode!\n"); */
  

  /*  set the output pointer to the rts output matrix */
     plhs[3] = mxCreateDoubleMatrix(1,1, mxREAL);
  /*  create a C pointer to a copy of the output matrix */
     acPtr = mxGetPr(plhs[3]);
  /*  call the C subroutine */
     *acPtr=1;

     /*mexPrintf("done aimcode!\n"); */
  

  /*  set the output pointer to the rts output matrix */
     plhs[4] = mxCreateDoubleMatrix(1,1, mxREAL);
  /*  create a C pointer to a copy of the output matrix */
     acPtr = mxGetPr(plhs[4]);
  /*  call the C subroutine */
     *acPtr=1;

     /*mexPrintf("done aimcode!\n"); */
  

  /*  set the output pointer to the rts output matrix */
     plhs[5] = mxCreateDoubleMatrix(1,1, mxREAL);
  /*  create a C pointer to a copy of the output matrix */
     acPtr = mxGetPr(plhs[5]);
  /*  call the C subroutine */
     *acPtr=1;

     /*mexPrintf("done aimcode!\n"); */
  


  
}

