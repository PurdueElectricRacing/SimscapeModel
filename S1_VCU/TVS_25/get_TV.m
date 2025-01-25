function y = get_TV(p,y)
    phi_sat = clip(y.phi, -130, 130);
    yaw_ref = interp2(p.TV_phi_brkpt, p.TV_vel_brkpt, p.TV_yaw_table, phi_sat, y.vel_gs);
    raw_dR = 

end