#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5b416fe344147650418bb4402ea0bdaeb43796aa0ddd4dbb271227db9a246d1327"
      "e9b6eb2575ec49e3d6f6b8f6d89bee81138bc409244efc83bd80f688"
      "c4850b424870810b07eefc05240e90643c4d62d624595bb3d8cc3b74fcf4c5f3cd7baff3"
      "65f4627319a196e138ee750edb351e8faff97ed61f5fe2662d8867fc",
      "f16ac027f632b732731fc13ff547059a080c10764cd9009777aad0d04cd944cd0b0b7036"
      "70a0ee01758cf4341d34350388d3ceeec833ee4e4197ce081a5df37d"
      "a09c89aec1d97d67b2427ddab9ccc7d721f1ae2c980f31241fd9007ebffc80bf23b51c60"
      "3b52b350914a50710d602247dad6d08edb9544cd7014d90235a8025d",
      "12d73b6dbe2535db6227775be287c9b3a1ae8f6ef614b7e32060ad1a33711c478ce395d0"
      "383072025087bf4b8fcf41b6aba0f8ea540fe59bc563ab134e985fa5"
      "f9797b63c13882e3e4f357c6e347bffc96a1c9f7f4bd2f4f69f2117b517c8390f916fd3f"
      "7c2b842f1bc0df6fad559bf97a553fb0f6b6f887c0abda9b87a5c93a",
      "f6e7f0cc5b0717e2d39a3f2dba6b458ce3d53971107c2427c56a677fcff793aac3cd50be"
      "593c561d1e270e178e966e3ca6acc37f7c72aed0e42396761d2e9eca"
      "47ee466f502d34fa7cdf6cadf305b15e643a9c94fdbc681c2b017f1207461c53b3e2e49b"
      "abbb9a79a28309dfd3887c7b019f0b7c8ee0b1d56994b0618968e9c3",
      "c7dfd3d5dbbffe947fa7c9472ced7abb09dbef56d472be08bc92d72c686b1720d7dd498f"
      "de46ddc79590f9b301fcbe502d3fb861c84897bb3684e8868420d4bb"
      "702001439774ad2b614cb2a07ed1734d493311b0adf5552323227b283e4d5803a80f55a1"
      "34b3fecf22aeffe69cf5135c19ca8bbd3a5e9429ebf862b8541901ff",
      "1aafce299b6e2cdf03410b5b1f31c2f7ed73f291f93f98c347f0613d779f5d4fa72fdb40"
      "95c609f3ffbeed0f247dfe15ce9ff48ffc8dbe4969e94afdfaaf5475"
      "9abb57f8812a9f6f69d7e99ab07fab0db4fcd1562dd750a05d37d6053b453afd24e4fe45"
      "f3b81d327f368047d069ffaaf310da674c9f033ed3e767c7c3f4191b",
      "d3e77fe799b70e2ec44f4adfe2ffd83f2ef07cb9eafbac7fbc44bf699c38bafde36f7ea2"
      "dbcff8f92ba141938f58da755855ce8a55cf3b2f993cdfe3bbad5e17"
      "acb5cb4c8793b29f59ff181beb1fc7cbc7fac7d858ff78b9f9d372ee3d8e18c795803f89"
      "03232399172b4229a9e75cea7522095bb04e71e9c480f27312ee87df",
      "3da1c9472ca9bafb66085f36806fe506f7da75ab51ac3f3a3c1d346cfdb094af714c7793"
      "b29fd939171b3be7c6cbc7ceb9d8d83977b9f9d3a2b751fbbb61efdb"
      "6403b863e91aca21689fbb609aff3822ffb2fa1bb56e07a17cb3787cfa3b95388a3a4cbb"
      "bffbc5e735d6dfe5e2d7e19c2af0bb8ea21e7a05754fefcb75e1c0ad",
      "b2e783ff73fd86a83abce47b1a0df27c4752fb0f2feab9eec636dddfd92a3fd2d5e1771e"
      "4b024d3e6269d761e86ddcee0e4a8f6eb57637cf777aca91b9913f61"
      "efcb25663fb3fe0336d67f88978ff51fb0b1fec362f3ff0d7dab6922",
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
                emlrtMxCreateDoubleScalar(740095.81028935185));
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
                emlrtMxCreateString("kq11luqXWlnB1RNoXjNxUH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
