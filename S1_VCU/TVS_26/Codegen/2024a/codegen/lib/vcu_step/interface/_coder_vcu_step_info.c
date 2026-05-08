#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5d3d50e34614163724c365920b4d6eae0b99b92e19c6e003c3a5f28fc08e3136b6"
      "30067431b2bd6061fd18fd1843974c525c9534299299f457a6b8e2ca"
      "9b4b952abf33f99d9499abd3a689ed95b0a59c6209db0bd2bcaf407a3c6bbfddb7ecc7f3"
      "dbc55053a9cc144551b7288c471fe3eb6b863d6b5c6f5056d8fd53c6",
      "f58ecd36f112356d79cef47f625cabb2a4a1b6860d8913d1c5933559e4254ed298b326a2"
      "14a4ca420bd57a9e435e400c2fa2c2a0b1d9b5c4b501d785d17575ef"
      "e375546d14749152ea6abf87c2a071118f270ee39d76198f82433c666dfe7dfa41fc3ebb"
      "ad22456599689a4dc8555d4492a6b2ebbc96d42b6c8117d52ad74419",
      "b98604b6b0502ec6b759a658282f2eb3f14ef0145910ba0fb7aa7a59d550735eb48ce360"
      "c471bcec380eec39425a39be468e4fd514bdaa8d6f9eb61cf9acfeb1"
      "cd130e98314bc3e3f6bacb71d8affdd7cff4aef7fffc638a24df87edefe748f299b82abe"
      "b6437b6e7f0e6f3bf0cddafc91fcae905c2be59936bf97cea44b27b2",
      "50a263fd7ee486f00ceb07e560936a3fe8ebd9ed38a66d767f1cd8a34a7c739c7c437597"
      "978e04d4e77b3a22dfbe239fd53fb6796a76be5fd6b88a8054b61b3c"
      "97bf27c7a5175fff4a567fff8a3c7c4292cf44d0f577452e86d3353a1243ad448b89f2a1"
      "33b4584906477fbf7278de6d1cd30eedcfdafcfba90dfac15d91d304",
      "aea2c8b27697d56459a8c86d1689022bf01516fbd8a62c9c1dea12cb77de2728cd857971"
      "aaa0291d3162e40cd2ea722d95b0f4ffd311fbffce90fe9bfe6a476e"
      "94f95ea7244ec0379dae721a32ee71ef545ad2c5c1fe1d5cb27f7638f5cfc4b874fafd21"
      "7ca6bf339f9b2f9e4fb5ce29a8c6f602667c7ddbb898e133ee70fcd8",
      "ffc4af2bd5a47465ebad5f88ea34558a7e4394cf40d0753a93ca2d15111fd95bcd2ce6ab"
      "b2b2252ea49400e9f42387e7ddc671dda1fd599b7f049d36eecaa7b2"
      "d2007db6d9a0cf2f1e0fe83306e8f3fff30ceb07e560fba58e715deac7cd11c7f1ea9071"
      "98fe6e19a5fb0e5dec747390ff60447ed2f5e41d473eab7facf52733",
      "709db923a51baffc4eb69ef1f7ed77eb24f94c045d8743c74ba7cbfce92a5d396d8675f5"
      "b42132ba0e3a1c381dbe39641ca6bf2b27b18d722e6bd87ed561c691"
      "cfea1fab0ef70237efeafdc4b87463f537b23afcd19bcfce49f299f0ab0ebfe1c0376bf3"
      "47eaa8b8a29c35b8cae1519e69f1cc51aab64a810efb653dc3be1e06",
      "eceb4d960ff6f530605fcf5bfb90076378c983a3f138bd61d890077bf8bdd90b1cd93c98"
      "f4f9b6cf1e7f3b4792cf44d075786b7b232b1722294d0d17d651fe5c"
      "4c72721dceb7f9663d431e8c0179f064f9200fc6803cd85bfb41c9830f461cc78ccdee8f"
      "037bbab25f48a7127ecd7b89cf931930c2ba4b3aefcddef9618e249f",
      "89a0eb2e4f47cee974aec5c70e8fce16d7c2c74869b6e2a0bb7e59cf90f76240de3b593e"
      "c87b3120eff5d67e50f477d4faafdbf3686a53e0b5454d564e74b2e7"
      "d16c7aecbbf368838123781ead46f81c445478f613493e1341d7e1c84e3d1cdf6e975676"
      "a4d07146e16a5cad22af810e074d876fd96cfb384cbf823abd1450d9",
      "5462bfe6c5bb8e7c56ffd8e6cd1a38e29f37c1fe4c568fbf7c9efe9c249f09bfeab1db73"
      "698d65516fad56dad90cdd94987625af9de74ea8e0e8f15387e783b6"
      "aea13e8101f589c9f2417d0203ea13dedaf75d5e7c1dcea76d33d99261fb759fee6aceb3"
      "740317ecf3694b0fbf9b23c96722e83a1caae74f76ee657713a170b8",
      "dd4e16c39be9953dd061dfac67c88331200f9e2c1fe4c11890077b6b3f28fa3b6a1e0cfb"
      "74d6d7c13edde5f8609f0e03f6e9bcb50f3a6c8d87d338609f0ef6e9"
      "bcf0c13e1d06ecd3796b3f28f5e18311c7e1e6ef3618bac0f8b51e7c25e75bba010bf8df"
      "6d3c9ef9718e249f09bfeaaeeb7a702e9aa4f7507df95e0585ea4ba8",
      "1e2af1ef254077fdb29ea11e8c01f5e0c9f2413d1803eac1deda0f8afe423dd81b1fd483"
      "27c307f5600ca8077b6b1f74d81a0fa8075bfd500fbe1c1fd48331a0"
      "1eecad7ddfe9f135382f1cdb28e7cdffebe4d7faf0557d0e747e9dec79e19b84ffbfc617"
      "1fdcf887249f09bfeab0ebcfb3d41acceea65452f45c443b2fc4b2ed",
      "f54c88061df6cb7a86fa3006d48727cb07f5610ca80fbb6bff5f4b64ce1f",
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
                emlrtMxCreateDoubleScalar(740108.94263888884));
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
                emlrtMxCreateString("i363P4eYZukMYrymd8kUzD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
