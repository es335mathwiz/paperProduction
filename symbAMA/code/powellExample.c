#include "gsl_multiroots.h"


/*
35.3 Providing the function to solve

You must provide n functions of n variables for the root finders to operate on. In order to allow for general parameters the functions are defined by the following data types:

Data Type: gsl_multiroot_function

    This data type defines a general system of functions with parameters.

    int (* f) (const gsl_vector * x, void * params, gsl_vector * f)

        this function should store the vector result f(x,params) in f for argument x and parameters params, returning an appropriate error code if the function cannot be computed.
    size_t n

        the dimension of the system, i.e. the number of components of the vectors x and f.
    void * params

        a pointer to the parameters of the function. 

Here is an example using Powell’s test function,

f_1(x) = A x_0 x_1 - 1,
f_2(x) = exp(-x_0) + exp(-x_1) - (1 + 1/A)

with A = 10^4. The following code defines a gsl_multiroot_function system F which you could pass to a solver:
*/
struct powell_params { double A; };

int
powell (const gsl_vector * x, void * p, gsl_vector * f) {
   struct powell_params * params 
     = (struct powell_params *)p;
   const double A = (params->A);
   const double x0 = gsl_vector_get(x,0);
   const double x1 = gsl_vector_get(x,1);

   gsl_vector_set (f, 0, A * x0 * x1 - 1);
   gsl_vector_set (f, 1, (exp(-x0) + exp(-x1) 
                          - (1.0 + 1.0/A)));
   return GSL_SUCCESS;
}

gsl_multiroot_function F;


/*
F.f = &powell;
F.n = 2;
F.params = &params;
Data Type: gsl_multiroot_function_fdf

    This data type defines a general system of functions with parameters and the corresponding Jacobian matrix of derivatives,

    int (* f) (const gsl_vector * x, void * params, gsl_vector * f)

        this function should store the vector result f(x,params) in f for argument x and parameters params, returning an appropriate error code if the function cannot be computed.
    int (* df) (const gsl_vector * x, void * params, gsl_matrix * J)

        this function should store the n-by-n matrix result J_ij = d f_i(x,params) / d x_j in J for argument x and parameters params, returning an appropriate error code if the function cannot be computed.
    int (* fdf) (const gsl_vector * x, void * params, gsl_vector * f, gsl_matrix * J)

        This function should set the values of the f and J as above, for arguments x and parameters params. This function provides an optimization of the separate functions for f(x) and J(x)—it is always faster to compute the function and its derivative at the same time.
    size_t n

        the dimension of the system, i.e. the number of components of the vectors x and f.

    void * params

        a pointer to the parameters of the function. 

The example of Powell’s test function defined above can be extended to include analytic derivatives using the following code,
*/

int
powell_f (const gsl_vector * x, void * p, gsl_vector * f) {
   struct powell_params * params 
     = (struct powell_params *)p;
   const double A = (params->A);
   const double x0 = gsl_vector_get(x,0);
   const double x1 = gsl_vector_get(x,1);

   gsl_vector_set (f, 0, A * x0 * x1 - 1);
   gsl_vector_set (f, 1, (exp(-x0) + exp(-x1) 
                          - (1.0 + 1.0/A)));
   return GSL_SUCCESS;
}
int
powell_df (const gsl_vector * x, void * p, gsl_matrix * J) 
{
   struct powell_params * params 
     = (struct powell_params *)p;
   const double A = (params->A);
   const double x0 = gsl_vector_get(x,0);
   const double x1 = gsl_vector_get(x,1);
   gsl_matrix_set (J, 0, 0, A * x1);
   gsl_matrix_set (J, 0, 1, A * x0);
   gsl_matrix_set (J, 1, 0, -exp(-x0));
   gsl_matrix_set (J, 1, 1, -exp(-x1));
   return GSL_SUCCESS;
}

int
powell_fdf (const gsl_vector * x, void * p, 
            gsl_vector * f, gsl_matrix * J) {
   struct powell_params * params 
     = (struct powell_params *)p;
   const double A = (params->A);
   const double x0 = gsl_vector_get(x,0);
   const double x1 = gsl_vector_get(x,1);

   const double u0 = exp(-x0);
   const double u1 = exp(-x1);

   gsl_vector_set (f, 0, A * x0 * x1 - 1);
   gsl_vector_set (f, 1, u0 + u1 - (1 + 1/A));

   gsl_matrix_set (J, 0, 0, A * x1);
   gsl_matrix_set (J, 0, 1, A * x0);
   gsl_matrix_set (J, 1, 0, -u0);
   gsl_matrix_set (J, 1, 1, -u1);
   return GSL_SUCCESS;
}

int
print_state (size_t iter, gsl_multiroot_fdfsolver * s)
{
  printf ("iter = %3u x = % .3f % .3f "
          "f(x) = % .3e % .3e\n",
          iter,
          gsl_vector_get (s->x, 0), 
          gsl_vector_get (s->x, 1),
          gsl_vector_get (s->f, 0), 
          gsl_vector_get (s->f, 1));
}

int main(){

gsl_multiroot_function F;



gsl_multiroot_function_fdf FDF;

const gsl_multiroot_fdfsolver_type * T 
    = gsl_multiroot_fdfsolver_newton;
gsl_multiroot_fdfsolver * s = 
    gsl_multiroot_fdfsolver_alloc (T, 2);
printf ("s is a '%s' solver\n", 
        gsl_multiroot_fdfsolver_name (s));
/*


*/
struct powell_params params = { 10000.0 };
 int status;
 size_t i, iter = 0;



 FDF.f = 0/*&powell_f*/;
 FDF.df =0/* &powell_df*/;
FDF.fdf = &powell_fdf;
FDF.n = 2;
 FDF.params = &params;
double x_init[2] = {-10.0, -5.0};
  gsl_vector *x = gsl_vector_alloc (2);

  gsl_vector_set (x, 0, x_init[0]);
  gsl_vector_set (x, 1, x_init[1]);

  gsl_multiroot_fdfsolver_set (s, &FDF, x);


print_state (iter, s);

  do
    {
      iter++;
      status = gsl_multiroot_fdfsolver_iterate (s);

      print_state (iter, s);

      if (status)   /* check if solver is stuck */
        break;

      status = 
        gsl_multiroot_test_residual (s->f, 1e-7);
    }
  while (status == GSL_CONTINUE && iter < 1000);

  printf ("status = %s\n", gsl_strerror (status));

  gsl_multiroot_fdfsolver_free (s);



 gsl_multiroot_fdfsolver_free ( s);

  return 0;
}

/*

Note that the function powell_fdf is able to reuse existing terms from the function when calculating the Jacobian, thus saving time. 

*/
