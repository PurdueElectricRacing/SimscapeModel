/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_get_y_cf_info.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 01-Feb-2025 15:01:30
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
      "789ced56cb6ed340149d40406c8074c31ea93baa880455057625495baba46a711a213a25"
      "f5e3a619d533138dc721f90af80c967c025bc4861542e26748fcc863"
      "e8e0a8062355b90bdf7b75ec7b8eef58274105a3594008dd43517c5c8bf2ddb82fc5f906"
      "5a0c152fc4f9a6d227710b15179e4bf0f771763893309451c32c0ad3",
      "275d4e09b3986c8dfa8004f8dc1b801b225de2418b5030e79b83494777e6a06933812675"
      "ad07ce851950247afe4ca137df4cf7f149f3bec525f76168f65152f0"
      "93c669ed393ef641f8d8600310b8ce9d8002933ede25722fb0b149a8ef587d6872173c6c"
      "563aedda316eb5cd4e75139f83ec8c3a4eb74c15fd6719f517957ea6",
      "3f427c46fa7f93efb6962f425c1ed81ecc7daf19f91a5abe453ce3f94cd6149e4dda9eee"
      "2fa95bcdb3fbef84f9bbfc194279f16d7c5bfb9a275f12ff8b6fa899"
      "b7ec77f740c35752f0a7bcfd64df6d6cbd80417dd0da268f4750b5f7663a0e5378d27420"
      "4d9fd7fcacfebaaf995f52f013e365e3749d5ad2b36cc1b95cc79273",
      "cfe6430cd4c31eb17184e13ef746dd806132fe3d12fd4a99164c29083b6ff126c81e778d"
      "fa82fe0f19f56fa4e84f70676c2aa21c8a6296171563a99684b88ed4"
      "f90d16d0797d6757d4a7864e5f1209dfe72bf225f3dfa6f025f8f83c0f2e3f4fbf670970"
      "71b8b0f8fa284ec9fae22ada1ffe6d7f13a3cecb578e1efec8d5a7d1",
      "ebed2fb9f2c571dd7dba691c6eb6816cbd79d6acbe72b838a215435c239fcefa3f6b5733"
      "bfa4e0197c3aae3aefb8b858f9b3d2affcf9f2f759f973142b7ffe33"
      "4f9a0ea4e9fff5fc5f4e0e41cd",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 4544U, &nameCaptureInfo);
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
      "Name",     "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "FullPath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("get_y_cf"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath",
                emlrtMxCreateString(
                    "C:\\Users\\Inver\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\get_y_cf.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739649.60760416661));
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
                emlrtMxCreateString("4yhruxunAuRRlgS2vnSYD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

/*
 * File trailer for _coder_get_y_cf_info.c
 *
 * [EOF]
 */
