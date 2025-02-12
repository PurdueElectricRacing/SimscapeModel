#include "_coder_VCU_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9bcd6fe34418c65d54d022d8921e96039c90f6b012ab2a499b76c3a54a53b7f126"
      "ee26b5e3845d2fa9e34c1327fe48ed71da842b7738735989d31eb922"
      "21c1096905074e6857fc0370e7c00991c49e7c983531eb689678e73d74fcea6de6793253"
      "ff3a9ab1a935865da3286a8372e269c169afbb79cc6d5fa3e6c35b5f",
      "73db0d4f8ee2756a7dee73a8feb9dbca860ec11574125dd2c0e4930d43537449877cbf0b"
      "28135886da038d71e55c5101af68809b4d4e46997634539a24a3d2e8"
      "3adb027287b335ca6c595387ea6c32f91e5ffb7cdff580e3c1f88c47cc537f403fcc7e24"
      "962d605a22a3f780291e1ab2ad011d5ae2b10273765de414cd92a52e",
      "608d0650452e5113b2659117b85a3225f664bb6641d0ddd23cfebb21fdbfbdc03faa3701"
      "1cf9a9694373b3fa6721f5dff0d5772a16346d192e6fbe585fbdf97a"
      "c8f99a1daef19c2d1aaf7702faf7b6d3dfbf366ee3835fc7255c7af27de3194e3d142f4b"
      "efcaa7bfa07f7feffae8c53cf58e0aab832a0fa552f50aa43b159a31",
      "3eb672531fc5053a8b7c503e39aefe579dbb6721fd5ff3e453ff4e6504907e4d3e5f55ce"
      "629a1f344c81e767595c78f353bc9c3df96d3f85530f45d4397b370e"
      "fae01edb1e58e7774a83a3cb7885dd0659c2d9fffb7d1cd4ffba279ffa772a96ae7497a9"
      "b790b38ade54c154ef71483dda576fbe1e727e46c384751dfb0bc4cb",
      "d7db3f6ffe88530f45d4f97ac710b6f30d7aef00f40e7b7c4689f741b24ed6b193fef23e"
      "fdc73cf5074c817e785393a02ad54dc380374568186addb81281a68a"
      "aa52179d9ad835d4feb9ad8b8a0e81d94d6c696b1c3487d0e10d16c096d1600ee7fc7f11"
      "d2ffed05fe515d1e42c5dc1a9bd225d5b9185a952070af1d7716addb",
      "daacbfb317f4e70d3f7f2890def72fa887faff64811eaa0fe7f3e4f9f369b5241334c4f1"
      "80b93f3f741b347cee95337ee23fc66f046a5c5c297df0142ba7a96a"
      "e609563d37a2ce699629a604a0ecdd4fb3c953d9304b5a823123c4e9b0ebac639ffe639e"
      "7a084ebb57b54bc3ec103e7b72c2e7e77f1fc26727089fff5d67910f",
      "ca275f9575f4aaef072fda37186d90d0fccb3b77c3f6ff33fc3e12cd0f6707170f3803ef"
      "3ec5fe375f7e85530f45d4f9ca5d6460a198a894d2b25d547677cbbb"
      "ea69fd98f0f555e26b91f035085f8b38f9fa5d1f2f5f7f7af2e8164e3d14abcad71b3e7a"
      "314f3dbd2bc1e65e239ba12f7356d682db666b27494587af51bb7fc9",
      "f99a13e47c6d397ae47ccd0972bef6dffa27eb563fffd375abc091756b90e771398cebd6"
      "eb365ebefebe59dec7a98722ea7cdd4e31f440d8cbf5dbcd6ea5d36c"
      "30c5b6943f247c7da5f84af60502f115e7bec02666be3e963efb13a71e8aa8f3d54c979b"
      "f9ca20d9e37672833e84e58b7c619b8e0e5f57f5feed86f4fdd602df",
      "a8ee084f5e2b5bd9f7ca0abe7af3f5a5ccd3f4b5326c7cd8c0ccdb5b7f293b38f550449d"
      "b7b4c2a63a6dbadabf5ba78544bb97cc98476c84ceb95695b767217d"
      "0759c7f259b28e0d302f7c16e33af63dcc5c15be7d748c530f45d4b90a764aecc9513257"
      "ef64e3762273504d1c14f211da875da1fb173f5705c2d5205c153072",
      "f57dcc5cfde18f673770eaa1883a57a578aa032cbd775aa49ba092285ff452d6bd08edbf"
      "46edfe25cf0d38419e1b588e1e796ec009f2dc40b0feff069531ac7b",
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
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\Inver\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739657.44607638894));
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
                emlrtMxCreateString("E3QCS779kB6BuKAyDhR7SG"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
