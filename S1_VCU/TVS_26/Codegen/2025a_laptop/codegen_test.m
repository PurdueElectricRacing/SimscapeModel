cfg = coder.config("lib", "ecoder", true);
cfg.EnableDynamicMemoryAllocation = false;
cfg.EnableVariableSizing = false;
cfg.GenerateComments = false;
cfg.GenerateExampleMain = "DoNotGenerate";
cfg.GenerateMakefile = false;
cfg.PreserveVariableNames = "All";
cfg.SupportNonFinite = false;
cfg.IncludeInitializeFcn = false;
cfg.IncludeTerminateFcn = false;
cfg.HardwareImplementation.ProdHWDeviceType = "ARM Compatible->ARM Cortex-M4 (MPS2)";

ps = coder.cstructname(p,'pVCU_struct');
xs = coder.cstructname(x,'pVCU_struct');
ys = coder.cstructname(y,'pVCU_struct');


codegen -config cfg -singleC vcu_step -args {ps, xs, ys}