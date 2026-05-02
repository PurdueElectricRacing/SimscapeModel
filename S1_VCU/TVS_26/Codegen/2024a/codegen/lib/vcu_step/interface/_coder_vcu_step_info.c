#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[13] = {
      "789ced5c4d6ce344147657052d122c390077a4bdb15469b6ddb60821254e9a86246d1327"
      "e99f97d4b1278d37fe49fc93a6bd73d80302890b7b409c9038216eac"
      "8484567001092e2c12cbcf5e111724b8204e88386337b559938424b36bf3be43edd717cf"
      "37ef4de6cbe88d6d6a2e939fa328ea1285f18e8a8f4fd976c43e5ea0",
      "dcf0fae7ece3331edbc163d4bceb3ac7ffa67de455c5405d031b0a27a3b32b055516154e"
      "314a272d44694857a50e12fa9eba28a1922823e6bcb16959f2fa39d7"
      "9961b9ac73ba81f82663ca94d6d0073d94ce1b67f9b8ed13effc88f9607cf211f1f80f52"
      "d7e997d8b28e349d2dc5b36c52e54d192986cea64563c3acb18c28eb",
      "3cd74279554012cb2c562b74992d55986aec1a4bf792a7a992645ddce1cdaa6ea0d682ec"
      "8ae370c2381ef78d037b8e9051a5d7c9f1e98666f2c6f4c6a9e0cbe7"
      "f64f6d9c70c2ec511a9eb7a7478cc37b1c7cfe62ff18fde1a739927cbf5d79f915927c0e"
      "1e165fd7a7bd51bf87cff9f0453cfecaf131adeed713c25566552f66",
      "0ae669766f3539e8c7f6109e61fda07c6c52ed877d3e8f1ac7bcc71ec4813dba22b6a6c9"
      "37547745e5484203be3b13f21df8f2b9fd531ba756efff5583ab4948"
      "67ade48df83b392dbdf8fc7bb2fafbf3cacddb24f91c845d7f57d5cad5ac905a49a04eb2"
      "538a8bd11314ab6d80fe3e6aebded684713c39240ec76fc9bfa52c72",
      "af9be7f90f27e427bd0edef1e573fba7fabbe924ae3776a474a3fd2d591dbefbc5855f49"
      "f23908bb0eef89cdc67261852e1756b5d3cab2d6de681e2969d0e1b0"
      "e9f01343e270fc969c2472d5ed2ddb0eaa0e977cf9dcfea9ea703f7178e048e9c6eb77c9"
      "eaf09f37db3c493e0761d7e1c40d6edf5caa7773f162836e28e5453a",
      "ce1412a0c34199cf508fc0807ac46cf9a01e8101f588f1daffc8e7fa51f398f5693fe2f1"
      "1f6472a9eb9765ce90b89aa6aac665d65055a9a67659244bac24d658"
      "ec635baa7452371556540ca4b51617e439c6d07a625452f3c868a84226e9eaff5b13f6ff"
      "ca90fe3b7ebe2737da42bf530a27e1935e573903d9e7b8777a4a31a7",
      "f2bbe0855fff1c4c4ba75f1bc2e7f87be3b9f9e0f1d41b9c8604b69f30fbef0bf6c1499f"
      "7d86f3c7fe237f965493d295c2f3f788ea34b51bff92289f8db0eb74"
      "3eb3bd5c41e2cafe5a3e56e455ad202f66b410e9f4073ed78f9ac7b44ffb118f7f029db6"
      "cfaac7aad6047df6d8a0cf0f8e07f41903f4f9df7986f583f2b18352",
      "c7f83fd693e3349dcad936d493c7a83ff51347b69efcc9d764eb19df7c982992e4731076"
      "1d16f86622d7e9b4930a4dd7e95ab95e43d14a0a743828f319eac918"
      "504f9e2d1fd49331a09e3c5efb6159071f4e18c7458f3d88037b2cd967b2996450d7bdc4"
      "c7c9491861dd7d91f0731de53fa8df49f23908bbee8a5966a9c177d7",
      "e513c4e4a3d1b5632eb362c2fd6c8199cfb0eec58075ef6cf960dd8b01ebdef1da0f8bfe"
      "4e5aff1df5b90ebd258946cc50b5b649f6b90e8f1e07eeb98ef38923"
      "f85c07e9faefadb7f350ffa5a6afc33121436feabcb0d7890b5b52832b6476cc1cdc4f1c"
      "3a1dbee4b1bd71387e0df57a29a1aaa3c4415d17eff9f2b9fd531b37",
      "77e288bf6f82fd8eac1ebffb4bf616493e0741d5e3677df8221e7ff39a6c76d66addad7c"
      "aaa594bab5a271badda6c2a3c7777cae0fdbbc86fa0406d42766cb07"
      "f5090ca84f8cd77ee0d6c58fc2fd69e5d2d6ae6d07759feee1dccf62258eecfd697f11d6"
      "e14fdf7bff2b927c0ec2aec3af7656e9750dc554e18813bb51434db6",
      "d315a84f04663ec33a1803d6c1b3e583753006ac83c76b3f2cfa3be93a18f6e9dc9f837d"
      "baffc607fb7418b04f375efba0c3ee7cf8c501fb74b04f370e1fecd3"
      "61c03edd78ed437d1863ccf761169df766407d78bcf7e715d364ebc33fde23abc31f7ff6"
      "c67d927c0e82aac323bf0fb321a02d21bb54d7997469c710d23772bb",
      "75787e3930f319eac318501f9e2d1fd48731a03e3c5afb7f033ce164aa",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 28592U, &nameCaptureInfo);
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
                emlrtMxCreateString("jtQowGvIToblp6KW4pva9B"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
