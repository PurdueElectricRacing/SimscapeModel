%% Function Description
% This function computes the torque vectoring torque control setpoint,
% which is sent to main. First, the angular velocity setpoint is computed.
% Next, the delta torque between the left and right tires is computed.
% Finally, the delta is applied depending on the sign of the delta.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of TV processed controller data at time t-1
% 
% Return     :  y - struct of TV processed controller data at time t

function y = get_TV(p, y)
    % compute yaw rate reference [rad/s]
    ST_TV = snip(y.ST_CF, p.TV_ST_lb, p.TV_ST_ub);
    GS_TV = snip(y.GS_CF, p.TV_GS_lb, p.TV_GS_ub);
    y.TV_AV_ref = interp2(p.TV_ST_brkpt, p.TV_GS_brkpt, p.TV_AV_table, ST_TV, GS_TV);
    
    % compute delta torque [Nm]
    raw_delta_torque = (y.TV_AV_ref * y.PI_CF - y.AV_CF(3)) * y.TV_PP_CF * p.ht(2);
    y.TV_delta_torque = snip(raw_delta_torque, -y.TO_PT(1)*p.MAX_r, y.TO_PT(1)*p.MAX_r);

    % compute individual torques [Nm]
    if y.TV_delta_torque > 0
        y.TO_VT = [y.TO_PT(1), y.TO_PT(1) - y.TV_delta_torque];
    else
        y.TO_VT = [y.TO_PT(1) + y.TV_delta_torque, y.TO_PT(1)];
    end
end