#include "_coder_get_ET_mex.h"
#include "_coder_get_ET_api.h"

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&get_ET_atexit);

  get_ET_initialize();

  unsafe_get_ET_mexFunction(nlhs, plhs, nrhs, prhs);

  get_ET_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "windows-1252", true);
  return emlrtRootTLSGlobal;
}

void unsafe_get_ET_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
                               const mxArray *prhs[2])
{
  emlrtStack st = {NULL, NULL, NULL};
  const mxArray *b_prhs[2];
  const mxArray *outputs;
  st.tls = emlrtRootTLSGlobal;

  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        6, "get_ET");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 6,
                        "get_ET");
  }

  b_prhs[0] = prhs[0];
  b_prhs[1] = prhs[1];
  get_ET_api(b_prhs, &outputs);

  emlrtReturnArrays(1, &plhs[0], &outputs);
}
