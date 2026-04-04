#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[7] = {
      "789ced55cb6ed34014755081b200b262c506a93b50d4146829bb34af86247d60372a744a"
      "70ec4963751e663c4e53fe018158f00bb040083688256207e20358f0"
      "31c4b1dd34a68323120635ca5de4cecdf1dc731ff189922855138aa25c527cfb74d5f717"
      "833819f833caa045f144e0cf4662e5e8fb99817b21fe3cf006251c76",
      "b81f101dc3a39b26c516d109d70e6da830e850d486660f695a086a1686eaf160cd8b70e1"
      "187414789077ceb6a0b1afba58612da75f213a1ef4e721e87766c879"
      "a882792423f84e7e377b176c39903940cb94418e1a2e86843ba068f155b701540b3b866e"
      "c32a3521026aba5ecb6e01ada6d6171641b63b3c4611f22eb70db7ee",
      "7068a7f0401f8f47ece39cb00f1fd983bc9e2dc8e37338730d3ebe3d6d0af906f1b1edc9"
      "1f58b0a5f8b95d1eb28fa8ef3f3fdbf36fbffc4cc8e4fbf8ea832993"
      "2fb4ffc5d711e41bf6777845c0978ce015565e4a17cd7964aaa57bc876544cf68bd97e1d"
      "1b313c717528825856fe49d15d7bc43e2ec4f411e29e9cac54ea1beb",
      "417c5a755813f20de263d5e1dee0fcc5c9d28d779275f8dbecf233997ca14dbc0e2fce37"
      "6f3d2d3ca8e8cd83ede27a21f384635298eaf069799f87ed632612f7"
      "fbf0118758f638f96275d7227b08f6f9de8fc8b71e8995c873213eb63d7903ebae48963e"
      "bc96acb7edefe75fcae40b6dd2f5f60eaddd2c9bf9a515d8ceb5b58c",
      "357f08171aab93a3b7a3bec76541fe6404df2955f2bb7358e7486f304af91ce094a206ed"
      "008811405603f818b0293a6cba0458844366a75338a172d6151f8d56"
      "216f51b3941ba8ffc588f5df88a93fc48daebcb054af28a223ffd02d55e73038fbd53979"
      "e28ee57f206aa2fa420bf93eff255f98ff510c5f8877f7b976f23e9d",
      "96cea0097a030b3eaf072e1c5f70f2e7077e9b9ff74f2a4b5736affd90aad3ca76e6ab54"
      "bec0265da7aba58ddb35682d3d5cae2edc3728dbc4e9129b209d7e23"
      "b83fec1c8b82fcc9083e824e07a7fa0165fb537d8ec4537d3eb99fa93efb36d5e73ff3c4"
      "d5a108e27f9dff177726fb46",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 7376U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *propFieldName[9] = {"Version",
                                    "ResolvedFunctions",
                                    "Checksum",
                                    "EntryPoints",
                                    "CoverageInfo",
                                    "IsPolymorphic",
                                    "PropertyList",
                                    "UUID",
                                    "ClassEntryPointIsHandle"};
  const char_T *epFieldName[8] = {
      "Name",     "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "FullPath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_26\\Controllers\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740074.43857638887));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("24.1.0.3050227 (R2024a) Update 8"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("iqaxupTOaewg6C5YhGBrD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
