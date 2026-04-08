#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[8] = {
      "789ced583d6fd340187650f91a802cb02355ea00aada5434942d75d2d42469d3d80d28bd"
      "121cfbda989c7dc63e9b941f80c4043f020946464636c41f400cecac"
      "ec0c60c7769b981a1b6219c5f81d72f7e689ef793fecc7ca4be598468ea2a8cb94636f17"
      "9cf592ebe7ddf50c35697e3ce7aee77dbe6767a9b989eb3cfc85bb0a",
      "582170481c47e165787ca5886549e115c21da990d2a08e9109c511722021c8493264c79d"
      "2ddb9337c6a063c786ec3ddd87c28035644aebeb2711a271e7b81eef"
      "02f29d8b580f36a01e791fbe57d9a7ef805d1d6a3ae04a3550c682214385e8a02a914da3"
      "075849d6055e850d2c4204d8e56e9bde055c9bed1656016d154fc308",
      "d9175b5f777502d54579228f8753e6712e300f073984a44b6f24c7a713cd10487c7dda09"
      "e49bc463eb935330b74be175bb12310fff7af2fb0ba3f5f9872fb924"
      "f916be7d7a95249f67ff8a6f18705ed4fbf06a005fde870f201e1485d5ca46bbb12991a1"
      "52329f76ee8ec5d10ce1098b830af0933a3f2dbaab4e99c7c5903c3c",
      "dc9693f57ab7b9edfab3aac35c20df241eab0e8f0ae7342ead3adc32331db62dea7d782d"
      "802fefc3575b9de23d9a371963abba52a80fea6a47ac54331d9e95e7"
      "396a1e733eff240f07d115498d932f547725e510c1b1ff6d53f26dfb7ccaf73b0f8fad4f"
      "76c1ac1625a50fcf12d6db1fdff9af49f2799676bdbd8ddb2b35b152",
      "5c8766d9e44ad2d2112cf436d3a3b7d33ec7b580f3f33e7c8fa957f6e7659e20bea7614c"
      "e601c118f5f01040190124f580830115a3a30343019242a0a62e2fca"
      "39966896f870b801491f8b4c7922fe9753c67f33247e0f172c79d1164741293c723656a8"
      "3c81eede894eaf28462cef01bf05c5e799c7f7fe2ff9bcf31f84f079",
      "b8d5cfadd3fba9f7790d8a605430f7f386bb78e573774efdc02ff5b3dfa449e9cacef5cf"
      "89ea3475bff431513ed7d2aed30da679ab0da56267ad51680958db91"
      "97192d453afd26e0faa875ac069c9ff7e153e8b4bbeb3ec1da20d3679f9fe9f3e9f964fa"
      "ec58a6cfbfe7098b830af067656ef19fce8f5bde7b279b1fffd9bca9",
      "554df7fcf8e075363fb62d6e1d5ed79b4bb57ecd78dc796432446bd18788592b673a3c2b"
      "cf73363f762c9b1fc7cb97cd8f1dcbe6c7d1ceff099dc4ad53",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 10184U, &nameCaptureInfo);
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
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("VCU_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_26\\Controllers\\VCU_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740080.6285648148));
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
                emlrtMxCreateString("wzcRDlrWurX96I9yPjNF0C"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
