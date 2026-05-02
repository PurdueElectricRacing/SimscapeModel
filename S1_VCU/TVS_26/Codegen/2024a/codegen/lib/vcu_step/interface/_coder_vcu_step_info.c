#include "_coder_vcu_step_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[14] = {
      "789ced5dcf6fe344147651418b044b2ea015175469e1022a69b6ddb6dc5a274dbd4d9aa6"
      "71d35feea64e3c49bcf18fd476d2b482235ce13fe084b4e284c48563"
      "c5615748700369412ba1154710da23e280883376539b35b137c9b4b6de3bd47e7df57c33"
      "6f3a5f5ebe99b4d404939da028ea3a85edfec7f8faaae5c7aceb0b94",
      "d3dcf109eb7ac3e5dbf62235e978ce8e7f6a5d2baa62a08e811d8597d1f993822a8b0aaf"
      "18ec4913511ad255a98d845ea42a4a88156554b8e8ac9b9ebc722174"
      "ee9821f39eaea34aa3d09229adaef77b285d74cef3f18dc778277de6a3e0918f982bbe9f"
      "3aa03fe0b674a4e91cbbb4c625d54a4b468aa17369d1586d95b98228",
      "eb15be89b2aa8024ae30532ad25b1c5b2c9412b739ba9b3c4d9524f3e176a555d20dd49c"
      "961de3381c721c2f798e03476ac828d12be4f074436b558cd1cd53de"
      "13cf191fd93ce18459b334386faff91c87fbdafff96bbd2bf3cbe309927877fffee80e49"
      "3cdb2e0bafe3d19edfdfc3373cf062aef8467aaf589dcdc56b82d6e9",
      "f0f71a7b8d851926ddefc7c6009c41fda03c7c52ed477d3dfb1dc7a4cbef8f034774456c"
      "8e126f20ef8a4a4d427dbcb321f1f63df19cf191cd53b3fbfd92c197"
      "25a47366f27cbe4e8e8a2f9efe4c967f3fe71fca24f16c8b3aff2ea8c55b6b426a7e19b5"
      "936d76498c9fa04479353afcfb95c7f37ef3b8e6d17ecc15df6732a9",
      "839b326f487c595355e32667a8aa54563b1c92254e12cb1c8e714d553aa9b6144eecbe4f"
      "d09a33d3f244c1d0ba64c4aa5964d45581493afaffd990fd7f6f40ff"
      "ed78a54b37da74af530a2fe19b6e57790359f7b8777a4a69f95a8783fae736affed9362a"
      "9ebe3b00cf8e77e773fdd9f3a9d7790d095c2f61d6d777ad8b9d3eeb",
      "0ee78ffb4ffe4caa26c52bf9a94744799ada59fa8e289e6551e7e92cb3315744e2fcde62"
      "36b15951b5bc3cc36811e2e9fb1ecffbcd63daa3fd982b3e044f5b77"
      "a563556b003fbb7ce0e7678f07f8191bf0f3ffe30cea07e5e18745c7b82afa7173c871bc"
      "32601c76dc9451cc77e872b79b17f10f87c427ad276f7be239e323d5",
      "9fecc475e78e146ffcf613593de39d29fd01493cdba2cec3bb62a33e979fa7b7f20bda69"
      "714e3b5a6dd414d09323c7c32f0f18871d37e9643953dac8597e5879"
      "98f5c473c647cac3bdc44d13d55d49efeb9d1dc0be9e697e7f0f5ff7c08bb9e2f375545c"
      "d04e1a7cb95adb64db225b6384450a78382ceb19f6f5b0c1bede78f1",
      "605f0f1beceb056b1fea606c41eae0259a4e652c1feae000af9bbdc491ad836ffc409687"
      "df7ef2ed539278b6459d87854a6339d36e1f25159aaed2e5ad6a19c5"
      "8b29e0e1b0ac67a883b1411d3c5e3ca883b1411d1cacfda8d4c187438ee39acbef8f0347"
      "4cda2fac31c9b0d6bdc4e7c94e1861de7df31159defdf3c75fdf2789",
      "675bd479575c2bccd62b9d15f90415b2f1f8e231cfccb7601f2e34eb19ea5e6c50f78e17"
      "0fea5e6c50f7066b3f2afc3bacfeebf73c9ade94442361a8da518bec"
      "7934171f87ee3cdac5c4113c8ff6d7f76479f8f15b5ffc4e12cfb6a8f3704260e875bd22"
      "ecb697849c54e7f3cc762bb30c3c1c351ebeeef2dde3b0e31aeaf652",
      "42259b89c35a17ef7ae239e3239b3767e288ffbd09d2ba4463ea09e812d4e8cfa5356ecb"
      "adf662b993cba69a0adb296f1aa71b475474f8f8cce3f9a8ad6bd027"
      "b0813e315e3cd027b0813e11acfdd0d5c557e17cda169bdbb1fcb0eed35dce79163371d1"
      "fe9cc6c34f3e84cf6950a3e7e13bed057a45430955a8f162276ea8c9",
      "a37411f489d0ac67a883b1411d3c5e3ca883b1411d1cacfda8f0efb07530ecd3397f0ef6"
      "e99e0f0ff6e9b0c13e5db0f681879df9f01a07ecd3c13e5d103cd8a7"
      "c306fb74c1da8f8a3e7c38e438fc7c6e834d15d8b0eac19772bec54c18613d224b580ffe"
      "72f7eb7f48e2d91656def55b07af8a9b9dfc8e74abb8973f4e364eda",
      "333ada49c3e79543b39e410fc6067af078f1400fc6067a70b0f6a3c2bfa00707c3033d78"
      "3c78a00763033d3858fbc0c3ce7c801eec8c831efc7c78a00763033d"
      "3858fba1e3e32b705e783953dab4ffaf5358f5e1cbfa3bd09b69b2e78549eb13a77f3c00"
      "7d821a7d5dbc5c17504e589badea8534bb6d08e97b999d2ae8c3a159",
      "cfa00f63037d78bc78a00f63037dd85ffbff025c9bd46c",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 34240U, &nameCaptureInfo);
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
                emlrtMxCreateDoubleScalar(740104.50526620366));
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
                emlrtMxCreateString("bKk7GNf4tJr7lLXSBG1p1B"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}
