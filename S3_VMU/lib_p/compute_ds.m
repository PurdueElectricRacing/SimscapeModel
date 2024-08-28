function ds = compute_ds(t, s, tau, varCAR)
    [FxFR, zFR, dzFR] = traction_model(s, varCAR);
    varCAR.c = ppval(varCAR.ct, dzFR);

    [ddx, ddz, ddo] = compute_dd(s, FxFR, zFR, dzFR, varCAR);
    dw = (1/varCAR.Jw)*(tau - FxFr*varCAR.r);

    ds = [ddx; dx; ddz; dz; ddo; do; dw];
    

end