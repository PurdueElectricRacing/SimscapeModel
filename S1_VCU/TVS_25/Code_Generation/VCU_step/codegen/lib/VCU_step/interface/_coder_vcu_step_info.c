#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced9c416fe34414c71dd4451cd8dd5ee002080e7b6355b54dd3b42c08256e92b671e2"
      "6cec3a9b5d97d471a68d89edb16cc7497a2ae20a822b1f0009710109"
      "7166bf031207964f80b467aec471dc24a65e676bef3431f30e1d3fbd66fe2f33f12faf6f"
      "ac128983528220883b8463179433de1efbabe3f13562d6bcf1c478bc",
      "e3f15dbb45acccbcce8d7f331e45a89aa06f3a8e2a28e0f2952da848aaa09aec4003840e"
      "0c285ba0358a9c4a3260250530d34ed9f694fc54e8d2b143f635d906"
      "6287e92a84de362619cad3cee5fbf8c1e7fdaeccb91e059ff558f5c49fe48ec98ff82303"
      "e806cf668afc1e14bb0a504d832f48e67eb7c93392628882064ab005",
      "649ed96870e411cf724c6333c55b62b76198405b532ef3d642e6fd6640de6efc0c987626"
      "0d659896edbbfa2721f55ff7d5772286a9774573a2f77348bda2afde"
      "6c3cd43e4d2fd670af6c0b5aafbb73e6ef1d27bfffc6683cfefa5902a55e41bc788652cf"
      "b59bd2ebfbcc37efe7ef2d1fbd554f7c2b779ac96e97e87aaf922ea6",
      "ce766bf9722d3d9547254027280fc2c74735ffb2f2f62464de41bcb3d141e66f8eaf61f7"
      "25e7ab371b0fcd57323f222b2a0ed47e45cbd51f7f7ba78752cfb565"
      "e5eadb3e7aab9eb876f4b0c809fb8324a4b4347c448b079f6ba92ce6eaa2debff3e6bde2"
      "f127793b11439546a53232ae4aea990ca2db17d2576f361e6a5fec45",
      "425caffe61a2e5eaedefff4ea3d4732dee5cdd815cb2d8caa5b3c0dab3d88cb43e009bcd"
      "fdf87015d9df9d0754eef89e2298b2d0d42134eff126847213f679a0"
      "c8bc2c357927c66b501e9c76555e524da06b1b6b4a8231f52174585802661bb60ef666f2"
      "ff3664fef703f277e3e2102bfada282955909d8b61aa8209c6d74e76",
      "464eed2ad3f99d5c333faff9e5e79aabf7f49a7aeefc9f05e8b9f1e17e96afde4fa32de8"
      "a0c58f166cfcf3c3f1e02edff8ca593ffe3feb67a31a15579e7ff927"
      "524e5f7cfacb7728f55c8b3ba7698b2eb4527dc8a987994dc96a279bd52e5b880fa791f5"
      "15aecfe9f155a307f50ee6b3c7c77cbefafd603e3b86f9fc629da03c",
      "081f3f767c5ec2be6f96c27ddfc0be519642daf7457d9ef6e0637c9e665bd45c257bf47a"
      "ab976c17fab97a1f943390aeee8b98abff0bae5658ccd540ae56d858"
      "9fa7fdfec57bf83c8d7805f56a4136763bbb7dd8ac3d2e32e7834c67ab4662ae2eecfd8b"
      "cfd31cc3e769d1e8e1f334c7f079dacbcd8feb556fde937a956370bd",
      "1afc7c2d83b45efde727b45cfdeb39f5094a3dd79695abf33e57db2c8af9cac6a694dab1"
      "ce2bd663aabe53ab4f7f8e3057af9e3f165cc57d8039b81aef3ec0d3"
      "cc07b80f40445faf2ad57affb04483c3a45ced9159ea614decf5701f6061efdf28b9ca92"
      "98ab81fbc292b1e6ea57efbe8fb94a44cfd52d6ea0a719e58c069cd9",
      "293eea5256a5cae6305717f5fec5fd55c7707f351a3ddc5f750cf7575f6efea5e1ea4dd4"
      "ab1cae5783bfefb8583f6785ff6f8163517335992a5bf4b645ad6f9c"
      "ef6dd3873b503ad24ab80fb0b0f72fae571dc3f56a347ab85e750cd7abf3cdff2f51d68c"
      "8d",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19608U, &nameCaptureInfo);
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
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 4);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "ResolvedFilePath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739680.77336805558));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("24.2.0.2806996 (R2024b) Update 3"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("pwMl8EM9tBt10f0OP5LJ6B"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
