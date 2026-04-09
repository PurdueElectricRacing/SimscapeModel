#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[9] = {
      "789ced9abf6fd34014c71d54100c4058f803aa2e0854d1a6bfd405258e9ba6499a347643"
      "695d82ed5c1babb6cfb5cf69c28404628515b130303022b174606040"
      "82bfa162438289bf002148625fd3989aa4c43a88eb37e4eee9d9f77df72efed839878aa4"
      "73118aa22e51b6ad4ddaed45c78f3aed19aadbdcf188d35e70f9d8ce",
      "52235de7e1f813a795a086401dd98e26a8e0f0cc0a54654dd010d7d0016500132a355069"
      "47b6640570b20ad8a3ce72cb53178e840e9d56a8d5a7ab40da612d95"
      "32aa662743e5a873588f7b1ef31de9510fb7b9ebe13e6e503d3cfe794f3d3b5293acb289"
      "80ee97de394f3d3b6222c39250677efb03eab19e7addf10d66939ee7",
      "574d60983c17cff04928592ad090c9a764b468893c2baba624e820072b40e1d98972895e"
      "e5b9125b9e9ce1e9e697d1808ad23a19176c5c6d8fdbab6e97fb9c87"
      "bbed1c6fafd3fcc74f11927a77465f4649ea61fb577a758ff1fafd1e5ef5d08bbae23156"
      "9a15b8587a4f044c7d9d59626a19762ed1c9a3d043a7571e94874f6a",
      "fca05fcf7e71701ba032bd404ecf6feeae78ea75c77d5b27bb60ce2a91e3449530771f5d"
      "53ae90d4c31674ee6accc46ebe310525559f06cb332b09212f159221"
      "77ff37eeea03cec3ebf746d4156fe124912d17f28e3fac1ce63cf5bae3be72b85d387be1"
      "4871639d30876fbffd314a520f5bd0399ccea4d1ae91a95419ba9013",
      "633176ad50da0b9f7f87e67aee771e232ebf330f3b626ab2eea75e4feecadab6023a7aaf"
      "07d4cbbb7cca751c8efbb64ead82359788141f1e7f20cbdb9fdf85af"
      "24f5b0059db773b014cb5498d904a8256b5c5cbed90093e26270783be8759cf1183fea8a"
      "6fa4b3cce6982a2045100d08d1188f20544458e781aaf08a2cf2768c",
      "d7a1d2d8b2345ed61030f4897135c222a3091f0ee600aac24a3ad995ffd301f3bfd1237f"
      "1c979a7831c6db49698262779aa90a08387d3b3b93d12c5fee036eeb"
      "77bffbdd5feae1f1eff6d0c3f1e67a2e1fbf9e66553040856f17ccf9bcee34b87c4ecfae"
      "1fff5bfd5a7752525cf9f6f08028a71fdc7af38ca41eb6a0733a5fcb",
      "a72ad37558d296e29372ad1a138b16970a0ea75f799cdf6f1d531ee3475df10138edf4ca"
      "7bd0d809f9ecf2433e1f3f9f90cfb6857cfeb34eaf3c280f7f58f62d"
      "4ee3fe719ca699ace387fbc727d86f6a178eecfe31e9ff4fbc78bfff9ca41eb6a073780e"
      "ddcfcaab9a552fd074c92ab133d3a989998590c3a799c3896cb9889f",
      "ff430e9f6cdfbf9822cb61993087bf1c7c9e26a9872de81c5ecc164523bbb594ac4d151b"
      "1c27ad2a5c224e871c1e96eb397c8f675bf81ecf5fbdf03d9e6de17b"
      "bcfec6ff056a9942d2",
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
                emlrtMxCreateString("KIhntwGMWBmW2eQMtZIcAH"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}
