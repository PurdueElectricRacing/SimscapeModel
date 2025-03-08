%% reset data classes
p = pVCU_Master();
f = fVCU_Master();
x = xVCU_Master();
y = yVCU_Master(p);

p = class2struct(p);
f = class2struct(f);
x = class2struct(x);
y = class2struct(y);

%% set x and f
x.TH_RAW = 0.5;
x.ST_RAW = 25;
x.VB_RAW = 470;
x.WT_RAW = [10, 11];
x.WM_RAW = [113.4, 124.74];
x.GS_RAW = 2;
x.AV_RAW = [0, 0, 9.81];
x.IB_RAW = 10;
x.MT_RAW = 31;
x.CT_RAW = 37;
x.IT_RAW = 41;
x.MC_RAW = 0;
x.IC_RAW = 0;
x.BT_RAW = 31;
x.AG_RAW = [2, 1, 0];
x.TO_RAW = [15, 16];
x.VT_DB_RAW = 0;
x.TV_PP_RAW = 0.4;
x.TC_TR_RAW = 0.5;
x.VS_MAX_SR_RAW = 0.1;

f.CS_SFLAG = 0;
f.TB_SFLAG = 0;
f.SS_SFLAG = 0;
f.WT_SFLAG = 0;
f.IV_SFLAG = 0;
f.BT_SFLAG = 0;
f.IAC_SFLAG = 0;
f.IAT_SFLAG = 0;
f.IBC_SFLAG = 0;
f.IBT_SFLAG = 0;
f.SS_FFLAG = 1;
f.AV_FFLAG = 1;
f.GS_FFLAG = 3;
f.VCU_PFLAG = 2;
f.VCU_CFLAG = 2;

%% generate c code
path = "generated_c_files/vcu_pp_tester_c.txt";
fclose(fopen(path,"w")); % clear file
struct2c_setvales(class2struct(x),"x",path);
fid = fopen(path,"a"); fprintf(fid,"\n"); fclose(fid);
struct2c_setvales(class2struct(f),"f",path);

%% Run one step
y_new = vcu_step(p,f,x,y);