#include "_coder_VCU_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9bcd8fdb4418c6bd684195a04bf6500ee584d44325aa55be97544255d6eb4d4292"
      "2589f3d5d66dd67166136ffc91b5c7e9262784b8c3994b254e3df68a"
      "840427a4151c38a156fc05dc39704224b1271fa626a68ea6d89df7b0e357ef669e2733eb"
      "df8e666c6a2b57dca2286a8732e359c16caf5a79c86adfa056c35edf",
      "b2da1d5b8ee24d6a7be573a8fea5d50aaa02c10534138597c1fc931d5516155e81d5d100"
      "501ad05569083ab3caa92881aa28037639399e66f2d152699e4c4bd3"
      "6bba07843e6bc894d6d3170ea5e564fe3d9e3a7cdf6d97e39173188f90ad7e9f7940dfe6"
      "6a3ad0742ea70c81c61daa82210305ea5c468459a3cdb1a2ac0bfc00",
      "14d50e903836d2aad335ae5a675bd10437b96ce9100cf6649bff8147ffefacf18fea5d00"
      "a77e5af2c4dcb2fe8947fdb71cf5cd8a0e3543809b9bafa2a3de6add"
      "e37c2d0fd76cced68dd7bb2efddbdbc5ef5f99b5e1f16fb3122e3de19efa1ca71e8a57a5"
      "77e1d09fdbbfbff71cf442b67a5f82cd71b30af972f302a4fa0d26a7",
      "ded5b30b1fa5353aeb7c500e39aefefdcedd138ffeafd8f2857fb33205c8a8259cfa95b3"
      "98e6070d93ebf9d914172e477839fbf1d3cf3ec7a987c2af9cbde6a0"
      "17b2d58ff4e101ddccd05abc928c81c47118c0ca5d8a70f6ff7e1fbbf5bf6dcb17fecd8a"
      "ae88834deaade36c4735da1258e83df1a8c738eaadd63dcecf7498b0",
      "ae637f8578f97aeb97dd9f70eaa1f02b5fddae633f52ebb17c87d93f00c3c361352d8647"
      "20da26ebd8797f7987fe43b6fafd5c81797043e6a1c4b73555853738"
      "a8aa525bbde0802c7192d8e6cc1a3750a5d1a9a170a202813688ecc95b2cd444a55b558b"
      "00f6d44eee70c5ff571efddf5ae31fd5850954b4bd99298597cc8b89",
      "551e02ebda74a7338a212ffb3b79497ff670f28702e9fdf0927aa8ff876bf4507d329fc7"
      "2f9e4fbdc76ba0c3cd06ccfaf9a1d5a0e1b3aeccf1e3fe317e5350e3"
      "e24af9836758394d35d39758f5ac083aa78bb952a20ec4fd7ba962b422a85a598ee4b400"
      "71daeb3a2be3d07fc856f7c069ebaaf548d5fa84cfb69cf0f9c5df87",
      "f0d90cc2e77fd759e78372c8fdb28ef6fb7ef0ba7d83e90609537d75e76ed8fe7f7adf47"
      "62aa93d9c1c50356c5bb4f71e7dbafbfc1a98722e87c65cfd3b0508a"
      "34ca29c12889c9642d2955da19c2d7d789af25c257377c2de1e4ebf798cfd97ebe7c7c13"
      "a71e0abff2d5ed395b2ac9c3ee7e874e338fb23aadc398d68b47a9e0",
      "f03568f72f395f33839caf6d468f9caf9941ced7fe5bff64ddeae47fb16eadb364ddeae6"
      "795c16e3baf5aa8197afbfefd6eee0d4431174bec61239665cdfcf8e"
      "ceba8346bfdbc995cef8fc21e1eb6bc557b22fe08aaf38f7057631f3f509ffc59f38f550"
      "049daf5aaad6cd37c6d1211bcf8e4710d6cef38518131cbefaf5fe1d",
      "78f4fdf61adfa86e0acf5f2bf3ed7b650547bdd5fa46e669f15a19363eec60e6edcdbfc4"
      "384e3d1441e72d231613fd33a639faa4cdd42367c3685a3b2a06e89c"
      "cbafbc3df1e8dbcd3ab64a9375ac8b79a9d218d7b1d73173b5fedde30c4e3d1441e72a88"
      "978bc747d16cbb4f878d48faa0193928e403b40feba3fb173f57eb84",
      "ab6eb85ac7c8d5f73173f5c73f9e5fc3a98722e85ce5c3893ed09561a5c4744123523b1f"
      "26f44f03b4ff1ab4fb973c376006796e60337ae4b90133c87303eefa"
      "ff1baa27aa35",
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
                emlrtMxCreateDoubleScalar(739654.84247685189));
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
                emlrtMxCreateString("reLVrPsjABDNqHKq7bLeOD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
