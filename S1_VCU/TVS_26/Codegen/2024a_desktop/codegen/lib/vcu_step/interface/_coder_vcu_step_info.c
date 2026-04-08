#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[8] = {
      "789ced584d73d240180e4efd3aa85cf4ee4c673ce8745a3a16ab271a288d404b498a0edd"
      "4a43b22d91241b379b48fd13eaf80f3c79f4e8d19be33ff0e0c57f22"
      "61931662d7a064e280790fecbef3b0fbbc1fe4c9f07219a196e138ee3a47ede31dba5ef3"
      "fdacbf5ee0c62d8c67fcf572c80fec22b730762ec05ffbab824c02fb",
      "843aa66cc0d3932a32345336897462410e431be92e5487c891a6434933a038ea6c7b9eb1"
      "39029d3a1ee4edf92e547aa26370b86b9f45a88f3aa7f5f8c4c87761"
      "c27a888c7a6443f87ee9807f08f66c886d20152aa08814c78026b14159235b4e07889a61"
      "2bb2056b48853a1057da4d7e0f484db19d5b03fca07818e9ba77d855",
      "9cb64da0b5648ce57138651e97987950e4189236bf991c9f4db0a390f8fab4cbe41bc763"
      "eb132d98dfa5e8badd98308ff07af6fd2bc3f5fd97ef9924f9728fde"
      "bd4d922fb07fc5d767dc37e9eff026832f1bc27b10f5f2ca5a69b359dbd248df2cb8af5a"
      "8f47e2a847f044c5c131fca4ee9f17ddb5a6cce36a441e01eec9c946",
      "b55ddff1fd59d56189c9378ec7aac3c3c2d1c6a53a1c0f5f60b3aac3b7187cd910bed668"
      "e59ff0b22b38dbe5d55cb557b55a6aa99ceaf0ac3ccf93e6b110f2cf"
      "f2a0886d6a569c7c91baab99c73a1cf9df3625df4ec8e742df0bf0d8fae4156cd0a2a4f4"
      "e1b090acde729d1f9544f97c9b77bd7d809aab15b594df806ed1950a",
      "daf209cc75b6e6476fa77d8e2b8cfbb3217c5fa8960e160d99e87207234416014148efa0"
      "3e80860e74ad0328062ca49f1c3926d04c02b1b5b26464448207e223"
      "a11a245da40ac5b1f8df4c19ffbd88f8035c19c80b5e1a0665ca3add0c429509f4f7343a"
      "bb643ab1bc07c2c68a2fb080eff35ff205f73f8be00bf0413fb7cfef",
      "a7dd953154c1b060fee75d7f09cae7ef68fdc02ff5f3dea449e9caeeed6fc9eaf4d3c2d7"
      "44f97c9b779dae09f5fb4da8e55bebb55c434178d75811f01ce9f407"
      "c6f949eb5866dc9f0de153e8b4bf6bbf44b897ea73c84ff5f9fc7c527da696eaf3ef79a2"
      "e2e018feaccc2dfed3f9712378efa4f3e33f9b3735cae9fc384ebec0",
      "e65d8737ecfa72a55b715eb49ebb02c10dfe5817d68ba90ecfcaf39cce8fa9a5f3e378f9"
      "d2f931b5747e3cd9fd3f01ec15a757",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 10184U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740080.74762731476));
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
                emlrtMxCreateString("cVPoO5AXBlBL9Z6Hfp0hIB"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
