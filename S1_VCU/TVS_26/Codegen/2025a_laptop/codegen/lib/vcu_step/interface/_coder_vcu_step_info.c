#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[8] = {
      "789ced58cb6ed34014755081b200b240ec91ba03557d400b6c509a26699ab429d88da83a"
      "101c7bd2988c3dc61ea7495748ac118805125f0042088190104b8458"
      "213e00217e816f8038f634cd50e3089b8146b98bcc5c1dcf3df7e139962224f22b094110"
      "4e089e7d39e3adc77d3fe9af87847e63f184bf1e617c6a8785b1be73",
      "147fe0af0a36086c11cf31641dee9e54b1ae19b241a4b609050bda1835a1da456a1a8292"
      "a64371afb3ea7a7a760fb4ebb890bb4fd7a1d2101d5db0ea762f43b4"
      "d7d9edc7ad807ac742fac11adb0ff6b9a87c34fe78209f873415a7621368c6c51734efa4"
      "8fd8c47214d2abef5d443e3190af1fdfccdc485f06eb36b46c20a50a",
      "60112b8e0e0d62839c46969c2a1035dd566413ae601522204e57cae9752095c5cacc1c48"
      "775e460b23e41ea60d9bd4bb71c3fa7672c03ad8b5f7bc37a7a58fdf"
      "123cf9f0a9e73f78f251fb577cad807883be87a703f8920c6e6637366ed7d25663a72ecb"
      "ad721beeaccae6422f8fb5109eb03c84009f57fc61bfcf71e9e01624",
      "9574961f5fdcba7b3590af1f8f6d4e5ec3fc29f1d389171ff8eaeedbc7af559e7cd4865d"
      "778b56617e3aa74e2155cc2f23d31675a3914b8f74f77fd35d33621d"
      "c742eaa0b82b270bc5ca5ac9f70faa0e4b817cfd78ac3adc6d9c37385ebaf192b30e7f1a"
      "bf749f271fb5a1d7e1b9a9daf99dec4651ae6d5fcf95b2a93b4437b2",
      "231d3e28f779d03ac618bf578787d88666c6c917aabb9ab185608fef5544be12e30bcc73"
      "148f6d4e6ec33a23e2a50f4f39eb6df3f3d1473cf9a80dbbde5ec4e5"
      "d9829a995f80cdc5a694d2a6da70a6ba343c7a1bf51e1702e227197c335fccdc98d06582"
      "e4aa85319900046354c52d0075049056051e064c8cda35c7009a41a0",
      "654e4fea0991581df191f00a2475ace617fbf27f1831ff7321f9535ce9c88b35d94dca90"
      "91b7e9a42a13e8efbdecec8ce1c4f21d606dd0ffbbdfff211f8d7f33"
      "848fe29d79aeee3f4fbb2e5b5005dd86f9bf67fd85b6cfdf79fd03bff4cffd92f2d295ef"
      "f7be72d5e9bb57de3ce1c9476dd875bad42ce5d40b2d5c369653335a",
      "b33e5bbde648b9e1d1e96701e707ed632e207e92c123e8b4bfab6c63ab31d267c61fe9f3"
      "fef58cf4d9b3913eff9e272c0f21c0ffdbf17f02813a3aff",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 8688U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740076.48462962965));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2943329 (R2025a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("l81xSAPwUKz55rZhHuDelH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}
