% TEST   Generate static library vcu_step from vcu_step.
% 
% Script generated from project 'vcu_step.prj' on 08-Apr-2026.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.EmbeddedCodeConfig'.
cfg = coder.config('lib','ecoder',true);
cfg.HardwareImplementation.ProdHWDeviceType = 'ARM Compatible->ARM Cortex-M';
cfg.HardwareImplementation.TargetHWDeviceType = 'ARM Compatible->ARM Cortex-M';
cfg.EnableDynamicMemoryAllocation = false;
cfg.EnableVariableSizing = false;
cfg.GenerateComments = false;
cfg.GenerateExampleMain = 'DoNotGenerate';
cfg.GenerateMakefile = false;
cfg.GenerateReport = true;
cfg.HighlightPotentialDataTypeIssues = true;
cfg.PreserveVariableNames = 'All';
cfg.ReportPotentialDifferences = false;
cfg.SupportNonFinite = false;
cfg.Toolchain = 'CMake';
cfg.IncludeInitializeFcn = false;
cfg.IncludeTerminateFcn = false;
cfg.GenCodeOnly = true;

%% Define argument types for entry-point 'vcu_step'.
ARGS = cell(1,1);
ARGS{1} = cell(3,1);
ARGS_1_1 = struct;
ARGS_1_1.r = coder.typeof(single(0));
ARGS_1_1.ht = coder.typeof(single(0),[1 2]);
ARGS_1_1.wb = coder.typeof(single(0));
ARGS_1_1.gr = coder.typeof(single(0));
ARGS_1_1.MAX_TO_ABS_PO = coder.typeof(single(0));
ARGS_1_1.MAX_TO_ABS_RG = coder.typeof(single(0));
ARGS_1_1.PB_derating_full_T = coder.typeof(single(0));
ARGS_1_1.PB_derating_half_T = coder.typeof(single(0));
ARGS_1_1.PB_derating_FR = coder.typeof(single(0));
ARGS_1_1.INV_T_derating_full_T = coder.typeof(single(0));
ARGS_1_1.INV_T_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.IGBT_T_derating_full_T = coder.typeof(single(0));
ARGS_1_1.IGBT_T_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.MT_derating_full_T = coder.typeof(single(0));
ARGS_1_1.MT_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.BT_derating_full_T = coder.typeof(single(0));
ARGS_1_1.BT_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.VB_derating_full_T = coder.typeof(single(0));
ARGS_1_1.VB_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.IB_derating_full_T = coder.typeof(single(0));
ARGS_1_1.IB_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.VB_RG_derating_full_T = coder.typeof(single(0));
ARGS_1_1.VB_RG_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.IB_RG_derating_full_T = coder.typeof(single(0));
ARGS_1_1.IB_RG_derating_zero_T = coder.typeof(single(0));
ARGS_1_1.GS_RG_derating_zero = coder.typeof(single(0));
ARGS_1_1.GS_RG_derating_full = coder.typeof(single(0));
ARGS{1}{1} = coder.typeof(ARGS_1_1);
ARGS{1}{1} = coder.cstructname(ARGS{1}{1},'pVCU_struct');
ARGS_1_2 = struct;
ARGS_1_2.TH_RAW = coder.typeof(single(0));
ARGS_1_2.ST_RAW = coder.typeof(single(0));
ARGS_1_2.VB_RAW = coder.typeof(single(0));
ARGS_1_2.WM_RAW = coder.typeof(single(0),[1 4]);
ARGS_1_2.GS_RAW = coder.typeof(single(0));
ARGS_1_2.AV_RAW = coder.typeof(single(0),[1 3]);
ARGS_1_2.IB_RAW = coder.typeof(single(0));
ARGS_1_2.MT_RAW = coder.typeof(single(0));
ARGS_1_2.IGBT_T_RAW = coder.typeof(single(0));
ARGS_1_2.INV_T_RAW = coder.typeof(single(0));
ARGS_1_2.MC_RAW = coder.typeof(single(0));
ARGS_1_2.IC_RAW = coder.typeof(single(0));
ARGS_1_2.BT_RAW = coder.typeof(single(0));
ARGS_1_2.TO_RAW = coder.typeof(single(0),[1 4]);
ARGS{1}{2} = coder.typeof(ARGS_1_2);
ARGS{1}{2} = coder.cstructname(ARGS{1}{2},'xVCU_struct');
ARGS_1_3 = struct;
ARGS_1_3.TH = coder.typeof(single(0));
ARGS_1_3.TH_PO = coder.typeof(single(0));
ARGS_1_3.TH_RG = coder.typeof(single(0));
ARGS_1_3.ST = coder.typeof(single(0));
ARGS_1_3.VB = coder.typeof(single(0));
ARGS_1_3.WM = coder.typeof(single(0),[1 4]);
ARGS_1_3.GS = coder.typeof(single(0));
ARGS_1_3.AV = coder.typeof(single(0),[1 3]);
ARGS_1_3.IB = coder.typeof(single(0));
ARGS_1_3.MT = coder.typeof(single(0));
ARGS_1_3.IGBT_T = coder.typeof(single(0));
ARGS_1_3.INV_T = coder.typeof(single(0));
ARGS_1_3.MC = coder.typeof(single(0));
ARGS_1_3.IC = coder.typeof(single(0));
ARGS_1_3.BT = coder.typeof(single(0));
ARGS_1_3.TO = coder.typeof(single(0),[1 4]);
ARGS_1_3.PB = coder.typeof(single(0));
ARGS_1_3.TO_BL_PO = coder.typeof(single(0),[1 4]);
ARGS_1_3.TO_BL_RG = coder.typeof(single(0),[1 4]);
ARGS_1_3.TORQUE_OUT = coder.typeof(single(0),[1 4]);
ARGS{1}{3} = coder.typeof(ARGS_1_3);
ARGS{1}{3} = coder.cstructname(ARGS{1}{3},'yVCU_struct');

%% Invoke MATLAB Coder.
codegen -config cfg -singleC -I C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Controllers vcu_step -args ARGS{1}

