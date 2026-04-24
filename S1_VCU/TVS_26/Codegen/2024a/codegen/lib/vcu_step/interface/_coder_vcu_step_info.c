#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[10] = {
      "789ced5bcd8fdb441477d052b5121fe100ea15a91c10b0ea66bf5a6e8993ee5af98eb3e9"
      "6eeb36eb8fc9c6aced71ec719aed81137005c489ffa027c411890b17"
      "044870810b07eefc111c20c9783689a94982ad2936f30e3b7efac5f39bf7dece2fa3179b"
      "cb08d50cc7712f71d8aef3787cd1f7b3fef81cb768413ce38f2f047c",
      "62cf731b0bf711fc637f54a185c00861c7924d7079a7064ddd922dd4beb001e700171a43"
      "a04d919e6e80b66e0271dea94d3cf3ce1c74e94ca0c935df07eab9e8"
      "999cd377672b34e69dcb7c7c1512efc68af91043f2910de0f74b0ff877a5231738aed4ce"
      "97a522543d1358c8950e7474e82992a89bae2adba00a356048e256b7",
      "c31f49ed8ed8cded49fc38790e348cc9cd43d5ebba08d89be6421ca711e3b8121a0746ce"
      "00eaf277e8f1b9c8f154145f9d9aa17c8b786c75c209f3abb43c6f2f"
      "af1847709c7dfeea74ec7fff5b8626df076f1aafd0e423f6acf84621f3adfa7ff85a085f"
      "36805ba5ad41fd6207aaa6bd0b6a7bcd825c571bc5d93a1a4b7896ad",
      "830bf169cd9f16ddb523c6716d491c049fc849a1d26dd47d3fa93adc0ee55bc463d5e169"
      "e270e168e9c6959fe8eaf0eea7db6fd0e42396761d16ca021a3865ad"
      "5fe21b55657b5b3c6e741e15980e27653faf1ac746c09fc58111d7d2ed38f996eaae6e9d"
      "1960c6f76544be7ac0e7029f23786c759a246c5c225afaf0d17774f5",
      "f6cf3fe4df69f2114bbbdede829dedb256da2f806171d8ceeb372f404e394c8fde46ddc7"
      "e590f9b301fcbe50293db861cac890150742744342101a0a1c49c034"
      "244357248c4936342e7a9e25e916028ebdb5696644e48cc5a70dab00f5a1261417d6ff49"
      "c4f5bfbd64fd0457c7f2e26c4e1765c906be182f5546c0bfc6ab734b",
      "9617cbf740d0c2d6478cf07df32ff9c8fc0f97f0117c5ccfdad3ebe9f6650768d23461fe"
      "dfb7fc81a4cfbfc2f993fe96bfc937292d5d69befe2b559de68ef33f"
      "50e5f32ded3a5d151abb1da0efdfbb5dcdb554e834cd2dc149914e3f09b97fd53c1e84cc"
      "9f0de01174dabfea3e82ce39d3e780cff4f9e9f1307dc6c6f4f99f79",
      "96ad830bf193d2b7f83ff68ff33c5faaf83eeb1fafd16f9a268e6efff86bcafde39fbf10"
      "5a34f988a55d8735f5bc50190e07458be77bbc72d453c0cd4e89e970"
      "52f633eb1f6363fde378f958ff181beb1faf377f5acebda711e3b81af06771606422f362"
      "592826f59c4bbd4e24612bd6292e9d18fd425777bdf7bf7d42938f58",
      "5275f7d510be6c00bf9d1b1d779a76abd07c7cf2dea8e51827c5fd2ac7743729fb999d73"
      "b1b1736ebc7cec9c8b8d9d73d79b3f2d7a1bb5bf1bf6be4d3680bbb6"
      "a1a31c82cec003f3fca711f9d7d5dfa875bb1bcab788c7a7bf7389a3a8c3b4fbbb9f7f56"
      "65fd5d2e7e1dce69025f7355ed6498d7ea465f6e0a77bd0a7b3ef83f",
      "d76f88aac36bbea7d122cf7724b5fff0ac9eeb6e1dd0fd9dadfc235d1d7ee74349a0c947"
      "2ced3a0c873b7bcaa8f878f7a8766b70d853ef593bfb67ec7db9c4ec"
      "67d67fc0c6fa0ff1f2b1fe0336d67f586dfebf00ea236698",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 17200U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740095.81028935185));
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
                emlrtMxCreateString("RUSi5TE2OKmEhSMowBH5H"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
