#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced5c4d6fe344187650415d898f5ce0c405b1072450d5a474bbcb012971d2ae1ba769"
      "e224dd745d52c79e346efd557f25fd012071028913ff800b88231217"
      "1007c4810b70e0c01521f10310128725c9789ac4ac498cbdb36b33cfa1f6abb79e67de77"
      "3a4f464f925219a69aa128ea790a62bd03afcf7971d6bb3e452dc29f",
      "cf04c4084f536b0bcfa1fc07de55d4351b8c6c1868820aae9f947455d604cd6e5e198032"
      "81a52b2e90a699beac80a6ac026e3e389844eaee5cea3a98a426f7f4"
      "0088179ca352e6c09acd50990faefbf14540bd6b2bf6830be847d697bf5f3ea1dfe25b16"
      "302dbe59a8f0255d7454a0d916bf27db779d1ecfc9aa250a06a8ea12",
      "50782ed76dd32dbed9e6baf95b3c3d6e9ea92bcae4615774ba960d8c0d75a18ed388753c"
      "135807cc9c01bb4befe2e3b36cd311edf8d6a91ec8b7988f6d9d60c3"
      "bc555adeb71756acc37f9dfdfefaf47afcd32f199c7cafe53efd1d271fc2e3e21b058cb7"
      "eadfe14b017c595f3e2f9c0f1db9aa6e7786eced5afbac772bbfdbbc",
      "3b9bc7e1129e65f3a002625ce3a77d3faf5ac79a2f9ed5013396261b71f22dd55d593b53"
      "c08ceff3887cb540bec57c6ceb3469d8789570e9c37bdfe2d5db077f"
      "09bfe1e44348bbdeded6db5b15a9bc53046ec96d16e4cd2b90ef11bd7de2ceb946c43a6e"
      "2ca903e527725f64bb87489f927aee6d06f22de6637d9d9c360e2e1c",
      "2edd78f747bc3afce7fb97224e3e84b4eb70f15c3876deec8fd84263400fb4568e2e70f5"
      "22d1e1a4ec6772ee8520e7de78f9c8b917829c7bc38d1f751f5702c6"
      "cffaf2f719b67c7253156c45e899ba6edfe46d5d577afa8807aac22b728f8739ded095ab"
      "bea3f1b26603d3c86da819ce36c7e2d3d4abc01ee812535a98ff8711",
      "e7ffc692f9a3bc38961773633a294d50e0cd78aa820dbc7b383babac39b1bc0ef811343f"
      "04c4f7d57fe443e3bfb3840fe5c7eb79f0f0f5b4068209247eda30ef"
      "e7ebde05b5cfbb83fde3ffd1bfc92b292e5da9bff233569da6ee15bec3cae721ed3a5d65"
      "0eb7db40de39be53cd3744ddacab39c64c914e7f12f0fcaa7ddc0b18",
      "3febcb47d069efae3bd4cd0ba2cfbe98e8f3c3eb21fa0c41f4f9df7996cd830a8893e25b"
      "fc1ffde3024d97592f26fe7108bf69da38bcfef197dfe3f5337ef88c"
      "69e0e44348bb0e4be2459175ddcb9246d37dbad7eaf7c066bb4c743829fb99f8c710c43f"
      "8e978ff8c710c43f0e377e5acebda711eb58f7c5b33a606622f35c85",
      "2925f59c8b7d9d50c3565ca7b874e204f3e7835f7e70c9e0e44348bbee6e1be6fefeb0d3"
      "03607367ebe878576eb3fb5b7b447793b29fc93917829c73e3e523e7"
      "5c0872ce0d377e5af436aabffbec923a50de3214d9cedbba79e98079fed388fc61f537ea"
      "ba1d05f22de6e3d3dfb9c661d461dcfeeec71f5589bf4b3d82efc549",
      "0c7d608952c72d48356520d4992387259f0f7ee2fc86a83a1cea7db656b376cf8b93ea3f"
      "3c1e5f7ed238bcefb36998fd876f5e3dfc03271f42da75b87caed1c6"
      "9d76bd322a08f502cb565de7608bbccf9698fd4cfc0708e23fc4cb47fc0708e23f841b3f"
      "2d7a4bfc87707cc47f78347cc47f8020fe43b8f189ff0011f2ff4434",
      "d0f74b88ff10ee7be58d3dbcfec33e66ffe1eb5f6fbc8d930f21a93afc62005fd6971f72"
      "c670e7d816cf816b8a835aebcc70e50e45743829fb99f80f10c47f88"
      "978ff80f10c47f586dfcbf017fa1cdf9",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 22816U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740097.03769675922));
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
                emlrtMxCreateString("Kje8hVYSQz5TPlVFHfsnnE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
