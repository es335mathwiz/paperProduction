#include "gsl/gsl_multiroots.h"
struct powell_params { double A; };
int
powell_fdf (const gsl_vector * x, void * theParams, 
            gsl_vector * fVec, gsl_matrix * jMat) {
   struct powell_params * params 
     = (struct powell_params *)theParams;
   const double A = (params->A);

   const double x0 = gsl_vector_get(x,0);
   const double x1 = gsl_vector_get(x,1);

   const double u0 = exp(-x0);
   const double u1 = exp(-x1);

   gsl_vector_set (fVec, 0, A * x0 * x1 - 1);
   gsl_vector_set (fVec, 1, u0 + u1 - (1 + 1/A));

   gsl_matrix_set (jMat, 0, 0, A * x1);
   gsl_matrix_set (jMat, 0, 1, A * x0);
   gsl_matrix_set (jMat, 1, 0, -u0);
   gsl_matrix_set (jMat, 1, 1, -u1);
   return GSL_SUCCESS;
}
int
print_state (size_t iter, gsl_multiroot_fdfsolver * aSolver)
{
  printf ("iter = %3u x = % .3f % .3f "
          "f(x) = % .3e % .3e\n",
          iter,
          gsl_vector_get (aSolver->x, 0), 
          gsl_vector_get (aSolver->x, 1),
          gsl_vector_get (aSolver->f, 0), 
          gsl_vector_get (aSolver->f, 1));
}
int main(){
gsl_multiroot_function_fdf FDF;
const gsl_multiroot_fdfsolver_type * solverType 
    = gsl_multiroot_fdfsolver_newton;
gsl_multiroot_fdfsolver * aSolver = 
    gsl_multiroot_fdfsolver_alloc (solverType, 2);
printf ("aSolve is a '%s' solver\n", 
        gsl_multiroot_fdfsolver_name (aSolver));

struct powell_params params = { 10000.0 };
int status;
size_t  iter = 0;



 FDF.fdf = &powell_fdf;
 FDF.n = 2;
 FDF.params = &params;
 double x_init[2] = {-10.0, -5.0};
 gsl_vector *x = gsl_vector_alloc (2);

 gsl_vector_set (x, 0, x_init[0]);
 gsl_vector_set (x, 1, x_init[1]);

 gsl_multiroot_fdfsolver_set (aSolver, &FDF, x);
print_state (iter, aSolver);
  do
    {
      iter++;
      status = gsl_multiroot_fdfsolver_iterate (aSolver);

      print_state (iter, aSolver);

      if (status)   /* check if solver is stuck */
        break;

      status = 
        gsl_multiroot_test_residual (aSolver->f, 1e-7);
    }
  while (status == GSL_CONTINUE && iter < 1000);

  printf ("status = %s\n", gsl_strerror (status));

  gsl_multiroot_fdfsolver_free (aSolver);


  return 0;
}

