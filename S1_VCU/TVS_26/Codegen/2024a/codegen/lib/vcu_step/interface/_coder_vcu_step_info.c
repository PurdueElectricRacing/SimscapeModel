#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5dcd4fe346143715adb66acb4695b6aaaa5e56da5377c506b210e80d1213b22124"
      "242604300d4e3210137fe18f1090f6d81efb716b4fbdf4b0c7aaa71e"
      "39545af51fa8b6d5b652ff834abdf5d438630376d78dbd49066cbddf01fbf1e2f9cdbc61"
      "7e3cde0c093591cd4f50143545613cfd145fdfb1ec98757d8d72c2ed",
      "9fb0aeefbb6c1baf53938ee76cff17d6b5214b3aeaead89038115d3cd994455ee2249d39"
      "5510a5224d163aa8d9f71cf00262781195af1aeba625ae5c715d18a6"
      "cbbc4fb550a35d36444a6d69973d14ae1a17f1f8d163bc933ee351f68847cce5dfa5f752"
      "1fb39b1a52359659cab169b9618848d23536c3ebab469d2df3a2d6e0",
      "1494979b4860cb33b54a6a93652ae5daec3c9bea054f9505c17cb8d3306a9a8e9469d131"
      "8efd21c7f186e738b0e710e9b5d40a393e4d578d863eba79daf0e473"
      "fa47364f3860d62c0d8edb6d9fe3705f2f5f7fab7fbdffc78b09927c6fc9539f93e4b371"
      "5d7c5d8ff6fcfe1cbee7c11773f993a56d6175a55a62bafc4e2e9fab",
      "1ecb42955ebeec477100cfa07e501e36a9f6a3be9efd8e63d2655f8e037b34895746c937"
      "507779e95040977ce743f2ed7af239fd239b27a5f7fd9aced505a4b1"
      "66f07cfe9e1c955efcf52b59fdfd967b2692e4b31175fd5d902b895c934e2ea34ebac32c"
      "f1f153345b5f8d8efe7eeff1bcdf38e63cda8fb9fcbbd9357aef9ec8",
      "e90257576559bfc7eab22cd4e52e8b448115f83a8b7dac220ba70786c4f2bdbf13546566"
      "5a9c28eb6a4f8c18398ff496dccca61dfdff72c8fe3f18d07fdbdfe8"
      "c98d3addef94c409f8a6d7554e47d63dee9d464b86af7538a87f6e78f5cfc6a874fa9301"
      "7cb6bf379feb2f9f4fadc5a9a8c9f603667dbd6f5decf05977387eec",
      "7fe2674a35295dd9b8fb9ca84e53d5a59f89f25988ba4ee7b3c5b90ae2933b8bf9d95243"
      "5637c499ac1a219d7eeaf1bcdf38663cda8fb9fc43e8b475573b91d5"
      "36e8b3cb067d7ef978409f31409fff9f67503f280f3b2c758c9b523f56861cc7db03c661"
      "fbcd328af917bad8ebe655fefd21f949d793b73cf99cfe91d69fecc0",
      "f5e68e946e7c44b89e7cfbefdf3324f96c445d87e3477327f3fcc9225d3f51128676d216"
      "19c3001d8e9c0ebf39601cb6df9493e5b55ab160d961d561c693cfe9"
      "1fa90ef703374db4ee9afd8dac0e9fef3d794c92cf465875f88e075fcce54fb65065413d"
      "6d73f583c312d3e199c36c7391021d0ecb7a867d3d0cd8d71b2f1fec",
      "eb61c0be5eb0f6210fc60892072fa552f49a65431e1ce0f7663f7064f3e00784eb11cf92"
      "effe4092cf46d475786373ad209793595d4b9433a87426ae72720bce"
      "b785663d431e8c0179f078f9200fc6803c3858fb51c983f7871cc72d977d390eec3165bf"
      "9ccba6c39af7129f273b6084759774defbe4d62f3f91e4b31175dde5",
      "e9e4199d2b76f8e583c3d3d995c41152954e0a74372ceb19f25e0cc87bc7cb07792f06e4"
      "bdc1da8f8afe0e5bfff57b1e4d53045e9fd565f5d8207b1ecda5c7a1"
      "3b8f76357004cfa37d45f81cc48bcf942a493e1b51d7e1e4562b91daec5617b6a4f8515e"
      "e59a5cb32eaf800e474d87a75cb67b1cb65f45bd5e0aa8662b7158f3",
      "e26d4f3ea77f64f3e60c1cf1f79bf8e039593d6edffdf321493e1b61d563bfe7d2daf3a2"
      "d159ac770b795a91986ebda49f158fa9e8e8f1b9c7f3515bd7509fc0"
      "80fac478f9a03e8101f58960ed872e2fbe09e7d3369942d5b2c3ba4f773de759ccc0913d"
      "9ff690f03e5d7baef90d493e1b51d7e178ab74bcf5a8b09d8e2712dd",
      "ee6a25b19e5bd8011d0ecd7a863c1803f2e0f1f2411e8c017970b0f6a3a2bfc3e6c1b04f"
      "e77c1decd3bd1a1fecd361c03e5db0f641879df1f01a07ecd3c13e5d"
      "103ed8a7c3807dba60ed47a53ebc3fe438fcfcdf06439799b0d683afe57c8b19b088ffdf"
      "c6eec43f1f92e4b31156ddf55d0f2e2eadd23ba835ffa88ee2ad39d4",
      "8a57f9c769d0ddb0ac67a80763403d78bc7c500fc6807a70b0f6a3a2bf500f0ec607f5e0"
      "f1f0413d1803eac1c1da071d76c603eac14e3fd4835f8d0feac11850"
      "0f0ed67ee8f4f8069c175e5eab95eccf750a6b7df8bade07ba94217b5e98f4e76b7cfd1d"
      "7cbe868991bf9fa5de66b6d7a5aa6a1493fa5979b9d0cde4e334e870",
      "58d633d48731a03e3c5e3ea80f63407dd85ffbff02cc90cb51",
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
                emlrtMxCreateDoubleScalar(740109.41908564814));
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
                emlrtMxCreateString("i363P4eYZukMYrymd8kUzD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
