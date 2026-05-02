#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[13] = {
      "789ced5d4d6ce344147657052d122c390077a4bd81aa36f4975be2a46948d2347192fe79"
      "491d7b92b8f15ffc934df78ec41e10485cd803421c90f684b8b11212"
      "5ac10524b8b0482c62b9a2bd704742422419bba9cd9a2424995d9bf71d6abfbe78be9937"
      "9d2f4f6f6c975a48e716288aba42617ca0e2e373b61db18f972837bc",
      "fe05fbf882c776f014b5e8bacef1bf6b1f79553151d7c486c2c9e8fc4a4195458553ccd2"
      "9986281d19aad441c2c0531725541265c45c3476fb96bc7dc1756ef4"
      "5dfd73ba89f81663c994de34863d942e1ae7f1b8e333dec531e3c1f8c423e2f11f27afd1"
      "afb36503e9065b8a65d884ca5b32524c834d89e68e5563195136784e",
      "4339554012cbac542b74992d55986a749da57bc1d35549ea5fdce1adaa61226d49768de3"
      "64ca713ced3b0eec6920b34a6f93e3334cdde2cdd9cd53c197cfed9f"
      "d93ce180d9b3343a6ecf8f390eef71f8f9cb83e383fb0f1648f2e56f7fbc4e92cfc1e3e2"
      "ebfab437eedfe14b3e7c118fffacd85ab55a39eb404baf36baf1dc69",
      "49d18e52c37eec8de019d50fcac726d57ed8d7f3b8e358f4d8c371608fa188da2cf946ea"
      "aea8342434e4bb3b25dfb12f9fdb3fb379d27abfaf9a5c4d4206db0f"
      "de98df93b3d28baf7f26abbfbf6ddcbc4392cf41d8f57753adbc9611921b71d449744a31"
      "71f90c456b3ba0bf4f5adeab4d398e67478cc3f1f7e5bfaf2c72af9b",
      "17f94fa6e4279d07effbf2b9fd33fdde7402d79b3b52bad1fe91ac0edffbe6d2ef24f91c"
      "845d870fc55673adb041970b9bfa8dca9adede693514c88343a7c3cf"
      "8c1887e3efcb493c5bddcbdb765075b8e4cbe7f6cf54870781c313474a37deba475687ff"
      "b8d9e649f23908bb0ec74fb9236bb5decdc68a4dbaa99457e8185388",
      "830e07653d433d0203ea11f3e5837a0406d423266bff339febc78d63c6a7fd88c77f9cce"
      "26af5d953953e26abaaa9a57595355a59ada65912cb1925863b18fd5"
      "54e9ac6e29aca89848d75696e405c6d47b62545273c86caa423ae1eaff7b53f6ffd511fd"
      "77fc7c4f6ef4a541a7144ec227bdae7226b2cf71ef8ca462cde47bc1",
      "0bbffe3998954ebf3982cff1f7e673f7d1f36934391d09ec2060f6cf57ec83133efb0cc7"
      "8ffd47fcfa524d4a570a2fdf27aad3d441ec5ba27c36c2aed3b9f4de"
      "5a05891b475bb9689157f582bc92d643a4d3b77dae1f378e299ff6231eff143a6d9f55af"
      "ab7a0bf4d963833e3f7a3ca0cf18a0cfffce33aa1f948f1d943ac6ff",
      "b19e1ca3e964d6b6a19e3c41fd691038b2f5e42fbe275bcff8e1d37491249f83b0ebb0c0"
      "b7e2d94ea79d5068ba4ed7caf51a5aae24418783b29ea19e8c01f5e4"
      "f9f2413d1903eac993b51f963cf864ca715cf6d8c371604f5ff6994c3a11d4bc97f83c39"
      "0123acbb7f12d65dfaedb504493e0761d75d31c3ac36f9eeb67c8698",
      "dcf2f2d6752ebd61c1fd6c8159cf90f76240de3b5f3ec87b3120ef9dacfdb0e8efb4f5df"
      "719feb30344934a3a6aab72db2cf7578f43870cf755c0c1cc1e73a48"
      "d77f6fbd9f83fa2f357b1d8e0a697ad7e085c34e4cc84b4dae90deb7b2703f71e874f88a"
      "c7f68ec3f1eba8d74b09551d250e6a5e7ce8cbe7f6cf6cdedc8123fe",
      "be09f627b27afce1c3cc2d927c0e82aac72ffaf0453cfed6ba6c75b66add7c2ea929a56e"
      "ad68ded86b53e1d1e3bb3ed7876d5d437d0203ea13f3e583fa0406d4"
      "27266b3f7079f193707f5ab9943fb0eda0eed33d9efb59fa81237b7fda5f8475f8cb8f3e"
      "f98e249f83b0ebf01b9d4d7a5b47515568706277d95413ed5405ea13",
      "8159cf900763401e3c5f3ec88331200f9eacfdb0e8efb47930ecd3b93f07fb74ff8d0ff6"
      "e930609f6eb2f64187ddf1f01b07ecd3c13edd247cb04f8701fb7493"
      "b50ff5618c09df875974de9b01f5e1c9de9f574c91ad0fff42f8ff737cfed53bbf92e473"
      "10541d1efb7d984d01e585cc6add6052a57d53489d660feaf0fc7260",
      "d633d48731a03e3c5f3ea80f63407d78bcf6ff06fcd165d5",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 28592U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740097.04964120372));
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
                emlrtMxCreateString("KYYSp4BokFpyD3l8NBOmWE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
