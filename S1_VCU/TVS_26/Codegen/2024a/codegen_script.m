cfg = coder.config( "lib", "ecoder", true );
cfg.EnableDynamicMemoryAllocation = false;
cfg.EnableVariableSizing = false;
cfg.GenerateComments = false;
cfg.GenerateExampleMain = "DoNotGenerate";
cfg.GenerateMakefile = false;
cfg.GenerateReport = true;
cfg.PreserveVariableNames = "All";
cfg.ReportPotentialDifferences = false;
cfg.SupportNonFinite = false;
cfg.Toolchain = "CMake";
cfg.IncludeInitializeFcn = false;
cfg.IncludeTerminateFcn = false;
cfg.HardwareImplementation.ProdHWDeviceType = "ARM Compatible->ARM Cortex-M";
cfg.HardwareImplementation.TargetHWDeviceType = "ARM Compatible->ARM Cortex-M";
cfg.GenCodeOnly = true;

pVCU_typecfg = coder.cstructname(coder.typeof(p), 'pVCU_struct');
xVCU_typecfg = coder.cstructname(coder.typeof(x), 'xVCU_struct');
yVCU_typecfg = coder.cstructname(coder.typeof(y), 'yVCU_struct');

codegen -config cfg -singleC vcu_step -args {pVCU_typecfg, xVCU_typecfg, yVCU_typecfg}