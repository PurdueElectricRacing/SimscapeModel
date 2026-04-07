#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[7] = {
      "789ced55cb6ed340149da0f25a0059b16283548905286a53d107bb3649532b495f76034d"
      "a704c79e3656c61e331ebbc91fc00ac49e352c59b244884d253e8005"
      "1f431cdb4d633a38226150a3dc45eedc1ccf3df7119f8094544901006e83c03edf0bfcad"
      "304e87fe0a18b4389e0afdd5580ccebe9f19b817e16f42af118ba136",
      "0b024b35d1d94d9d9886a55a4ce9d80850e410ec21bd871c1918298689e4f3c1a61f99eb"
      "e7a0b3c087fc73ae89b496ec9a80369d7e85f87cd09f07a7df9921e7"
      "2173e6918ee10785c3dc13b8e720ea4065b504f344734d643107160db6e136a06c988ea6"
      "daa8427484a13c5fafe6f6a05295ebd94598eb0e8f128cfdcb9ee6d6",
      "1d86ec8c39d0c78b11fbb8c6ed23408e11abe7d6c5f1398cba1a1bdf9e76b87c83f8d8f6"
      "140c2cdc52f2dcee0cd947dcf79fbfd1f3afbffd4c89e47b80525424"
      "5f64ff8bafcdc937eceff02e872f1dc3f737969b272f1b52794b45732b7bdefe7e1bafac"
      "f5ebd84ee049aa03706251f9274577ed11fbb899d04784fb72b256ae",
      "6f6f85f165d56185cb37888f55877b830b16274a375e09d6e1da69e6bd48bec8265d8717"
      "776b4b4f73aa27b99bc5856cb955b66b7aa138d5e1cbf23e0fdbc74c"
      "2ceef711208e65d8e3e44bd45dc33ac6a8cff76944bead580c62cf45f8d8f6e40facbb22"
      "51faf0e1ab58bdf5be5f7f27922fb249d7db65525d28e985a535e4e5",
      "3d65d598eba06c636372f476d4f7b8c4c99f8ee10752b970386baa0cab0d4a089b858c10"
      "dc206d884c0cb1d18001066d823b47ae050d8b216acf67cc94cc6857"
      "7c145241ac4974293f50ffdb11eb7f94507f846b5d79a1995e51968a8343b75495a1f01c"
      "54e7142c772cff0371e3d51759c4f7e52ff9a2fccf13f822bcbbcfcd",
      "8bf7e934558a74d81b58f8f93074d1f8c253303ff8dbfcfc7f5251bab273ff87509d06cf"
      "564f85f28536e93a5d91b61f5791b1545ba96477354277cc79894e90"
      "4e7fe4dc1f768e454efe740c1f41a7c353fd84d0d6549f63f1549f2fee67aacf814df5f9"
      "cf3c4975004efcaff3ff02558ff990",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 7376U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740076.48462962965));
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
                emlrtMxCreateString("xZBO7wxIMcPnOFLS8NpOL"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
