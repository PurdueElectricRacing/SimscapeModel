#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced5c4d6fe344187650415d898f5cd81317a4954002554dbadd2e7b404a9c34eb3669"
      "9a38499bac4bead893c6a9bfeaafb43f00244e8bc4897fc005c41189"
      "0b9c10072ec081035784c42f40e2b024194f9398f526c6ded9b599e750fbd55bcf33ef3b"
      "9d27a32749a91453495114f52a05b1de86d757dc38ed5e5fa016e1cd",
      "a77c628417a9b585e750fea17b1534d50297160c545e01d74f8a9a22a9bc6a35ae744019"
      "c0d4640788d34c5f92414352003b1f1c4c2265772e751d4c52937b7a"
      "008473d656286360ce6628cf07d7fdf8daa7deb515fbc1faf423edc93f289ed0f7b8a609"
      "0c936be4f6b98226d80a502d932b49d67dbbc7b192620abc0e2a9a08",
      "648ecd745b74936bb4d86ef60e478f9b6768b23c79d811ecae69017d4359a8e334641d2f"
      "f9d6013367c0ead2bbf8f84ccbb0052bba75aaf9f22de6235b27d830"
      "779596f7edb515ebf05e67bfbf3ebd767ef92d8593efedcc177fe2e44378567c973ee3ad"
      "fa7778d3872fedc967f9e1c8962aca767b54be5b6d9df5ee64771bf7",
      "67f3385cc2b36c1e944f8c6bfca4efe755eb58f3c4b33a60c654253d4abea5ba2ba96732"
      "98f17d1592afeacbb7988f6c9d260d1baf122e7df8e87bbc7afbe86f"
      "fe0f9c7c0849d7dbbb5a6b6b5f2ceee48153701a3969f30a647b446f9fbb73ae1eb28e1b"
      "4bea40f989dce7cbdd43a44f713df7367cf916f391be4e4e1b07170e",
      "976e7cf8335e1dfeebe30b01271f42d275383fe43bf6edfe6539571fd003b599a1736c2d"
      "4f74382efb999c7b21c8b9375a3e72ee8520e7de60e387ddc7fb3ee3"
      "a73df9074cb978724be12d99ef199a66dde22c4d937bda2507149993a51e07739caec957"
      "7d5be524d502869ed95052ac658cc5a7a1558035d044a6b030ff4f42",
      "ceffdd25f34779612c2fc6c674522a2fc39bf154790bb8f770766651b523791df0c26f7e"
      "0888efdbffc887c6ff60091fca8fd7f3e0f1eb690e780388dcb461ee"
      "cf77dc0b6a9f7b07fbc7fdab7f9357525cba527bf357ac3a4d1de77ec0cae722e93a5d61"
      "0eb75b40dae9bc57c9d605cda82919c648904e7feef3fcaa7d2cf98c",
      "9ff6e443e8b47bd71d69c639d1674f4cf4f9f1f5107d8620fafc649e65f3a07ce2b8f816"
      "ff47ff3847d3c5b21b13ff3880df346d1c5efff89b1ff1fa193f7dc9"
      "d471f221245d8745e13c5f769c8b824ad37dbad7ecf7c066ab4874382efb99f8c710c43f"
      "8e968ff8c710c43f0e367e52cebda721eb58f7c4b33a606622f3ec3e",
      "5388eb3917fb3aa186adb84e51e9c409e6cf07bff1e882c1c9879074ddddd68dbdbd51bb"
      "07c0e6ced65167576a95f7b64a4477e3b29fc93917829c73a3e523e7"
      "5c0872ce0d367e52f436acbffbf2923a50ded465c9ca5a9a71618379fed390fc41f537ec"
      "ba1df9f22de6a3d3dfb9c661d461dcfeee679f5688bf4b3d85efc589",
      "0c7d600a62dbc9895579c0d79823bb4c3e1ffcdcf90d617538d0fb6ccd46f5d88de3ea3f"
      "3c1b5f7ed238bcefb3e1f61f1ebe75b385930f21ae3afcba0f5fda93"
      "679ac3ecce7189bf3d74b6f4c3edd6a07c55ab524487e3b29f89ff0041fc8768f988ff00"
      "41fc8760e327456f89ff108c8ff80f4f878ff80f10c47f08363ef11f",
      "2002fe9f883afa7e09f11f827dafbc5ec2eb3fec61f61fbefbfdc6fb38f910e2aac3abfa"
      "0f23561fed742c61081c4318549b67ba23b529a2c371d9cfc47f8020"
      "fe43b47cc47f8020fec36ae3ff03f036cc6f",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 22816U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740096.92856481485));
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
                emlrtMxCreateString("o64oaoaxnvK6CwDHnFHfEH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
