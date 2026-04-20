#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5bcd8fdb441477d052b5121fe90571ab90da4305acbac97eb4bd254e76d7caf73a"
      "494beb36eb8fc9c6ecd893d8e37497337005c489ff8013e28284c485"
      "1b20c1014e1cb873e22fe00049c6b3494c4d126c4d1b33efb0e3a75f3cbf79efedfc327a"
      "b1859454490982f08a40ec75918c2ffb7eda1f5f10e62d88a7fcf1a5",
      "804fed456163ee3e8a7fe48f3ab23138c3c4b1550b5cdc6920cbb4551b37cffb4070808b"
      "e0101813a46b42d0342d20cf3ad5b167edcf4017ce181a5f8b3da09f"
      "ca9e25383d77ba4238eb5ce4e3eb90783796cc871c928f74007f587c24de555a2e705ca5"
      "992b2905a47b16b0b1ab1c98f8d0d314d9b45c5ded830a320054e4ad",
      "4e5b6c29cdb6dcc9ec2ae228790e82707cf350f73a2e06fd4d6b2e8ee388715c0a8d8320"
      "270077c47d767c2e763c1dc757a74628df3c1e5b9d48c2fc2a2dcedb"
      "ab4bc6111ca79fbf3c197bdfff9662c9f7fe4d7895251fb567c5771632dfb2ff87af85f0"
      "a503b85ddc1ad4ceb7916ef5774075b791576b7abd305d477d01cfa2",
      "7508213eabf993a2bbfd88715c591007c5c772922f77ea35df5f571d6e86f2cde3b1eaf0"
      "2471a470ac74e3d24f6c7578e793ec0d967cd492aec35249c203a764"
      "f48a62bda265b3f2fd7afb499eebf0baece765e3d808f8d33808e2da663f4ebe85ba6bda"
      "27104cf9be8cc8570bf842e073148fad4ee3848d4ac44a1f3efc8ead",
      "defef5a7fa3b4b3e6a49d7dbdba89d2d19c5bd3c181686cd9c79eb1c64b4c3e4e86dd47d"
      "5c0a993f1dc01f4ae5e2a3eb968aa1aa3908e1eb0a46086ae84c0116"
      "54a0a9290453fa089e773d5b316d0c9cfed6a69592b133129f26aa00dc438654985bffc7"
      "11d7ffd682f5535c1fc98bb3395994ad4272315aaa8a817f4d56e716",
      "6d2f96ef81a085ad8f1ae5fbf63ff2d1f91f2fe0a3f8a89ed5a7d7d3eda90e309449c2fc"
      "bf6ffa034d9f7f45f2a7fc237fe36f5256bad278e357a63a2ddccffd"
      "c094cfb7a4eb7445aaefb481b9f7e04e2573a423a7616d494e8274faf390fb97cde341c8"
      "fce9001e41a7fdabce13e49c727d0ef85c9f9f1e0fd767625c9fff9d",
      "67d13a84107f5dfa16ffc7fe714e148b65dfe7fde315fa4d93c4b1ed1f7fc3b87ffccb17"
      "d2114b3e6a49d761433fcd9787c341c116c5aea8b5ba1ab8d52e721d"
      "5e97fdccfbc7c478ff385e3ede3f26c6fbc7abcd9f9473ef71c4382e07fc691c0419cbbc"
      "5c920aeb7ace655e279ab025eb14974e5cfb99adeebe7df58faf58f2",
      "514bbaee6ad0ba63e724f86e76d044ad7c376f161ace3ed7dd75d9cffc9c4b8c9f73e3e5"
      "e3e75c62fc9cbbdafc49d1dba8fdddb0f76dd201dced431367307206"
      "1e98e53f8ec8bfaafe46addbbd50be793c3efd9d491c431d66dddffdecd30aefef0af1eb"
      "70c690c4aaab1bef0c73460df6d48674cf2bf3e7839fbb7e43541d5e",
      "f13d8d23fa7cc7baf61f9ed573dd47076c7f672bfdc8b8fff08122b1e4a396741d46c3ed"
      "5dedacf0de4eab7a7b70d8d51fd8db7b27fc7db9b5d9cfbcff408cf7"
      "1fe2e5e3fd0762bcffb0dcfc7f03e89a6620",
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
                emlrtMxCreateDoubleScalar(740092.79668981477));
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
                emlrtMxCreateString("df9e6fo4qYlOPL3YI8QPmH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
