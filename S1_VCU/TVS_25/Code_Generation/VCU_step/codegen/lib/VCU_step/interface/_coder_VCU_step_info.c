#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced9add6ea34614c7719556bde86e73d33ec15eb46a1525f1faa31f52e5e0aff87b03"
      "763e4ad6c130b1d90586c200ce5e45ea5da5aa7bdb07a8d4cb4a7d81"
      "3e452fba6f50a9ef50e381d8a64bf106441c76ce8587a363cfff30637e3e3e40650edb19"
      "8aa21e52d8ae5b787ce0fadbeef80eb56afe78c61d1ffa7ccfdea5b6",
      "563ee7c57f724701aa084c1176545e01379f14a122a9bc8ad82b0d503a30a06c01711eb9"
      "9464c04a0a60969d8ee329d5a5d08de3849c637a0284e78ca950fac4"
      "5864282f3b37e7f16bc0f96eadb91eb580f5d8f6c5bfad9cd35f727d03e806c7969a5c19"
      "0aa6025464703509d5cd11c7488a21f01a684311c81cb3371cd07d8e",
      "1d30c3fd1c6709e6d04040db516ef2d622e6fd4148de5e7c0c9093c95099a5e5f89efe45"
      "44fdf702f571c440ba29a085de6f11f59a817aabf148fbb4bc58b3bd"
      "722c6cbd3e5c337fffb878fffbf3f1fcc7579924f56ac2f5ab24f53cbb2bbd69c07ceb7e"
      "ff3e0ad0dbf6c51f572e4b07f976f7d4ee159ab9f117c7d5ce716129",
      "8f5e884e581e54809fd4fcf795b71711f30ee39d830eba7a777c8dba2f9540bdd57864be"
      "d2d53959d3cad5afbe265c756cddefddc7017adbbeb85ca4cb4586a7"
      "cfb2f933f4626455ac5aeeb04cb8baa9d7efba796ff9fc45de3862a8d2bc544e8cab923a"
      "96417cfb4207eaadc623ed8bb34809d7ab7fa264b9fae097bf0b49ea",
      "799676ae16e120db142b850360952db624ed5e81fd513d3d5c4dec7fe761ab72fe48e191"
      "cc8f7408d1230e41288fe094038accc9d288c3314e83f2d5a5a97292"
      "8a80aeeded281906e933e8b0b00dd0048ace8fda52fe2f23e6ff7948fe5e5c986145df99"
      "27a5f2323e98a5ca23e01ee3ec8c8a6a2acbf95ddc323fbf05e5e799",
      "a7f7c72df5bcf99f86e879f1d97e765ebf9fc684d781c8cd17cc7dfdcc1dbce5738ff0fa"
      "71ff593f07d54971e59fefff4a94d3d7dffcfe73927a9ea59dd35dab"
      "5b13735338501ba57dc99a644747265b4b0fa713eb2bdc9ed3eed1d086fa73c2679f4ff8"
      "fcfaf3217cc646f8fcff3a617950017eeaf87c0ffbbe072dd2f70ded",
      "1b1db448df37463dcfd2ce55daeeee8a7676529b564ea7a05382dda3ba40b8fa5670b5c7"
      "12ae8672b5c726cad5fecb64b94a8d3ff934513dd7ee2b57d77d4e61"
      "32b0cbb45edeb7b513f559ae27abedd3be4a11ae6eeaf54beea76123f7d3e2d123f7d3b0"
      "91fb696f363fa957fd792fead50143ead5f0e76b9954f701c873b5d8",
      "e2e66a675ca28f0e759b292a8d93ba4657cdddef44d207783bb84afa006b7035d93e40d2"
      "5c3dfe8170d5b1b8b9fa6c7af2044d597baf5a3f93155ad48cfea849"
      "13ae6eeaf51b2757599a7035745f583ad55c25f7adb0c5cdd57ca1058b76b75b2f5f3d6e"
      "0855b971f9246b54085737f5fa25fd556ca4bf1a8f1ee9af6223fdd5",
      "379bffde70f52eead501a957c37fef06a9ae57497f155bdc5ccde63a56376fb576f75e94"
      "f3dd46114a7dad4dfaab1b7bfd927a151ba957e3d123f52a3652afae"
      "37ffbfeaa98a38",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19608U, &nameCaptureInfo);
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
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 4);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("vcu_step"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(4.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "ResolvedFilePath",
                emlrtMxCreateString(
                    "C:\\Users\\TAK\\Documents\\GitHub\\SimscapeModel\\S1_"
                    "VCU\\TVS_25\\vcu_step.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739680.77336805558));
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
                emlrtMxCreateString("w7bCYL1ZFm4B88Tm3O56QF"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
