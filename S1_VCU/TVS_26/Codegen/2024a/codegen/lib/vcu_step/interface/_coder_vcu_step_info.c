#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5b4d8cdb441476d0825aa9404ea8b7aa522b0ea05593fd6b399138e9aec9ff3a9b"
      "eeb66eb3fe996cacb53d8e3dceee2255ea95131c91b8212171e4c80d"
      "54712852b973e8818a1b5c3872e04092f16c12b72609b6a6c4cc3becf8e98be79bf7dece"
      "97d18bcda5844a8ae3b8b7386c97793cbee9fb697f7c8d9bb6209ef2",
      "c74b019fd8ebdccad47d04ffd41f556821708ab063c92638bf5383a66ec9166a9ed98073"
      "800b8d3ed0464847374053378138e954879e797b023a7786d0f09aef"
      "02f558f44ccee9bae3151a93ce793ebe0d897765ce7c8821f94807f07bc5fbfc07d29e0b"
      "1c576ae64a5201aa9e092ce44adb3adaf11449d44d57956d50811a30",
      "2431d36ef17b52b325b6b39b123f489e030d6378735ff5da2e02f6aa3915c761c438de08"
      "8d03234700b5f9dbf4f85ce4782a8aaf4e8d50be693cb63ae184f955"
      "9a9db7b7e78c23388e3f7f61347efee4598a26df877ffdf02e4d3e62af8aef3464be79ff"
      "0fdf09e14b0770ab98e9d5ced6a16ada1ba0bad9c8cb35b55e18afa3",
      "3e8367d63ab8109fd6fc49d15d3b621c1767c441f0a19ce4cbed7acdf79755879ba17cd3"
      "78ac3a3c4a1c2e1c2dddf8ed295d1dfef2e0bb8734f988255d878592"
      "807a4e49eb16f97a45595b13f7ebad933cd3e165d9cff3c6b112f0c77160c4b5743b4ebe"
      "99baab5b470618f37d1391af16f0b9c0e7081e5b9d86091b9488963e",
      "1ce6e8ea2da73c2f51e5f32de97a7b13b6d64a5a712b0ffa857e33a7df3803596527397a"
      "1b751f9742e64f07f07b42b978ff9a292343561c08d13509416828f0"
      "5402a62119ba22614cb2a171d6f12c49b71070ecccaa99129133109f26ac00d4859a5098"
      "5aff6711d7fffe8cf5135c1dc88bb33a5a94251bf862b0541901ff1a",
      "afce2d5a5e2cdf03410b5b1f31c2f7fdbfe423f33f98c147f0413dab2fafa7db951da049"
      "a384f97fdff307923eff0ae74f7a217fc36f525abad2b8fa335d9dde"
      "cffd4895cfb7a4eb7445a86fb480be75f75625bbab42a761660427413afd75c8fdf3e671"
      "3b64fe74008fa0d3fe55fb043ac74c9f033ed3e797c7c3f4191bd3e7",
      "7fe699b50e2ec45f96bec5ffb17f9ce3f962d9f759ff78817ed3287174fbc7977fa2dbcf"
      "b8fefcf11f34f988255d8735f5385feef77b058be73bbcb2d751c08d"
      "5691e9f0b2ec67d63fc6c6fac7f1f2b1fe3136d63f5e6cfea49c7b0f23c67121e08fe3c0"
      "c850e6c5925058d6732ef53a9184cd59a7b874e20ae573aefae4e927",
      "34f988255d774f8ef2e8a3de46a56737b2d55d23b37f60e558bf6179f6333be76263e7dc"
      "78f9d839171b3be72e367f52f4366a7f37ec7d9b7400776d43475904"
      "9d9e0726f90f23f22faabf51eb7627946f1a8f4f7f2712475187ffa4fc7cf0b32b5ffd4e"
      "938f58d27538ab097cd555b5837e4eab195db921dcf1caecf9e0ff5c",
      "bf21aa0e2ff89ec62e79be6359fb0fafeab9eedd6dbabfb33da2acc38fbff8e5579a7cc4"
      "92aec3b0bfbea99c163eded8abdeeced74d4bbd6fad6117b5f6e69f6"
      "33eb3f6063fd8778f958ff011beb3fcc37ffdf0bb36347",
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
                emlrtMxCreateDoubleScalar(740088.76846064813));
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
                emlrtMxCreateString("Ow65Bm0RWHWYjhrG4JkjmH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
