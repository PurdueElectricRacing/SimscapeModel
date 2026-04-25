#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5bcf6fe34414765041bb122cb9c085d34a7b03559b2c50960352e2645b93a46d62"
      "27bbed7a491d7bd2b8b53dae3d76d33d70dbd572028913ffc19e1047"
      "242e7040880317e0c0810b07c4bf80c401928ca7494c8d136ccdaeb3f30e1dbfbe78bef7"
      "a3f3f9e9d5e1724223c771dc150ecba32dbcbe14e8f9607d8e9b97b0",
      "3d17fa7d6efee3dcf3dcda85f68f83558516024384154b31c1f99d1a34754bb190746603"
      "ce012e347ca04d2c7ddd00926e027156d91e6be6ad19d3b932368daf"
      "f901508f45cfe49c813bf5d09855cef3f16544bc6b0be6438cc8473e64bf5bbdc7bf2bb7"
      "5de0b8b254aac915a87a26b0902b6fea68cbebc9a26ebaaa628306d4",
      "80218b856e876fcb5247ec16df96f951f21c6818e39b7dd5ebba08d8ebe65c1c0709e378"
      "21320e6c3904a8cbdfa287e722c753517a756a46e2cddb53ab134e58"
      "50a5f8bcbdbc601ce175faf94b93f5fd9f7fcdd1c4fbedbefc1a4d3c224f0a6f18b1dfa2"
      "7f87af46e0e543764fba614985dae1714bea89b0aa4a47fb82559dfa",
      "b11b8313e70717a1d3da7fd5cff3a271ac85f4691cd8e25aba9d265e2cefead6a101a678"
      "5f24c4db89c49bb7a756a771c24655a2c50f0fbfa3cbb77fffa5fc41"
      "138fc8aaf3ed3bb073a3a65537cac0aff85249bf7e068abd2dc6b74f5b9f6b278ce3724c"
      "1cc43ea6fb72bdbb4bf829ab7daf1489376f4ff53939491c2e1c2dde",
      "78f0135d1efef3a31395261e9155e7e1f291b2efbdd91fd64bad013fb0da05be2436cb8c"
      "87b3729e59df8b85f5bde9e2b1be170beb7b97db3fe939ae45ec9f0f"
      "d9ef0af5eabd6ba6820ca5e74088aec90842a3078732300dd9d07b32b6c93634cefa9e25"
      "eb16028e5d583773227246e423c1064003a8099539ff3f49e8ff1b31",
      "fe13bb3aa217677de294a518f862e4aa8240708dbd73ab9697ca73202c51fe1121785fff"
      "4f3cb2ff073178c43eaae7f6c5f574078a03347992b0e0e7ebc142d2"
      "175ce1fcc9ffcadff8494a8b579a577fa1cad3dc9dd2f754f10259759e6e08bb6f7580be"
      "b17fb3516ca9d0699a05c159219e7e1c71ffa279dc8cd83f1fb227e0",
      "e9e0aa7b0a9d63c6cf219df1f3c5f1307ec6c2f8f9bf71e2fce022f4accc2d9ec5f97189"
      "e7abf54067f3e325e64d93c4d19d1f7ff503dd79c68f9f0b2d9a7844"
      "569d8735f5b85cf7fd938ac5f37dbed7eef7c0f50e7b6f2233e799cd8fb1b0f971ba786c"
      "7e8c85cd8f97db7f55fade8384715c0ae9d338b0654cf3624da864b5",
      "cfa55e2792b005eb94164f0c29bf27e17df8ed639a7844b2cabbaf44e0e543f69bc5e19d"
      "4ed36e959bf7f78e862dc7d8ab6c3438c6bb5939cfaccfc5c2fadc74"
      "f1589f8b85f5b9cbedbf2a7c9b74befb624c1cc4eeda868e8a083a271e98c53f4888bf2c"
      "ff26addbed48bc797b7afc3b93388a3c4c7bbefbd9a70d36dfe5d2e7",
      "e1a226f0dbaeaaedf9256dc718284de1b65767ef073f75f386a43cbce4f7345ae4fd8eac"
      "ce1f9ed47bddad4dbaff67a3fdfde46f7ebffc1e4d3c2259e5e145e7"
      "0fa7a27dbab18fd423e03bea60a77d68fbfa1ec778382be799cd1fb0b0f943ba786cfe80"
      "85cd1f16dbff1f81f2c148",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 18592U, &nameCaptureInfo);
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
                emlrtMxCreateString("yFgoVXEWcakdu27aT1Zu3"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
