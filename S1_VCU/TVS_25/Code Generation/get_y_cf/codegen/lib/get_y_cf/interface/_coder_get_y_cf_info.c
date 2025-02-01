/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_get_y_cf_info.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "_coder_get_y_cf_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
/*
 * Arguments    : void
 * Return Type  : const mxArray *
 */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[6] = {
      "789ced56cb6ed340149d40406c0a61c31774078a68aaaa880d0a494843488bb09b4da7b8"
      "7e4cea51e761d96393ec90f800d8b26383c412891fe02b58c01f20f1"
      "0fd8b19d87e9e0282946aa7217b9737432738eef44c701a54eaf0400b809e2fa703bee1b"
      "09ae24fd0a98af2c5f4afad50c4eeb1a28cfed4bf9b7493739136828",
      "62c0748a263b2d4e31d39950470e022ef238099035660698201553a4cc82fd08d12733d4"
      "044454b46ed8c83c537c0a5cdb9b3a24b360328f4f92e72d2f388fb6"
      "641e950c7fd43a6e3c84871e723da8d6bbb0c94d9f22263cd8c662cf37a082a967ea0eea"
      "710b11a86c69fdc62154fb8a56db81a7486823cd1c54e9c4f7c98abe",
      "cb193cf51d331ec34ed42f4aefba542f662cee1b045ddcbd34a47af3fc4af7120d29bc93"
      "a8f2e6746b41dfd93efdfe8d71ff267e948ad4dbf8f873b748bdb4fe"
      "97de5072dea2bfbb3b12bd4a867fc0fbdb5dabb5fb1805cd40ade3fb235433f6a63e9ee7"
      "e8e4f900125cd4f99f25fb179d6357727e25c31f759eb58e37a92e88",
      "6eb89c8b4d283827061f42440924d88031071d4e46039f411cbe875c67ab4a4b8a70313b"
      "55790f099b5b9de69cff772bfabf97e33fe5cd3056dcead814d349bc"
      "08adea0225ebd89dd7623e9df577b2a4bf6cc9fca595ea7d5d522f3dff658e5eca87f7b9"
      "7ffe7d7ab6ee220b8e07967cde4d5a3abe6415cf0ffe31bf28aa8bca",
      "955f6fbe179ad3af1f7d795fa45e5a973da70f8283b6b533e47df6b45ec381bd6dbcf0d5"
      "f6e5c9e9c2feff2e9fd3c94a7bc5ddb3753e67f03a9fcf7f9e753ec7"
      "b5cee7bfebe4f90012fcafcfff0d238c43ce",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 4536U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/*
 * Arguments    : void
 * Return Type  : mxArray *
 */
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
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("get_y_cf"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "ResolvedFilePath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\get_y_cf.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739649.57726851851));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("24.2.0.2806996 (R2024b) Update 3"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("Vz2qU7gyduiZLHSOzwHAt"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

/*
 * File trailer for _coder_get_y_cf_info.c
 *
 * [EOF]
 */
