#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[9] = {
      "789ced5abf6fd3401476504130006161077541d08ab44d5aba254e9a5af95d27a16aaf04"
      "c7b936566d9f6b9fd3a433b0c2cec2c8c8d88181010990f80318d8f9"
      "23108224f6358dc13825d1a1b87e43ee9e3edf7defbdcb7d8eeec284b85c8861986b8c65"
      "2b73567bd5f6c3767b811936271eb2dbcb0e9fd8456666681cc19fdb",
      "ad88540cdbd87254418127231b48915441c5e58e06191d1a486ec1461fd99564589614c8"
      "9f76f23d4f593b059d383da8d7679b50dce74d85d19bc62042f9b473"
      "528f63977c6746ac07ef528fb003df4eedb0aba06240dd00e578062491682a50c506484b"
      "78ddac035e520c51d0600e35a00cf848adca5640b9cad7166280ed16",
      "4f47b2dc1bdc12cd9a81a136af0ce5f178cc3c2eb9e661217b10d7d8357a7c06d64d114f"
      "6e9d4aae7cc3f8c4d6c92a98bd4ade75bb3e621ece76f0bcb5339b1f"
      "bf8668f23db923dfa0c947ec7ff1b55de61bf57b78d3852fecc0d554e4a0d05942a2a245"
      "613e564a0805b1981cc451f4e0f18a8371f169cdef17ddd5c6cce38a",
      "471e04efc949225b2b166c7f5a75b8ecca378c4f5487fb85b3168e966e6c51d6e1876f7f"
      "dca6c947ccef3acc65387ca0671acd145bccd51717f9cd62f53011e8"
      "f0b4ece751f39871f8833c2cc450256d927c9eba2ba97b321cf0bd1993afe0f019c77304"
      "9fd83af50ad65d225afaf0ec035dbdfdf95df846938f98dff5760555",
      "17338dd47202b692ad725cbadf810bf575ffe8edb8fb38e3327fd8816f73d9d4ceac2260"
      "59a8eb08e159801192eba80da0220359aa030b031a923bbba60a2415"
      "435d8bcc2b211eeb5df129a31cc44dd4e09243f1bf1833fe7b1ef1135cecca8b3edf0f4a"
      "1564abd30d55c0d0ee5bd11929d59cc87bc0696ef111237ceffe918f",
      "ccffc8838fe0ddf5ccff793d8da6a0c306e817ccfebc6b37a47c76cfaa1ff8ad7ebd3729"
      "2d5d29ddfa4255a799cdf827aa7cb6f95da7735c315a85d2f2d683dc"
      "c28688f49212e1741fe9f46b97f1a3d631ed327fd8818fa1d376af7688f4fd409f1d7ea0"
      "cf7fce27d067cb027dfe3b8f571c8c8b3f2de716e7f1fc38ceb2a9ac",
      "ed07e7c767386fea178eeef9f12ae5f3e357ef8f5fd2e423e6771d5ec14759a9a29aed22"
      "cb56cd2a1f8ba623b1b54087cfb30e27b2b50df2fb3fd0e1b39dfb6f"
      "a4e9ea70e6335d1d9e7b0a389a7cc4fcaec3a8b514abb79347d14a7ee5607d57dc529796"
      "f782ff534ccd7e0eeef12c0beef126cb17dce35916dce38d36ff2ff7",
      "ce0411",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 11600U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740081.50071759254));
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
                emlrtMxCreateString("aSagjNVu06PGbTrMkNbXeB"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
