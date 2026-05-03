#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5d4b6ce34418765705ed22d8ed8515371eea0da8d296362d8843e3a46948d347ec"
      "a45deaddd48ea78d1b3f523f92b437243820212d170e2071df13e2b8"
      "1297d572e2c00521b13cce68af70e0c01e20e9d86d6cd6c46e92696dfddfa1f6f48fe79b"
      "f95d7ffdf3cd34a5c67285318aa2ae5318f73ec2c717ecf6847dbc42",
      "b9e18d8fd9c7973c6d07cf50e3aeeb9cf85dfb58d55413b54ddc5079059d5e296a8aa4f2"
      "aac91e3510a52343939b483c89ec493262250531bd8db56e4b59ee09"
      "9d36baa1ee395d43d53a6329945e33ce4628f7364ef371df67bee301f3c1f8e463c213df"
      "c9dca6dfe64a06d20d8e5dca7369ad6a2948350d2e2b992b96c03192",
      "6254f9062a6822923966ba52a64b1c5b662a33f31cdd499eaec972f7e266d5aa18266a4c"
      "29ae79ec0e388f677de78123fbc8acd0cbe4f80c53b7aae6f0eed3a6"
      "2f9f3b3eb4fb841366dfa5fe79bb11701edee3d9ebaf9e1c9ffbf5b731927c9fbdfb2847"
      "92cfc145f1b57dfa0bfa73f8a20fdf84275e12abab4b7476592cb2b9",
      "39355b7eaf70904df78c63a30f4fbf71503e6d52fdc7fd790e3a8f714ffb6c1e3862a852"
      "63987c7d755752f76574c6f76040be1d5f3e777c68f7a9d1f97ec5e4"
      "0519195c3779017f4f0e4b2fbefd99acfefe9efcf83e493e0751d5df9b3e7c139ef88256"
      "9ecd8b99640a35d34d76494a1ca11961253efafbb5cff541f398f7e9",
      "7fc213dfc9ad666e4f2abc29f382ae69e624676a9a2c686d0e2932274b0287635c43938f"
      "f62c95933aef13f4c6f49432c6987a478c58ad80cc9a26e6d2aef17f"
      "3ae0f8dfe8337e275eedc88d3e7532289597f14967a8bc89ec733c3a23a35a4aeff876cf"
      "393e2ffcc6e760583a7da70f9f13efdccfb5a7df4fa3c6eb48e44e12",
      "667f7ddd3e38e9b3cf70feb8ffe4af2bd5a47465f3d54744759ada5efa8e289f8db8eb74"
      "21b731574652f2fdc5c24cb1aae99bca744e8f914edff3b93e681eb3"
      "3efd4f78e203e8b47d5669697a1df4d9d3067d7efa7c409f31409fff9fa7df38289f7654"
      "7c8ccbe21f37069cc7f37de6e1c4bb364af71dbad219662fffee80fc",
      "a4fde42d5f3e777ca8fe9393b8cebd8bab9ffce7cd776a24f91cc45d87130773ad79a9b5"
      "98115a8d59cb68d515d6b2408763a7c3d7faccc38977e524b55ad958"
      "b7db51d561d697cf1d1faa0e9f246e2ad0fb8961e9c6e22f6475f8c3971f1e93e4731055"
      "1d0ebaae97aca1f2827e54e785bdfd22db94d8fd9cb848810e47e579",
      "86753d0c58d71b2d1faceb61c0ba5eb8fea10ec60853072fd17466d56e431d1ce2f7e649"
      "e2c8d6c1df7c4f56877ff82a5724c9e720ee3a2c56eba9d566f330ad"
      "d2f41e2d94f6049428674087a3f23c431d8c0175f068f9a00ec6803a385cff71a9837707"
      "9cc7554ffb6c1e38d2957d269f4b47b5ee257e9f9c8411d6dd3709fb",
      "bfa5bfa83f48f23988bbee4a79e6ad5ab5bdac1c21a690482cb6f85cd2ca82ee46e57986"
      "ba1703eaded1f241dd8b01756fb8fee3a2bf83fabf41f7a3190d5932"
      "674c4d3fb4c8ee47f3e871e4f6a3f5268ee07e3491701dbc243ffc91249f83b8eb7072ab"
      "364b97dadb0b5b6ae2a0a0f3222f0ada32e870dc74f8baa7ed9d8713",
      "d751679432aa384a1cd5baf8962f9f3b3eb4fbe64e1cf1cf9be07e22abc75f3ece7f4e92"
      "cf4154f538e8beb4fabc62351785f67a21d350d9b650348f370ea9f8"
      "e8f1039febe3f65c833f8101fec468f9c09fc0007f225cff91ab8b2fc3feb412bbbe6db7"
      "a3ba4e7731fb59ba8923bb3fed09617fe2ce3f93af91e47310771dce",
      "d28a94555b3c73d0e45bebf4a6b86226d6408723f33c431d8c0175f068f9a00ec6803a38"
      "5cff71d1df41eb6058a773bf0ed6e9cec707eb7418b04e17ae7fd061"
      "773efce601eb74b04e17860fd6e930609d2e5cff71f18777079c4790bfdb60330c1b553f"
      "f842f6b7741346d88fb841f8f3d3febefbc92b24f91c44557783d6c1",
      "2ba97555d6676fa5cd2c9bdbdf9ad59a7b738934e86e549e67f08331c00f1e2d1ff8c118"
      "e00787eb3f2efa0b7e70383ef08347c3077e3006f8c1e1fa071d76e7"
      "03fc60771cfce0f3f1811f8c017e70b8fe23a7c79760bf706ab55274feaf5354fde18bfa"
      "1ce86296ec7ee16b84fde12f3eb8f284249f83a8ea70d0ba78d3acb3",
      "b7d6d46dddda489ac74c6abd9d2d24e0f32c23f33c833f8c01fef068f9c01fc6007f3858"
      "ffff0298f7d08d",
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
                emlrtMxCreateDoubleScalar(740105.44116898149));
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
                emlrtMxCreateString("WlQxSD9t7rY6mpOLLZyprE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
