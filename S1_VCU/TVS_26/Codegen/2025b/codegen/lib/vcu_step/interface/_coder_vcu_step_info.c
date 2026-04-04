#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[8] = {
      "789ced583b6fd35014765041300019103b52c500a8ea035ac4821a3771d3a64dc16944d5"
      "5b523f6e1a936b5f635fa749272406241658f9078c3c1646c4af4088"
      "8119891fc046fc6a62d38ba3c6186af90cbef7e8f33ddf79d89f2c33b9f25a8e61980b8c"
      "6bdfaeb8eb79cfcf7beb292668613ce7ad6742be6fa79989c0391f7f",
      "e1ad12d608ec12d7d104151e9e94b1aa6882466a3d1d32063431ea40d9419a0a82354585"
      "fcb0b36e7b6a69083a746cc8deb32d28b5794b658c9639c8100d3b87"
      "fdd8a5d43b11d18fb085fb11be6f5c3e3ffe592a9f8b7424ab6112a8c7c5479b77de434c"
      "62581219d4f7614cbe4d2a5f10df2eeeb077c0a6090d13c806460a58",
      "c292a5428d988053c8b225025e514d49d0e11a962102fc4ca3ce6e825a9d6fccce03b6ff"
      "38f64f21fbb8dfb22995899ed3c511eb08af83fbdd39fdfcf4d58192"
      "e2bbfaf95d2f493edffe155f97126fd4e7f032852f1fc2f5d2d6d6a3266bb40f5a82d0ad"
      "f7e0c1baa01706796c44f044e5c150fca4e2a7fd7d8e4b07f72069b0",
      "a5e4f8e2d65d9eca17c4639c93db32674ae9d5dde7ddb799ee32f1eb6ec5585d98e1e469"
      "24f3e515a49bbcaab53936d3ddff4d77f531eb381751878fdb6252a8"
      "3436aa9e7f5275b84ee50be231ebb0d33a7b7069d5e167d7321db62d761d9e9f6ede3c28"
      "6d5584e6fe03ae5a5a7c4c54ad94e9f049799f47ad6322e40fea7011",
      "53531ca94f4a77656c8908c637a77b54be201ee39cec96795fbfe9d5ddef97b2ff0eb6c5"
      "adbbb7717d6e552e2e146067a9535b54a67b70565c4e8feebea19c1f"
      "b58fab94f8f910be5dae147726558120413430269380608c44dc0550450029227031a063"
      "d46b5a1a5034020d7d664acdf1c450b4bd1a5e83a485e5f25220ff97",
      "63e67f23227f1f97fa22634c394969027237fd540502bdbd9b9d59d42c7538bfdd63e617"
      "b651ff7b7f3c269f1fff61049f8ff7e7b97ef43ccd96604019380df3"
      "aed7bdc56f9fb773fb077eeb5f92dfc73f9e7e4954a79fdc7dff2a493edfd2aed3d54e95"
      "936f75715d5b599c553aad39f1be55e3d2a3d3af29e747ed2347899f",
      "0fe163e8b4b76bec63a39de973c8cff4f9e87a327d762dd3e73ff344e5c150fcbf1dff17"
      "a37345ac",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 8696U, &nameCaptureInfo);
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
                    "C:\\Users\\droli\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_26\\Controllers\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740074.816724537));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.2.0.2998904 (R2025b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("gMyQC4VO0Rk8p0iKafaOdC"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}
