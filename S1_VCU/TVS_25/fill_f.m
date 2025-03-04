%% Function Description
% This function takes a time-indexed matrix F and populates the fields in
% the struct f with the data at row i. The first column of F is the time,
% and all the remaining columns are the data.
%
% Input      :  F - Matrix of all flags for all time Size: [n m]
%               f - struct of flags at time step i-1
%               i - the index corresponding to the current time step
% 
% Return     :  f - struct of flags at time step i

function f = fill_f(F, f, i)
    f.CS_SFLAG = F(i,2);
    f.TB_SFLAG = F(i,3);
    f.SS_SFLAG = F(i,4);
    f.WT_SFLAG = F(i,5);
    f.IV_SFLAG = F(i,6);
    f.BT_SFLAG = F(i,7);
    f.MT_SFLAG = F(i,8);
    f.CO_SFLAG = F(i,9);
    f.MO_SFLAG = F(i,10);
    f.SS_FFLAG = F(i,11);
    f.AV_FFLAG = F(i,12);
    f.GS_FFLAG = F(i,13);
    f.VCU_PFLAG = F(i,14);
    f.VCU_CFLAG = F(i,15);
end