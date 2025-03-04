%% Function Description
% This function takes a time-indexed matrix X and populates the fields in
% the struct x with the data at row i. The first column of X is the time,
% and all the remaining columns are the data.
%
% Input      :  X - Matrix of all data for all time Size: [n m]
%               x - struct of data at time step i-1
%               i - the index corresponding to the current time step
% 
% Return     :  f - struct of data at time step i

function x = fill_x(X, x, i)
    x.TH_RAW = X(i,2);
    x.ST_RAW = X(i,3);
    x.VB_RAW = X(i,4);
    x.WT_RAW = X(i,5:6);
    x.WM_RAW = X(i,7:8);
    x.GS_RAW = X(i,9);
    x.AV_RAW = X(i,10:12);
    x.IB_RAW = X(i,13);
    x.MT_RAW = X(i,14);
    x.CT_RAW = X(i,15);
    x.IT_RAW = X(i,16);
    x.MC_RAW = X(i,17);
    x.IC_RAW = X(i,18);
    x.BT_RAW = X(i,19);
    x.AG_RAW = X(i,20:22);
    x.TO_RAW = X(i,23:24);
    x.VT_DB_RAW = X(i,25);
    x.TV_PP_RAW = X(i,26);
    x.TC_TR_RAW = X(i,27);
    x.VS_MAX_SR_RAW = X(i,28);
end