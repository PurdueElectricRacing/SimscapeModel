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
    f.VCU_CFLAG = F(i, 15);
end