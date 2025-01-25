% A direct translation of the simulink model:
% Torque_Vectoring_2WD_NO_FILTER_NO_REGEN

realt.mT_mcT_bT_bI = [0,0,0,0];
realt.r_EQUAL = 0;
realt.ang_vel = [1, 1, 1];
realt.vel_gs = 15;
realt.phi = 0;
realt.dphi = 0;
realt.TVS_I = 0;
realt.TVS_P = 0;
realt.T_max = 0;
realt.r_TVS = [0, 0]

realt = get_t_max(varController_Master_TVS,realt)
r_TVS = get_TVS(varController_Master_TVS, realt, t_max)

% this is part of get_max_T
function realt = get_t_max(model, realt)

    realt.mT_mcT_bT_bI = clip(realt.mT_mcT_bT_bI, model.mT_mcT_bT_bI_maxlow, model.mT_mcT_bT_bI_maxupp);

    minT_safety = min(((realt.mT_mcT_bT_bI+model.sys_bias).*model.sys_gain) + model.add_gain);

    min_saturation_out = clip(minT_safety, model.rb(1), model.rb(2));

    realt.T_max = clip(realt.r_EQUAL, 0, min_saturation_out);
end

% this is get_TV
function realt = get_TVS(model, realt, powerlimit)
    phi_sat = clip(realt.phi, -130, 130);
 
    yaw_ref = interp2(model.distance,model.velocity,model.yaw_table,phi_sat,realt.vel_gs);

    raw_dR = (-(realt.ang_vel(3)))+((yaw_ref).*realt.TVS_I).*realt.TVS_P.*model.ht(2);    
    
    lo = (powerlimit.*model.r_power_sat).*-1; 
    up = (powerlimit.*model.r_power_sat);
    e = clip(raw_dR, lo, up); 

    function_inp_u = e.*(abs(phi_sat) > realt.dphi);

    if function_inp_u > 0
        realt.r_TVS = [powerlimit(1) powerlimit(1)-abs(function_inp_u)];
    else
        realt.r_TVS = [powerlimit(1)-abs(function_inp_u) powerlimit(1)];
    end
end
                

