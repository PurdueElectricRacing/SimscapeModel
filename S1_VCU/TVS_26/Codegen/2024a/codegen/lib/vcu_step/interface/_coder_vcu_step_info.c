#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5d4d6ce3441476570515099672007143487b03aaf46fd3724bdc3489d2b44deca4"
      "5dea25b5e349e3c63f89eda449b9c28103822b07ee7b427b4062252e"
      "4bb98010175889e5ef8ab820c1853349c76e6bb32676934c6beb7d87daaf2f9e6fe64de7"
      "ebcb9b694a4d65f3531445dda430eebd87afcf59f6ac75bd4139e1f6",
      "4f59d7975db68da7a869c773b6ff43eb5ad55413754d6ca8bc82ce9e1435455279d5647b"
      "4d44e9c8d0e40e124f3d354946aca420e6a2b139b094f50bae3363e0"
      "1adcd375546d306d85d2ebc6790fe58bc6593c1e788c77da673c188f78ccbafc7ba9bbf4"
      "9b5cc940bac1b1891cb7a655db0a524d834b4b66a62d708ca41855be",
      "89f29a88648e99af94e912c79699cac26d8eee074fd76479f070a7daae18266ace298e71"
      "ec8f388ea73dc7813d07c8acd0ebe4f80c536f57cdf1cd53c193cfe9"
      "1fdb3ce18059b3343c6ecffb1c87fb7afefa99d3abfcf3af5324f9be7ce1b319927c36ae"
      "8aafebd19edf9fc3973cf8665d7e75dbdc4cc84df6302337abca72d7",
      "ec95db6af2bc1fdb437886f583f2b049b51ff5f5ec771cd32efb7c1cd863a852739c7c43"
      "7557520f6474cef77044be3d4f3ea77f6cf3d4ec7fbf62f2828c0c6e"
      "103c9fbf27c7a5175ffd44567f7f8fbfff80249f8da8ebef8a565ecc89a9781275d63a6c"
      "428af5d08290898efedef778de6f1c731eedcfbafc7bd98dd4dd5b0a",
      "6fcabca06b9a798b33354d16b42e871499932581c33eaea9c9bd5a5be5a4fefb04bd393f"
      "a74c31a6de172356cb23b3ae89d93547ff3f1ab1ffaf0fe9bfedaff6"
      "e5469f3bed94cacbf8a6df55de44d63dee9d9152dbcac5feed5fb27f6e78f5cfc6b874fa"
      "ed217cb6bf3f9f9b4f9e4fa3ceeb48e44e03667d7dcdbad8e1b3ee70",
      "fcb8ffc46f20d5a474a5f0ea63a23a4ded26be21ca6721ea3a9dcf6e2f9791147f6b35bf"
      "50ac6a7a4199cfea11d2e97b1ecffb8d63daa3fd59977f049db6ee2a"
      "479ade007d76d9a0cf4f1e0fe83306e8f3fff30ceb07e56187a58e715deac7cd11c7f1ec"
      "9071d8fe411965f00e5de977f322fffe88fca4ebc93b9e7c4eff58eb",
      "4f76e0fa73474a375a8fc8d6337ef8fac69f24f96c445d87ef488dfa72214e970a2bfa71"
      "79596f651a076a1a74386a3afccc9071d8fe819c24372adb5b961d56"
      "1d663df99cfeb1eaf069e0e67cbd9f18976eac12ded77bf7959363927c36c2aac32f7af0"
      "cdbafcf13a2aafe8bd062fd40e8a6c47620fb2e22a053a1c96f50cfb",
      "7a18b0af37593ed8d7c3807dbd60ed431e8c11240f4ed0746ac3b2210f0ef07bf3347064"
      "f3e02fbe23abc3df7f9a2d92e4b311751d16ab8de446a7d35a5369ba"
      "460ba59a8062e514e87058d633e4c11890074f960ff2600cc88383b51f953c787fc471cc"
      "b8ecf37160cf40f6995c762dac792ff179b203465877df205cff2dfd",
      "43fd4d92cf46d47557ca314bf56a775de921261f8bad1ef1d9781bf6e142b39e21efc580"
      "bc77b27c90f76240de1bacfda8e8efa8f55fbfe7d18ca62c990ba6a6"
      "b7da64cfa3b9f43874e7d12e068ee0793491701e9c904f1e91e4b311751d8eefd417e952"
      "777765478d1de6755ee445415b071d8e9a0edf74d9ee71d87e1df57b",
      "29a38aadc461cd8bef78f239fd639b3767e0887fde04f723593dfee48fdcc724f96c8455"
      "8ffd9e4b6bdc56da9d55a1bb954f3555b62b14cde3ed16151d3d7ee8"
      "f17cd4d635d42730a03e31593ea84f60407d2258fba1cb8bafc3f9b412bbb56bd961dda7"
      "bb9af32c83c0913d9f46faf3d792ef2c7748f2d988ba0ea769454aab",
      "473c73d8e18fb6e8829831639ba0c3a159cf900763401e3c593ec88331200f0ed67e54f4"
      "77d43c18f6e99caf837dbacbf1c13e1d06ecd3056b1f74d8190faf71"
      "c03e1decd305e1837d3a0cd8a70bd67e54eac3fb238ec3cfdf6db029860d6b3df84aceb7"
      "0c0246b81e51279c077fcbdfff8b249f8db0eaaedf3cb81e57697169",
      "eb602d56a8b5128b2da1a8ac64e0ef9543b39ea11e8c01f5e0c9f2413d1803eac1c1da8f"
      "8afe423d38181fd48327c307f5600ca807076b1f74d8190fa8073bfd"
      "500fbe1c1fd48331a01e1cacfdd0e9f135382f9cdca814edffeb14d6faf0557d0e74314d"
      "f6bcf02f8fc9eaf0e7271ffc4692cf465875d86f5e9cac8b684bcc2d",
      "d50c26cdee9862fa7063b706f5e1d0ac67a80f63407d78b27c501fc680fab0bff6ff051b"
      "6fd49a",
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
                emlrtMxCreateDoubleScalar(740104.55649305554));
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
                emlrtMxCreateString("al30MoQYC55NXQx5lwPhlE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
