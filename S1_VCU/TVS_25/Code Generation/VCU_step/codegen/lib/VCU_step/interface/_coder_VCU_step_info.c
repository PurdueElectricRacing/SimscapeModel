#include "_coder_VCU_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9bcd6fe34418c65d54d04acb96f4c04a1c912a81c4aaca47d3365caa34753e3671"
      "486a27e976bd24763c499df82bf63834397387333738ed05c4150921"
      "6e08210427b41217aefc079c10491c37895963b38e6637de790f9d19bdcd3c4f66ea5f47"
      "336362ab406d1104b14358f1a4649577e6edc8bc7c85580d677e6b5e",
      "ee38da76bc4a6caf7ccece7f322fdbaa02c135b41a0a27839b4f0aaa2c2a9c0299910608"
      "1d18aa3404c22cd31125c08832a0971be5694bce2ea56e1ad3d4b49e"
      "b902ed3e6dca847e652c1c4acb8d9beff1b5cbf7ddf6391e0597f18838f20fc94799f7d9"
      "9a0174832d2843a0b3676adb9481020d3627c2bcc9b3b4281b6d4e03",
      "942a0089a563cd7aa6c63275ba194fb2936ad38040db971dfeb580fe5ff7f06fe7bb004e"
      "fd34e589b965fd5640fdd75cf5ad8c0175b30dd7375f94abde6a3ee0"
      "7c2d0fd76ccebcc6eb0d9ffe9de5e2f76fcdcadbe6efb3142a3dede4f37750ead9f1bcf4"
      "ae5dfaf3fbf777d7452fe2c833e572f54012c6b568a6449e677346b1",
      "36e89d2d7c543c74bc7c102e6d54fd6f3a775b01fddf72b417feadcc1420a366bbb3a99c"
      "45343ff630f99e9f7571e10f8896b3bffcbcd742a96747d8395b9106"
      "54941ac384fe41128cb52c47a74c3e8f39fba23fc77efd6f3bda0bff56c650446d9d7a5e"
      "9c15549397c042ef71403dd2556f351f707ea6c384741dfb1b62bede",
      "fb75f727947a76849dafc76a3d5114c8a353303c1b3269313a0271ccd7457f4597fe238e"
      "fcc342897cb4277350e2785d55e11e0b5555e2d56b16c8122b893c6b"
      "e5584d95461d53614505025d8bedcb5b34d445a5cba8148057aa50385bf1ff6940fff73c"
      "fcdbf9f6042afafecc94c2495665629583605eb7dc19a462cacbfe5a",
      "cfe8cf196efeecb0f5be7f463dbbff0f3df4ecfc643ecb4f9f4fe38ad381c0ce066cfef3"
      "bd79610fdfbc668d1ffbaff19b821a1557aa6f3f41ca69e222fd2352"
      "bd79849dd354a192ac03f1e83245c5cfdbaa5e9563053d449c0ebacecab9f41f71e40370"
      "7a5e6b7ea4ea7dcc67471bf3f9e9df07f3d90acce7ffd6f1f241b8b4",
      "37651dbde9fbc15efb06d30d1292797ee76ec8fe7f06df472299c9eca0e201ada2dda738"
      "f9e6b32f50ead91176bed283342c55628d6aaa6d56c4c3c3daa174ce"
      "e7305f5f26be56305ffdf0b58292af7711df67e8fdf0d5b728f5ec083d5f3bc645bf3196"
      "13c7bc4aa624a11fbd3f6864c2c3d7b03dbff87ccd0a7cbeb61e3d7c",
      "be66053e5ffb7ffde375ab9bffc5bab54ee375ab9ffbb834c275eb1dc4ebd63f776b2728"
      "f5ec083b5f13c90239ae1fe547bdaed6e8778542a5c715f13ddc978b"
      "af785fc0175f51ee0bec22e6eb63eee3bf50ead91176beeaa95ab7d818c787f4417e3c82"
      "b0362896126478f8baa9cfaf16d0f76d0fdf76de12be79ad6c63df2b",
      "2bb9eaade6d7324f8bd7ca90f16107316fdffd5b3c40a96747d8794b8a54b2df232f46f7"
      "79b21eeb0de3693d4b85e89c6b5379db0ae8dbcf3a96c9e075ac8f79"
      "6132215ec7bed5a07a28f5ec083b57c141952a67e379be9f899ab1f4e945ecb4540cd13e"
      "ec063dbfe8b95ac75cf5c3d53a42aebe8998abfdefbec45c25d6cfd5",
      "dc65b2d21874a0564aa61f18b2f6e0f8325bca62aebea8cf2fbe376005be37b01e3d7c6f"
      "c00a7c6fc05fffff00d238a8b3",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19696U, &nameCaptureInfo);
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
  xInputs = emlrtCreateLogicalMatrix(1, 4);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("VCU_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\Inver\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\VCU_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739649.872650463));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("23.2.0.2428915 (R2023b) Update 4"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("QyivMDWZQsLpFModqeT8JC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
