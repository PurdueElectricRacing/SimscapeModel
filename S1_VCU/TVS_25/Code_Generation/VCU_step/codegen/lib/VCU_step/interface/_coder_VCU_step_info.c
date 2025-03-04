#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced9a3d6fdb4618c7e9c22d3aa4a93ab4538136ad810e090ccbb25e924da6a817ebdd"
      "a415d9612a53e4c96243f268f244c9deba1788bf455fa62cd98b6e41"
      "964c6981f63b74e8d4ad924846121b568c4530f5f99ec1c7c363ddffaf3bf1a7070f45ad"
      "95aa6b1445dda4ec7852b1c70f9c79cc19dfa116c39b5f73c69b9eb9",
      "1bef52eb0baf73f38f9d51841a0223644f344105af5e294155d6040d71673aa00c6042c5"
      "02d234d39315c0c92a60e727b5c94ccdcfa55e4d26a9c935dd07e223"
      "76a05246df9c3954e627b3fdf079bfeb01f7a3e4b31f314ffe01f390bec71f98c030f992"
      "660183cf4171a0020d997c4146c541976765d514051d54a104149e8d",
      "775af401cfb5d8ce7692b7c441c74440df543dfef515fddf58e2dfcd9f0034f1d351c7e6"
      "e6f58f57d47fcf57dfce98c8188828bcf3aafaea2de6573caff9ed9a"
      "9ed9b2fdfa30a07fef38fbfff7a7e38fdffd3e4d45a5b7f3eb177f46a9e7c6dbd21bf9ac"
      "17f4f3f7b18f5ecc93df617ad9dd54b57e386ca4cbc993bbf7f3b5fb",
      "e9391f8d253acb7c503ef3a8d6bfeadc3d5ed1ff32ee4d0042e7df1e677f5851afe0abb7"
      "980f81b3747e7c3ab8f2952a7f4ef84a05ffdc7de2a317f3e4950c9d"
      "cbb0027d94481da1f3aec558856429870f5f71bb7f83fa5ef7cc67beed8ca9c9d3923932"
      "aecada8902c23b17c6576f31bfe2b94cb629d2baf5258a96ab775e7c",
      "f43c4a3d3770e76a06b612658949ef022b67715979eb0c6c778bf87075d5bab5ecb37ecc"
      "937f50aa300f3754012942d780106df00842a50b473c50155e91bbbc"
      "9de375a89cf5061a2f6b08187a7c535d639131860e07ab00f5a134f9529bf37fb1a2ff3b"
      "4bfcbb79710c1563736a4a1314fb626c5540c0b9b6dd998c3650e7fd",
      "1d5fd29f37fcfcb9e1eafd7c493d77fdaf97e8b9f9f179d65e7f9e665f3080c44f37ccf9"
      "7bdb19dced73aeecfde3ffb57f135047c595e6addfa2ad7fdbd96791"
      "ea39813ba7aba546b205e4f4d1ddeaf6be088da61a2f1918713ab2faf7f29c76ae3a4368"
      "3c227cf6cc099f5fff7e089fed207cfe6f9d653e289ff955a9a3af43",
      "ff77b742fabf01fa47bb158cfbbfdf7eff19e9ff52e1f3951ed6b7a461a25f1831872350"
      "cbc2fa7e512c10be5e27be3638c2d7007c6d7018f3953c5fb3236cbe"
      "1eb6e58a516e2a665dec726de5b4a7f74f59061fbee276ff92e76b7690e76be1e891e76b"
      "7690e76b6fb63ea95bfdfccfead6164bead620bfbf6531ae5b7f39ff",
      "92d4ad54f87cad9d64e9fd92316433ea5ebba8d3f9c1d6a944fa02d78bafa42f1088af38"
      "f705fefe7483f0950a9fafdf8cda4d34e286f17cf148516949370fba"
      "651a1fbee276ff86c9558e265c0d702e1c8d3157bfbab845b84a85cfd554ba0233c37abd"
      "983bdbd913f3ca5eaf993049bff57f7bff927eab1da4df1a8e1ee9b7",
      "da41faad6fb6fe15e26af4f56a8bd4ab41beef5a11d6ab3f455caffe75f1c7d328f5dcc0"
      "9dab8964cdaaa7acca56fc3c97aaef65a07ca05731eab3e276ff927a"
      "d50e52af86a347ea553b48bd1a6cfd7f00f0d1a6f8",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19656U, &nameCaptureInfo);
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
  xInputs = emlrtCreateLogicalMatrix(1, 4);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\Inver\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739679.87895833328));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("23.2.0.2428915 (R2023b) Update 4"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("MFra6rZtFM2IcOnVRk7EgG"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
