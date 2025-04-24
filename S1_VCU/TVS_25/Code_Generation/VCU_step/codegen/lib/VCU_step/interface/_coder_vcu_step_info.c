#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5c4d6fe34418765041acc42ebdc02fd8dba2aa693769f9124a9cef2f67378eb329"
      "2e696c4f1b6f6d4f644f1ca7a74adc90105ce18ec40d247e001cf80d"
      "1c587e01d21e3871258eed263135ce36d63435f31c3a7ef536f33c99899fbc7dc72a9528"
      "d71314453da01c5cd69cf1be1b6fbbe36bd432fcf9843b3ef0c51e5e",
      "a7b6965ee7e5bf7247116a0858c809b4be0aae5e294155d6fa1a62274340e9c0808a09a4"
      "59e65456002baba0b51834ec482d2ca4ae023b655fd303209eb7462a"
      "a50f8cb9426531b87a1fdf07bcdfad15d7a318b01edbbefca7f963fa03be6d00dde0d94c"
      "95cf4171a4020d197c5146a591c0b764d510fb4350871250f856b2c7",
      "d16d9ee55abdbd146f8aa39e81c07047bdd23d5c53f75b21babdfc1940b6929e3a9565c7"
      "1effc99afc6f04f23b1903e92311cdf97e5c93af1ac8b79c5f6b9f16"
      "176bba5736c2d6ebed15f5fbc7f9efbf391b8fbf7c91c0c957142f5fe0e4f3705b7c56c0"
      "7cab7efede09e0dbf6e51fe74f33d9749de98e9b07d5d4d9fb9d42a3",
      "73b0a0a319c213a6830a8871cd7f57fdf6644ddd617e675b075db83d7f5d775ff2817ccb"
      "f9b5fd952ecc9c15970ffcfd035e5ffdebe7e2c738f93cdc555f7d37"
      "806fdb97af571885b1c4ec333a9bcbb0ed74daaa749f1788af6eeafdbbaaee2d5f3cd7ed"
      "640c4d9e95cad87c55d6ce1410ddbed0817ccbf9b5f6c55e24ccf5ea",
      "6f08afafdeffeecf039c7c1ee2eeab8790dbaf4af9832c3073269b917727604f28c5c757"
      "b1fddd59aee58f1faa7da4f4051d42f49047102a02b478a02abc220b"
      "bc93e38750999c8e345ed610d087c91d35d142fad4745858076800a5726e49ffd76bea7f"
      "2f44bf9717a7b6a2efcc44697dc5b9984aed23e05e3bea8cbc365217",
      "f59ddc509f1f41fa3c787cbfdc90cf9bffb3103e2f3fddcfc6f5fb690cfa3a90f8d982b9"
      "3f1fb983b77cee95b37efcbfd6cfb66a5cbef2f2f3dfb1faf4e5273f"
      "7d8393cf43dc7d9a3199a294b220a755327bb239d8179e8ed8627c7c1a5b5fe1e63eed5e"
      "f5c6503f27feec8b893f5fff7e883f3b20fefcdf3c613aa8803876fe",
      "7c07fbbed91ae9fb86f68db235ac7d5fdce7691f7e44ced36c44edabf498d995c6fb83a2"
      "95ef5aa09181ccd392487cf57fe1ab4d96f86aa8af36d9589fa77d5b"
      "2a93f3342a7a5f05837259ac33b492dfad9b93b36e675c1164729eb6b1f72f394f7340ce"
      "d3a2e123e7690ec879daabcd4fea55bfee79bdcab548bd1afe7c6d2b",
      "d6f5ea1f2f6ba45ea5a27fae56a88a8566724f4e1d9a174df3a8d63dec74173f47c457af"
      "9f3f16be4afa002bf82ade3e00eefe6ae70bd25fb51175bdfadc7af6"
      "0459ec3859281d292a2d0d8db650a589af6eeafd1ba5afb234f1d5d07d61e958d7abbfde"
      "ab927a958ade571b9a7c517b526a7005fd3173d44902ae733ec9125f",
      "ddd4fb97f4571d90fe6a347ca4bfea80f4575f6dfe3be3abb751af72a45e0dffbee362dd"
      "0720ffb7c041d4beba9f6a984cdaaced262f7269a67208e5f6b04e9e"
      "b3dad8fb97d4ab0e48bd1a0d1fa9571d907a75b5f9ff0157028e46",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19608U, &nameCaptureInfo);
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
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 4);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "ResolvedFilePath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739680.77336805558));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("24.2.0.2806996 (R2024b) Update 3"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("swErENSHbsgpDKGaCN8bOC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
