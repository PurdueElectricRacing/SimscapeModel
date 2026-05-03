#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5d3b70e34418568ec0dc3170a4e1868e814907649c84c4310c45223f6212e761c9"
      "4e8ed39d2359eb58b11e8e1eb6938e1928a081860266e8af62286f86"
      "e6e6a828681866381e35732d1434571c76564a2c71c2526c6f22cdff159136bfb5dfeeaf"
      "e8cbef6f370e35912f4c5014759dc2b8fb313ebe68b7a7ece315ca0d",
      "6f7cc23ebee2693b78969a745de7c43fb38f554d3551c7c40d9557d0e995a2a6482aaf9a"
      "ec5113513a3234b985c493484d92112b2988e96f6cf45a4ab62f74da"
      "e8857ae7741d551b8ca5507add381ba1dcdf38cdc73d9ff94e06cc07e3938f294ffc56e6"
      "36fd0e5732906e70ecf21a97d6aa968254d3e07292b96a091c232946",
      "956fa28226229963662b65bac4b165a632b7c8d1dde4e99a2cf72e6e55ad8a61a2e68ce2"
      "9ac7de90f378ce771e38b28fcc0a9d25c76798ba553547779fb67df9"
      "dcf191dd279c30fb2e0dcedb4b01e7e13d9ebdfeeac9f1f9dfff9820c9f7c57b0ff324f9"
      "1c5c145fc7a7bfa03f872ffbf04d79e225b1babe4ce7b26291cd2fa8",
      "b9f2fb85835cba6f1c5b0378068d83f26993ea3feecf73d0794c7ada67f3c01143959aa3"
      "e41ba8bb92ba2fa333befb43f2ddf2e573c747769f9addef574c5e90"
      "91c1f59217f0f7e4a8f4e2fb5fc9eaef9fc94fee91e4731055fdbde1c337e5892f69e5f9"
      "3531935c41ad748b5d961247684e588d8ffe7eeb737dd03caef9f43f",
      "e589dfcaaf676e4f2bbc29f382ae69e634676a9a2c681d0e2932274b0287635c53938f6a"
      "96ca49ddf7097a73764699604cbd2b46ac5640665d13f369d7f83f1f"
      "72fc6f0e18bf13af76e5469f391994cacbf8a43b54de44f6391e9d91512da57f7c7be71c"
      "9f177ee373302a9dbe3380cf8977efe7c6d3efa751e77524722709b3",
      "bfbe611f9cf4d967387fdc7ff2d7936a52bab2fdda43a23a4ded2eff4094cf46dc75ba90"
      "df5a282329f941aa3057ac6afab6329bd763a4d3777dae0f9ac79c4f"
      "ff539ef8103a6d9f55da9ade007df6b4419f9f3e1fd0670cd0e7ffe719340ecaa71d151f"
      "e3b2f8c7cd21e7f1c2807938f19e8dd27b87ae7487d9cfbf37243f69",
      "3f79c797cf1d1fa9ffe424ae7befe2ea27ff7de3dd3a493e0771d7e1c4c1427b516aa732"
      "42bb396f19ed86c25a16e870ec74f8da807938f19e9cacac57b636ed"
      "76547598f5e573c747aac327899b09f47e6254ba91fa8dac0e7ff4ea8363927c0ea2aac3"
      "41d7f59275545ed28f1abc50db2fb22d89ddcf8b290a74382acf33ac",
      "eb61c0bade78f9605d0f03d6f5c2f50f753046983a7899a633eb761beae010bf374f1247"
      "b60efeee47b23afcd337f922493e0771d761b1da58596fb50ed32a4d"
      "d768a1541350a29c011d8ecaf30c753006d4c1e3e5833a1803eae070fdc7a50ede1b721e"
      "573dedb379e0484ff699b57c3aaa752ff1fbe4248cb0eebe45d8ff2d",
      "fd43fd4592cf41dc75575a63deae573b59e50831854422d5e6f3492b07ba1b95e719ea5e"
      "0ca87bc7cb07752f06d4bde1fa8f8bfe0eebff06dd8f663465c99c33"
      "35fdd022bb1fcda3c791db8fd69f3882fbd144c275f0b2fce067927c0ee2aec3c99dfa3c"
      "5deaec2eeda8898382ce8bbc286859d0e1b8e9f0754fdb3b0f27aea3",
      "ee286554719438aa75f14d5f3e777c64f7cd9d38e29f37c1fd42568fbf7eb4f625493e07"
      "51d5e3a0fbd21a8b8ad54a099dcd42a6a9b21da1681e6f1d52f1d1e3"
      "fb3ed7c7edb9067f0203fc89f1f2813f8101fe44b8fe2357175f86fd69257673d76e4775"
      "9dee62f6b3f41247767fda63c2fec49d27d3af93e47310771dced18a",
      "9453db3c73d0e2db9bf4b6b86a2636408723f33c431d8c0175f078f9a00ec6803a385cff"
      "71d1df61eb6058a773bf0ed6e9cec707eb7418b04e17ae7fd061773e"
      "fce601eb74b04e17860fd6e930609d2e5cff71f187f7869c4790bfdb60330c1b553ff842"
      "f6b7f41246d88fa0097f7e1af3e4d36748f23988aaee06ad83b70fb4",
      "7a2155dbded95c2a95b3da6e2d9b5e54574077a3f23c831f8c017ef078f9c00fc6003f38"
      "5cff71d15ff083c3f1811f3c1e3ef08331c00f0ed73fe8b03b1fe007"
      "bbe3e0079f8f0ffc600cf083c3f51f393dbe04fb8557d62b45e7ff3a45d51fbea8cf812e"
      "e6c8ee17be46d81ffeeac32b8f49f23988aa0e07f687cd067b7343dd",
      "d5adada479ccac6c767285047c9e65649e67f08731c01f1e2f1ff8c318e00f07ebff5fba"
      "8fd074",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 34240U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740105.44116898149));
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
                emlrtMxCreateString("wQoaHokuD4okOZ2zVas4TC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
