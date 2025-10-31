function ds = Vehicle_dsV2(t, s, tauRaw, CCSA, P, model)
    CCSA(floor(t)) = 0;
ds = vehicle_ds(t, s, tauRaw, CCSA, P, model);
end 

