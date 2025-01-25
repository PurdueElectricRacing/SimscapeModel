function x = fill_x(X, x, i)
    x.TH_RAW = X(i,2);
    x.ST_RAW = X(i,3);
    x.VB_RAW = X(i,4);
    x.WT_RAW = X(i,5:6);
    x.GS_RAW = X(i,7);
    x.AV_RAW = X(i,8:10);
    x.IB_RAW = X(i,11);
    x.MT_RAW = X(i,12);
    x.CT_RAW = X(i,13);
    x.BT_RAW = X(i,14);
    x.AG_RAW = X(i,15:17);
    x.TO_RAW = X(i,18:19);
    x.DB_RAW = X(i,20);
    x.PI_RAW = X(i,21);
    x.PP_RAW = X(i,22);
end