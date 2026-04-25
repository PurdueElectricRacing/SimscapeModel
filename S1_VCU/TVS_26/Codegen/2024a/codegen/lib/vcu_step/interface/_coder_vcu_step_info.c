#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[12] = {
      "789ced5c4d6fe34418765605ed4a7c84039cf682d80312a86a52b2e9ee012971d2d68dd3"
      "3471926eb3eea68e3349dcf82bfe4852ee207162254efc032e208e48"
      "5c401c800317960307ae0809892b42e2b024194f939835498877766de63974fceaade799"
      "79a7f378f4242e1561f2118aa25ea020eedf83edf34e1c75da2bd43c",
      "dcf988d3bee48a119ea136e6ee43f90f9c56d4540b0c2d18a882022eef6c6a8aa40aaa55"
      "bed00165005393fba039c9b4241994250570b3c1e1385276675297c1"
      "3835bea63b40ec72b642191d733a427936b8acc7e71ef3dd58b21e9c473da2aefcddec29"
      "7d9baf98c030f9722ac76734d156806a99fc9e64eddb0d9e93145314",
      "7490d79a40e6b958bd4a57f87295abc76ff2f4a8788626cbe39bfba25d372da06f2a73f3"
      "385b731ecf7ace0366dac0aad3bbf8f84ccbb045cbbf752a7af2cde7"
      "7d5b275830679516d7edc525e7e16ea7bf7f75d2d67efc398293eff5d827bfe1e4437852"
      "7c438ffe96fd3b7cc5832feacac785f3812de595c4c980dd2954db8d",
      "9bf1ddf2fe741c470b78168d83f28871f51ff6fdbcec3c365cf1741e3063aa92ee27df42"
      "dd95d4b60ca67c9fadc957f0e49bcffbb64ee3828d5609973ebcf70d"
      "5ebd7df897f02b4e3e84b0ebed8e56ddce35b3c934e867fae594b47501e20da2b74fdd39"
      "575f731ecf2d9807ca8fe57e34b2ba321ae62cffd99afcb8cfbdc79e",
      "7cf3795f9f93a8701875b887f9dcfbe0db2bbfe3e44308bb0e9f48dd4ea298a42bc51de3"
      "9d6ac2e8ed77dbea1ed1e1b0e9f0b505f340f9b19ca4d9fa113a2706"
      "5587cb9e7cf3795f75785238b870b874e3dd077875f8cff77b224e3e84b0eb70fa5ca8d9"
      "6fb5866caad4a13b6a2546a7b8629ae87050f633f11f2088ffe02f1f",
      "f11f2088ffb05affebeee39c47ff5157fe2ec3664f6f2882250b0d43d3ac1bbca5697243"
      "1bf2409179596af030c7eb9a7cd1b2555e522d60e8b14d25c259c648"
      "7cca5a1e581dadc964e6c67f7fcdf1bfb960fc282f8ee4c5d89c0c4a156478311aaa6001"
      "e71a8ececcaab62fcf0137bcc68780f8befc8f7ca8ff7b0bf8507eb4",
      "9e878f5e4fb32318a0c94f0ae6fc7cc36950f99c2b583ffe1ff51b3f4971e94af1d59fb0"
      "ea347527f51d563e0761d7e93c7394a8022959bb958f9744cd282a31"
      "c608914e7fec71ffb275dcf3e83feacaafa1d3ce557da0195da2cfae98e8f3a3e743f419"
      "82e8f3bff32c1a07e51107c5b7f83ffac7299aceb24e4cfce315fca6",
      "49e1f0fac75f7c8fd7cff8e153a684930f21ec3adc14bb69b6dfef65549a6ed18d4aab01"
      "b6aa59a2c341d9cfc43f8620feb1bf7cc43f8620fef16afd87e5dc7b"
      "b6e63caebae2e93c60662cf35c8ec904f59c8b7d9d50c1965c27bf74e214f3f7d5ae3fec"
      "3138f910c2aebb09dd3838189c3400d84a6e1fd776a52a7bb04dbeaf",
      "1698fd4cceb910e49ceb2f1f39e7429073ee6afd87456fd7f577977d4fc3d465c98a5b9a"
      "d1b3f1bea7e1d2dfc0bda7315b388c3a8cdbdffde8c33cf177a9c7f0"
      "7e7293a10f4db179d24f350b72472832c7364bbe1ffcd4f90debeaf04a9fb355ca853b4e"
      "1c54ffe1c9f8f2e3c2e1fd9c4dc5ec3f7cfddad11f38f910c2aec3d9",
      "7395d66f558bb9614a28a65836dfb70fb7c9e76c81d9cfc47f8020fe83bf7cc47f8020fe"
      "c36afd87456f89ffb01a1ff11f1e0f1ff11f2088ffb05affc47f8058"
      "f1ff4494d0fb25c47f58edbdf2d21e5effe100b3fff0d52fd7dec6c98710541d7ed9832f"
      "eaca0f387d90ac59e239e81b62a75069eb7de984223a1c94fd4cfc07",
      "08e23ff8cb47fc0708e23f2cd7ffdf6cf72bc6",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 24232U, &nameCaptureInfo);
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
                emlrtMxCreateString("LWTHVzkGyAK3U7T7uM3zO"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
