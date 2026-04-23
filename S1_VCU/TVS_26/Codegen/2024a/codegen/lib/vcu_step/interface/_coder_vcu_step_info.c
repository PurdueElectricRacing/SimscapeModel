#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5bcd8fdb441477d0828ac4472ea0de50a5563d8056ddec57cb89c44977ad7c7f6c"
      "badbbacdfa63b2316b7b1c7b9c662b21f11fc011891b121247242edc"
      "40150790e0c4a5871ea8b8c18523070e2419cf26313549b035c5eebcc38e9f7ef1fce6bd"
      "b7f3cbe8c5e6524239c571dc6b1cb68b3c1e5ff5fcb437bec0cd9b1f",
      "4f79e32b3e9fd88bdcdadc7d04ffc81b1568223044d83125039cdfa94243332513b5ce2c"
      "c0d9c081fa00a813a4abe9a0a519a039eb54c69e7173063a77c6d0f8"
      "9aef01e5b4e91a9cdd73a62bd4679df37c7c1d10efda92f96806e423edc3ef14eef2ef8a"
      "070eb01db1952d8a79a8b806309123ee6968df95c5a666388a648132",
      "54812e36373a6dfe406cb59b9dcc8ec88f9267435d1fdf3c50dc8e8380b56eccc5711c32"
      "8e9702e3c0c809401dfe263d3e07d9ae82a2ab533d906f1e8fac4e38"
      "615e9516e7edf525e3f08fd3cf5f988c9f7cff384593efbdbfbebb4a938fd8b3e21b06cc"
      "b7ecffe19b017c691f6e1636fad5b32da818d636a8ecd4735255a9e5",
      "a7eba82de059b40e2ec0a7357f5274d70a19c7cb0be220f8584e72a54eadeaf971d5e156"
      "20df3c1ea90e4f12870b474b377efb91ae0e7f76f4cd0734f988255d"
      "8785a280fa7651ed15f85a59dedc6c1ed6daf7734c87e3b29f978d63cde74fe3c088636a"
      "56947c0b7557334f7430e5fb32245fd5e773becf113cb23a8d13362a",
      "112d7d38ced2d55b4e7e52a4cae759d2f5f63a6c6f16d5c26e0e0cf2835656bb760632f2"
      "7e72f436ec3e2e06cc9ff6e1778452e1ee654342ba24db10a2cb2282"
      "5097e15004862eea9a2c624cb4a07ed6754d513311b0ad8d7523d544f6487c5ab00c500f"
      "aa427e6efd1f875cff3b0bd64f7065242ff6fa6451a6a4e38bd15225",
      "04bc6bbc3aa760ba917c0ff82d687dc408dfb7ff918fcc7f6f011fc147f5ac3cbd9e4e4f"
      "b2812a4e12e6fd7ddb1b48fabc2b9c3ff11ff91b7f93d2d295faa547"
      "7475fa30fb03553ecf92aed365a1b6dd06daeeed1be54c438176ddd810ec04e9f41701f7"
      "2f9bc7bd80f9d33e3c844e7b579dfbd03e65faecf3993e3f3d1ea6cf",
      "d8983eff3bcfa27570017e5cfa16cf63ff38cbf38592e7b3fef10afda649e2e8f68f2ffe"
      "44b79f71e5c9c33f68f2114bba0eabca69ae3418f4f326cf7779f9a0"
      "2b836bed02d3e1b8ec67d63fc6c6fac7d1f2b1fe3136d63f5e6dfea49c7b8f43c671c1e7"
      "4fe3c0c858e69b45211fd7732ef53a91842d59a7a87442ff99aeee3e",
      "32be6ad0e4231657dd7d23802fedc36f648687edbad5c8d51f1cbd3f6cd8fa517eb7cc31"
      "dd8dcb7e66e75c6cec9c1b2d1f3be76263e7dcd5e64f8ade86edef06"
      "bd6f93f6e18ea56b2883a0dd77c12cff7148fe55f5376cdd6e05f2cde3d1e9ef4ce228ea"
      "f09f949f0f7efcd6e7bfd3e42396741dcea8025f7114f5689055ab7a",
      "4faa0bb7dc127b3ef87fd76f08abc32bbea7d120cf77c4b5fff0ac9eeb6eecd1fd9ded43"
      "ca3afcf0d35f7ea5c9472ce93a0c075b3bf230ff60fba072bdbfdf55"
      "6e9b5bbb27ec7db9d8ec67d67fc0c6fa0fd1f2b1fe0336d67f586efebf01baf96313",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 17200U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740095.74665509257));
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
                emlrtMxCreateString("RUSi5TE2OKmEhSMowBH5H"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
