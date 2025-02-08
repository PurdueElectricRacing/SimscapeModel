#include "_coder_VCU_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9bcd8fdb4418c6bd684195a04bf6500ee584d44325aa55be9754425536eb4d4c92"
      "25891d276ddd669d6436f1c61f597b926e7242883b9cb954e2d463af"
      "484870425ac181136ac55fc09d0327441267f2616a6cea688add790f3b7ef56ee67932b3"
      "feed68c6a6b698e21645513b9419cf0a667b759e87e6ed1bd47a58eb",
      "5bf376c792a37893da5efb1caa7f396f5b9a0ac10534135554c0e2936d4d91545185dca8"
      "0f281d189a3c04ed59e55492012729805d4d8ea79972b4525a24d3d2"
      "f43ad305ad1e3b5028bd6b2c1dcaabc9e27b3cb5f9bedb2ec783b1198f90a57e9f7e90b9"
      "2d540da01b02a30e812e1c6aad81025468085909e6064d819514a325",
      "f641516b035960230d3e5315389e6d4413c2e4b26140d0df532cfefb1efdbfe3e01fd53b"
      "004efd349489b955fd138ffa6fd9ea9b1503ea8316dcdc7c156df5d6"
      "eb1ee76b75b86673e6345eefbaf46f6d97bf7f65d686c7bfcd4ab8f45af7b4e738f550bc"
      "2abd0b9bfedcfefdbd67a317b2d47b32ac8feb1c14cbf50b90ead568",
      "46bb6be4963e4a0e3a4e3e289b1c57ff7ee7ee8947ff572cf9d2bf59990264d4689dfa95"
      "b398e6070d93ebf9d914172e477839fbf1d3cf3ec7a987c2af9cbd66"
      "a317b2d48f8ce141a69ecde8f14a320612c761002b7729c2d9fffb7decd6ffb6255ffa37"
      "2b862af537a9e7c85949edc860a9f7c4a31e6dabb75ef7383fd361c2",
      "ba8efd15e2e5ebad5f767fc2a987c2af7c75bb8efd48e363f936bd7f008687432e2d8547"
      "20da24ebd8457f799bfe4396fa7da6403fb8a18850169bbaa6c11b02"
      "d434b9a95d08409105596a0a664de86bf2e874a00a920a81de8fec295b2cd427d0e1b422"
      "805dadcd1caef9ffcaa3ff5b0efe51bd35818abe3733a58ab27931b1",
      "2a4230bf36dd19b43a5056fd9dbca43f6bd8f94381f47e78493dd4ff43073d549fcce7f1"
      "8be7d3e88a3a680bb3019bfffc70dea0e19b5f99e327fc63fca6a0c6"
      "c595f207cfb0729aaaa72fb1eacd23e89c2e32a5040fa4fd7ba962b4d2d2f4b21261f400"
      "71daeb3a2b6bd37fc852f7c0e9f955e391a6f7089f2d39e1f38bbf0f",
      "e1b31984cfffaee3e483b2c9fdb28ef6fb7eb0d3bec1748384e65eddb91bb6ff9fdef791"
      "686e323bb878c06a78f729ee7cfbf53738f550049dafec791a164a91"
      "5a39d51a94a464b29a942bcd2ce1ebebc4d712e1ab1bbe9670f2f57bcce76c3f5f3ebe89"
      "530f855ff9eaf69c2d95146167bf9d49d38f7246c68031bd1b8f52c1",
      "e16bd0ee5f72be6606395fdb8c1e395f33839caffdb7fec9bad5ceff72ddcab364ddeae6"
      "795c16e3baf5ea002f5f7fdfaddec1a98722e87c8d25187accefe746"
      "679d7eadd76933a533317f48f8fa5af195ec0bb8e22bce7d815dcc7c7d227ef1274e3d14"
      "41e7ab9eaa76f2b57174c8c673e31184d5f37c21460787af7ebd7ffb",
      "1e7dbfede01bd54de1c56b65be7dafac60abb75edfc83c2d5f2bc3c6871dccbcbdf99714"
      "c7a98722e8bca5a562a27746d7479f34693e72368ca6f5a36280ceb9"
      "fccadb138fbeddac63b90c59c7ba98172e83711d7b1d3357f9ef1e6771eaa1083a5741bc"
      "5c3c3e8ae69abd4c7810491fd42307857c80f6617d74ffe2e72a4fb8",
      "ea86ab3c46aebe8f99ab3ffef1fc1a4e3d1441e7aa184ef480a10e2b25ba036a91eaf930"
      "617c1aa0fdd7a0ddbfe4b90133c873039bd123cf0d98419e1b70d7ff"
      "df7c7baa4a",
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
                emlrtMxCreateString("iFL73cGip9hldXVLxgdjME"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
