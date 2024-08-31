function ds = compute_ds(t, s, tau, varCAR)
    [FxFR_MAX, zFR, dzFR] = traction_model(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model(s, tau, FxFR_MAX, zFR, dzFR, varCAR);
    [dVoc, dVb, dAh] = powertrain_model(s, tau, varCAR);

    ds = [ddx; s(1); ddz; s(3); ddo; s(5); dw; dVoc; dVb; dAh];

    disp(ds)
end