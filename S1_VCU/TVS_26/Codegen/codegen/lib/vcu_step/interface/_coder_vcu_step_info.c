#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[8] = {
      "789ced583d6fd34018765081320099d811dd40553fa0051694ba499a266d0a7623aa5e09"
      "4e7c694cce77c63ea749272466046240e217c000088484181123e207"
      "20c4ccc67f208e7d4d636a1c6173d028ef90bb578fef7dde0fdf63294222b7921004e194"
      "e0da97b3ee7ad2f393de7a44e8373f9ef0d6633e9fd95161acef1cc3",
      "1f7a6b95600a5bd475b0a2c3bd932ad135ac602ab70d2898d022a809d52e52d31094351d"
      "4afb9d55c7d333fba03dc7819cbd5887d58664eb8259b77a19a2fdce"
      "5e3f6e07d43b16d20fbff9fbe17f2e2a1f8b3f1ec8e722cdaa5db62834e2e20b9a77d243"
      "2c6ada55daabef7d443e2990af1fdf4c6f8957c1ba054d0bc8a93c58",
      "24555b87985a20abd125bb02244db7aa8a0157880a1190a6cb25711dc825a93c3307c4ce"
      "cb6812849cc3ac61937a376e58df4e0f58877fed3defcee9e5c76f09"
      "9e7ce7bedfdae6c9c7ec5ff1b502e20dfa1e9e09e04bfa7023b3b171a7269a8dddbaa2b4"
      "4a6db8bbaa180bbd3cd64278c2f210027c5ef187fd3ec7a583db9096",
      "c50c3fbeb875f77a205f3f1edb9cdc867953e2a7132f38ebeebb276f549e7ccc865d770b"
      "667e7e3aab4e2155ca2d23c39274dcc88a23ddfddf74d78858c78990"
      "3a18eec8c942a1bc56f4fcc3aac372205f3f1eab0e771be70e8e976ebce2acc39fc6af3c"
      "e0c9c76ce875786eaa767137b351506a3b37b3c54cea2ed57166a4c3",
      "87e53e0f5ac798cfefd5e12216d68c38f9c27457257605c11edfeb887c459f2ff89e6378"
      "6c73721ad619112f7d78c6596f9b9f8f3fe6c9c76cd8f5f63229cde6"
      "d5f4fc026c2e36e59436d5863395a5e1d1dba8f7381f103fe9c3377385f4d684ae50a454"
      "4c42e804a084a00a6901a82380b40a70316010d4aed918689842d398",
      "9ed413123535bc2d931548eb44cd2df6e5ff2862fe1742f26778b5232fe6643729ac2077"
      "d34955a1d0dbbbd959696cc7f21df0dba0ff777ff8433e16ff56081f"
      "c33bf35c3d789e565d31a10aba0df37ecf7b0b6b9fb773fb077ee99ff325e5a52b3fee7f"
      "e5aad3f7aebd7dca938fd9b0eb74b159ccaa975aa4849753335ab33e",
      "5bb961cbd9e1d1e9e701e707ed6336207ed28747d0696f57de216663a4cf3e7fa4cf07d7"
      "33d267d746fafc7b9eb03c8400ff6fc7ff09d9f53afd",
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
                emlrtMxCreateDoubleScalar(740074.43857638887));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2943329 (R2025a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("gMyQC4VO0Rk8p0iKafaOdC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}
