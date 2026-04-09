#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[9] = {
      "789ced5abf6fd34014765041300099f803aa6ea08a26f4a78450e2ba699a3409b19b96d6"
      "25f58f6b63d5f605fb9c269d9010acb02216060646249622313020c1"
      "df80d8991899108224f6358da9494aac83b87e43ee9e3efb7defdee53e3b77a122e9e508"
      "45519728dbd662767bd1f1a34e7b86ea36371e71da0b2e1fdb596aa4",
      "eb3e8c3f765a09ea08d491ede882060eef94a1a6e8828eb84615500630a15a03721bd956"
      "54c0291a608f3ab996a72d1c810e9d16d4ead31520edb296461915b3"
      "93a17ad439acc796c778477ad4c36dee7ab8af1b940fc73fefc9672335c92a9b0854fde2"
      "3be7c9672326322c0975c67730201febc9d78d6f309bf41cbf6202c3",
      "e4b944869f8792a5011d997c4a418b96c8b38a664a42152c4319a83c3b512ed12b3c5762"
      "cbb1299e6e7e190da8aaad9b71c1c6b576dc5e75bbdce738dc6de77a"
      "7b9ee63e7e8e90e4bb33fa224a920fdbbfe2ab7bc4ebf77b78c5832feac2e3ac342d70f1"
      "f49e0898fa3ab3c4d432ec4cb29347a1074faf3c280f9f54fca0af67",
      "bf747007a032bd408ecf6fddbdedc9d78dfb364f76c19c5922a883847517a5be6d91e4c3"
      "1674ddadd4d7f712509a8d2fce1aab378ab17d735f9e5f0875f77fd3"
      "ddea80e3f0fabd1175e12d394966cb85bce30fab0e739e7cddb8af3adc2e9c3d71a47463"
      "9db00eafbefd314a920f5bd075389d49a37b4646ae307461598cc7d9",
      "b542692f7cff1d9af5dcef38465c7e671c3662ea4ad54fbe9ebaabe83b2ae8f0bd1a902f"
      "eff229d77518f76d9e5a056b4e11297d78f481acdefefc2e7c21c987"
      "2de87a3b034bf18ccc4c27416dbec62594eb0d10131783a3b783aee38c47fca80bdf4867"
      "99cd314d40aa201a10a2311e41a88ab0ce034de55545e46d8caf42b5",
      "b16de9bca223605427c6b5088b8ca6f8707019a00a94d3f35df93f1930ff6b3df2c7b8d4"
      "941763bc9d942ea876a799aa8080d3b7b33319ddf2e539e0b67ef7bb"
      "dffd251f8e7fb7071fc69bf3993b7e3ecd8a6000996f17ccf9bcea34b87c4ecfae1fff5b"
      "fd5a4f5252baf2f5c127a23a7dffd6eba724f9b0055da7f3b57c4a9e",
      "acc392be948829b54a5c2c5a5c2a383afdd2e3fe7eeb98f2881f75e103e8b4d32bef4163"
      "37d467971feaf3f1e309f5d9b6509fffccd32b0fcac31f967d8bd3b8"
      "7f9ca06926ebf8e1fef109f69bda8523bb7f4cfaff13cfdf1f3c23c9872de83a3c83f6b3"
      "ca8a6ed50b345db24aecd4646a622a3cc73bd53a9ccc968bf8fd3fd4",
      "e193edfb1753c13ec77b73f3e138493e6c41d7e185c6a4b82ad676442327ab8d999c3e55"
      "30f274a8c3c3b29ec3733cdbc2733c7ff9c2733cdbc273bcfee2ff02"
      "a9c2431a",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 12912U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *epFieldName[7] = {
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Visible"};
  const char_T *propFieldName[7] = {
      "Version",      "ResolvedFunctions", "Checksum", "EntryPoints",
      "CoverageInfo", "IsPolymorphic",     "AuxData"};
  uint8_T v[216] = {
      0U,   1U,   73U,  77U,  0U,   0U,   0U,   0U,   14U,  0U,   0U,   0U,
      200U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,
      2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   4U,   0U,
      17U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,   17U,  0U,   0U,   0U,
      67U,  108U, 97U,  115U, 115U, 69U,  110U, 116U, 114U, 121U, 80U,  111U,
      105U, 110U, 116U, 115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      14U,  0U,   0U,   0U,   112U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      0U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   4U,   0U,   14U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,
      56U,  0U,   0U,   0U,   81U,  117U, 97U,  108U, 105U, 102U, 105U, 101U,
      100U, 78U,  97U,  109U, 101U, 0U,   77U,  101U, 116U, 104U, 111U, 100U,
      115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   80U,  114U, 111U, 112U,
      101U, 114U, 116U, 105U, 101U, 115U, 0U,   0U,   0U,   0U,   72U,  97U,
      110U, 100U, 108U, 101U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "ResolvedFilePath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_26\\Controllers\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740081.50071759254));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2943329 (R2025a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("dpOi0ffPcPg086sPtvzXEC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}
