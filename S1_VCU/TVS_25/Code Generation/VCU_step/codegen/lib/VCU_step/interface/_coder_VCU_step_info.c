#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[11] = {
      "789ced9bcb6fe3441cc71d286825d8a517387002b12740551e6dda7041a9e3366d9ead9d"
      "7457b89b3ace3471e3476a8f9d879040e282e00047b8710121c40109"
      "715efe0a0e70e48604882337e238938759e3504793d69ddfa1e39f7e8dbfdfccd41f4d67"
      "c654e4a010a128ea1ee5c46779a7bd3bced7c7ed53d47cb8eb91717b",
      "cf95a378865a9bfb1caa7f326e454d85a0079d44151430f964435324555021d7ef004a07"
      "86265ba031aa9c4b32e02405b0b349d1ce94bd99d224b14bf635dd02"
      "629b35154a6f195387f26c32f91e5f7b7cdfb505fb63dfa33fd65df5779853fa2dbe6200"
      "dde0b9748ecf68a2a900151afcbe04b3669d6725c510850e28680d20",
      "f36cac56a52b3c57656bf12dde12cd9a0141674399f8ee04f4fdbc8f6f546f02683ba929"
      "435b768ef4cf02ea3feba9ef540ca89b229cea7d17502fe7a9375f0f"
      "344eb39d351c2b3bfcfaeb8505fdbbdbe9efdf19b5d1f77e89e0d47bedc3e2eb38f550ac"
      "4aafe771bf45fffe5ef2d05b77d5e3c094ab49711037b5927691d432",
      "a050c967a73eca3e3a7e3e288f1cd7fd6f2a6fcf02fabee3caa7be9d8a8d8e7e4d3c5f15"
      "5f6fc4b8a04e5a605c96c5815fdfc5cbd53fbefd388a530f45d8b97a"
      "18057d502a5c0c8cf39da3c15e377a5248009a70f5ba3ebf8bfa5e73e553df4ec550a5d1"
      "54191b5725b52983e58d0beda9375f0f342e7627619eaffe04f172f5",
      "ee97bf6de3d4431176aeee68d544aec16cef022b63716929da07f17a88e6abd8feef3cc8"
      "33a7f71501ca425dd734789f879a26d7b51e0f149997a53aefd4f88e"
      "26f7cf4d95975408f44e6c4389b0501f4287d30a00b6b4c64166ceffa701fdbfe9e31fd5"
      "c52156f48d912955909d8ba1550182f1b5e3ce60545399f57776457f",
      "eef0f28702e9fd78453d74ff473e7aa83e1ccfe293c7d368093a68f0a30e1bff7c63dca0"
      "ee1b5f39fdc7ffabff6c54e3e2caef1ffc8c95d3efbffdfde738f550"
      "849dd325abb4dfd8ea6955f5301d97ac56a27e6c72fbe1e134b6f9efd5393dbeaa7535bd"
      "4df8ecca099f9ffc7d089f9d207cfe6f1d3f1f94471e3a3e5fb3755f",
      "bff5027b4984e156b7af16745c184fbdf97ae07523861bad50e0e200afe15d9f10a5a7bf"
      "c2a98722ec5c652fd3305f8e9d1ca544b32c259395a47c5c275cbd15"
      "5c2d13aefa73b58c97aba9015eaebe7cfacdab38f550dc54aebee8a1b7eeaaa792026c6e"
      "37e834d3cd1ab401137a6b334e11ae5ed7e797eca73941f6d396a347",
      "f6d39c20fb69ffeffe64beeaf63d9daf5659325ff53f5fcb629dafe23e57fbf895bffec4"
      "a98722ec5ced0bbb46a9dded95d5a3144c171ff63307b19d0ce1eaad"
      "e02a59075880ab78d701feeee2e5eada0f8f1fe2d4431176aeeaa94a337732885bec6676"
      "d087b07299cb2718c2d5553fbf9d80be9ff3f18dea8ef4e4f5b01bfb",
      "7ed8a1a7de7c7d09e334fb7a18e1ed92f450849db78c54d86a5f300ffa8775a61abbb0e2"
      "697daf40f6b356cedbb380be1799c7723499c7fa8e0b47877a1efbc5"
      "4784ab762c9bab60f3a850dc8b67eb6d3a6ac6d2bb0f62bbf91c5977bd1d5cad12aefa73"
      "b54ab8ba443d1461e7aa10dd6a0343b58ecb4c139cc42a97d6965122",
      "ebaed7f6f925e7049c20e70496a347ce093841ce092c76ff7f005ffd969d",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 19632U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(739659.80225694447));
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
                emlrtMxCreateString("IMERgGPbOt7fpJYzzx82DF"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
