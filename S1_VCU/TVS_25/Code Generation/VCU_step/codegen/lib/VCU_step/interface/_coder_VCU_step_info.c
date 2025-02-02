#include "_coder_VCU_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9b4d6ce34418865d54d08a654b2a040738812a81c4aa4ad2a6a55caa34757e489c"
      "4dea38a976bd24b633499cf82ff638dbe4cc1dce5c109cf6c8158903"
      "272484109cd0222e5cb973e08448e24c93983531eb689678e73b7466f435f3be99a99f8e"
      "66c6d4568ed9a2286a8772e251c1296fcdda9159f91cb51ceefcd6ac",
      "dc71b5513c4f6d2f7d0ee53f9e9592ae4170059d8626a8e0fa934d5d9535418395a10128"
      "1358ba3200cd69a6252ba022ab805d6c14272d35bd90ba6e4c52937a"
      "aa03a41e6bab94d9b1e60e95c5c6f5f7f8d2e3fb6efb1c8f9cc778445cf97bf4fdd4fb3c"
      "6701d3e273da0098fcb92ed92ad0a0c5676498b5459e95554b120cc0",
      "e84da0f06cac5e4d717ca5cad6e3097e5cad5b1018fbaacbbf11d0ff4b2bfca37c1bc089"
      "9fba3a36b7a8df08a8ff82a7be93b1a0694b707df3c578ea2de703ce"
      "d7e2704de76cd578bdecd3bfbb9cfffe8d6979d3fe759ac2a5679c7efe364e3d144f4bef"
      "caa33fbf7f7faf79e8455cf94ab1583e549a232e9a2ad017e98c95e7",
      "faddf3b98fd20a9d553e288f36aefe379dbb8d80fe6fb8da73ff4e660290615d6a6d2a67"
      "31cd0f1a26dff3b32e2efc06f172f6c71ff61a38f550849db325a5cf"
      "4499113c30ef24c0c8480bec892d660967ffefcfb15fffdbaef6dcbf93b134d958a7de2a"
      "ce36755b54c05cef61403dda536f391f707e26c384751dfb3366bede",
      "fe69f77b9c7a28c2ced7f7f4ea41be491f9f81c1f9a09294a34310277c9df797f7e83fe2"
      "cadfcb15e8fb7baa00154134751deef150d71551bfe281aaf08a2cf2"
      "4e8e377465d8b2355ed620308dd8bebac54253d6da159d01b0a33773e74bfe3f09e8fff6"
      "0aff282f8da162ee4f4d6982e254c65605086675c79d456bb6bae8af",
      "f184fedce1e50f05d2fbe609f550ff1faed043f9f17c161f3f9f56473041939f0ed8ece7"
      "bbb3020ddface68c1fff8ff19b801a1757ca6f3ec2ca69ea32f91d56"
      "bd59849dd34cae94a802f9f8ee0913bf9074b3acc6726688381d749d95f1e83fe2ca07e0"
      "f4ac567fa09b3dc267579bf0f9f1df87f0d909c2e77fd759e583f268",
      "6fca3a7ad3f78357ed1b4c3648e8cad33b77c3f6ff33f83e125d19cf0e2e1eb03ade7d8a"
      "d3af3efd02a71e8ab0f395ed2761a114ab954f24bb241f1d7147ca85"
      "98217c7d96f85a227cf5c3d7124ebebe81f93ec32b2f46dec2a98722ec7c6d25840716a3"
      "b56ac55411b43a5c3e2e16a57478f81ab6e7979caf3941ced7d6a347",
      "ced79c20e76bffad7fb26ef5f23f5fb75659b26ef5731f97c5b86ebd8579ddfafb2e778a"
      "530f45d8f97a90c8d1a3ea7176d86d1bb55ebb992b75853cb987fb6c"
      "f195ec0bf8e22bce7d815dcc7c7d287cf4274e3d1461e7ab79c2b5f3b5517cc01e664743"
      "08b97ebe70408787af9bfafc1a017ddf5ce11be51de1ebd7ca36f6bd",
      "b282a7de727e2df3347fad0c1b1f7630f3f69dbfe4439c7a28c2ce5b5a6612bd2e7d39fc"
      "40a4abb1ee209e34d34c88ceb93695b78d80befdac632b29b28ef531"
      "2f9514c675eceb98b95afdfab30c4e3d1461e72a382c33c5743c2bf652513b963cbb8c9d"
      "15f221da87dda0e7173f57ab84ab7eb85a0df1bd816ffff8e5559c7a",
      "28c2ce55219ae8014b1b5c94e836a8c5b8fe2061dd09d1fe6bd89e5f726fc009726f603d"
      "7ae4de8013e4de80bffeff061831a7e1",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19696U, &nameCaptureInfo);
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
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("VCU_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\Inver\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\VCU_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739649.872650463));
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
                emlrtMxCreateString("pU6nEk5PVjwE5RfUKztScB"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
