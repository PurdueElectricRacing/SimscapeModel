#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5d4d6fe344187651814582dd5e402b240e2b9513a89bb6daa6850bad93a6d926fd"
      "8a9366a94b6ac793c689bfea8f245d8913822bf00b805b252e1c3956"
      "080971e0beb0bdacf803fb0b1071c76e6bb326f62699d6d6fb1e6a4fdf7a9e79dfe93c7d"
      "f3cc24a526f2c5098aa26e53d84ebec4d7b79cf694737d85f29adf3f",
      "e15ceffadaaebd4a4d7a9e73fd5f3bd7baaa98a867e286c2c9e8e24941954585534ce658"
      "43948e0c55ea20e1dcd31025c488322a5d6d6cd82d79f58aeba261bb"
      "ec7bba89eaed9225537ad3b81ca174b571918f9f03e29d0c998f52403ea67cfebdec3efd"
      "115b36906eb0ccf23a9b51eb968c14d36073a2b966f16c49948d3aa7",
      "a1a22a20892dcdd62a7499652aa5dadc024bf793a7ab92643fdca95b35c344da8cec89e3"
      "60c8385e0b8c037b0e9159a357c9e119a66ed5cdd1cdd376209ed73f"
      "b279c20973666970deee848cc37fbdfcf95be7d7bf9f9e4d90c4e33fbeff05493cd7ae0b"
      "af17d05fd8dfc3b703f0a67cfeb2502f2cd3b9556187c93f50729587",
      "c5562e73651c5b0370068d830a6893ea3fe9eb396c1c93bef6651cd86328a2364abc81bc"
      "2b2a8712bac43b1d126f2f10cfeb1fd93c69fdefd74c8e9790c1dac9"
      "0bf97772547cf1fc4fb2fcfb1df79b4c12cfb5b8f2ef3b0178533effa25a995f17b2e915"
      "d4c974986531758ce6f8b5e4f0ef4f01cf87cde37a40ff533eff5ebe",
      "90dd9f963953e2785d55cd69d6545589577b2c922556127916fb584d958e1b96c28afdd7"
      "09ba363b234f944cbd4f468c5a44665315f219cff8bf1972fc1f0e18"
      "bfebaff7e9469f391f94c249f8a63f54ce44ce3d1e9d9155ac50eb70d0f8fc16343ed746"
      "c5d39f0dc073fdfdf9dc78f17c1a4d4e47027b9e30e7eb07cec54d9f",
      "7387f3c7fe277f365593e295ed7b4f88f234555dfe9d289e6349e7e9627eeb410589e94f"
      "978a733b7555df9667f37a8278fa24e0f9b079cc05f43fe5f30fc1d3"
      "ce5dadabea6de0675f1bf8f9c5f1003f63037efe7f9c41e3a002da71d1316e8a7eac0d19"
      "c79b03e270fdb68c62bf4297fbc3bc8a7f30243e693d793710cfeb1f",
      "a9fee426ae3f7749d5933ff935057a32357a1e4eb51e7417c4ee5296ef6af396d16dcb8c"
      "65010f278e87df181087ebb7e964a550dbda74da71e5612610cfeb1f"
      "290f9f276e86a8ee9aff8b2c0f9fee7ffe90249e6b71e5e1b0fb7ae926aa2ceac76d8e6f"
      "1cee301d9139cc0b4b14f0705cd633eceb61837dbdf1e2c1be1e36d8",
      "d78bd63fd4c1d8a2d4c1cb349d2d386da88323fcdd3c4f1cd93af8ee1f6479f8fd67bf3c"
      "2789e75ad27958a8b7570a9dce5146a1e906cd971b3c4a55b2c0c371"
      "59cf500763833a78bc78500763833a385aff49a9830f868ce396af7d1907f6d8b45f5acf"
      "67e25af7129f2737618479f7e91959de7dfdfbe91f49e2b99674decd",
      "b49a622f5d2d98bcb59e6a65b2dafca3f9f40af06e5cd633d4bdd8a0ee1d2f1ed4bdd8a0"
      "ee8dd67f52f87758fd37ec793443934473ce54f5238bec79341f1fc7"
      "ee3cdad5c4113c8ff62de17310675f69559278ae259d87d3bbcd79badcab2eee2aa95651"
      "e7044ee0d555e0e1a4f1f06d5fdb1f87ebd7517f9412aab94c1cd7ba",
      "f851209ed73fb279f3268ef8e74dbcfb842c1fb7ef3dbb4f12cfb5b8f271d87369ed05d9"
      "ea2cf1bdcd625653981ebf633ede3aa292c3c7a701cf276d5d833e81"
      "0df489f1e2813e810df48968fdc7ae2ebe09e7d3cacc66d569c7759fee7aceb3d889237b"
      "3e8db43ef1c31d11f4096af43c9ca36531a774b952abc37537e96d61",
      "cd4c6d000fc7663d431d8c0deae0f1e2411d8c0deae068fd27857f87ad83619fcefb73b0"
      "4ff77278b04f870df6e9a2f50f3ceccd47501cb04f07fb7451f0609f"
      "0e1becd345eb3f29faf0c190718479df06932d3171d583afe57c8b9d30c27a04e9cf4f3b"
      "f907fe1f876da3ae83b75b6ab3b8d4d8dedd5c2c5756d56a6335b3a0",
      "c0fb3662b39e410fc6067af078f1400fc6067a70b4fe93c2bfa00747c3033d783c78a007"
      "63033d385affc0c3de7c801eecf5831efc7278a00763033d385affb1"
      "e3e31b705e78a550db71ffaf535cf5e1ebfa1ce89d1cd9f3c2a4f5e1f77a33a00f5363d0"
      "87cd36f36843a9ead656da7c5c5ad9ece58a29f83ccbd8ac67d087b1",
      "813e3c5e3cd087b1813e1caeff7f01c25ccf0d",
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
                emlrtMxCreateDoubleScalar(740107.97613425925));
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
                emlrtMxCreateString("WmULfjl9IZOBUK7HdepWVE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
