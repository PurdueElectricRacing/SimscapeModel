%% Constant Speed (CS) controller (for skidpad)
% this function sets the desired speed and torque proportional to pedal
% position, then adjusts inner and outer wheel speeds based on steering
% angle
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of CS processed controller data at time t-1
% 
% Return     :  y - struct of CS processed controller data at time t

function y = get_CS(p,y)
    centerline_speed = y.TH_CF*max_speed; % calculate velocity of centerline of vehicle proportional to tire
    toe = sign(y.ST_CF).*abs(polyval(model.p, [-y.ST_CF;y.ST_CF])) + model.st(1:2); % calculate toe for front tires only [rad]
    turn_radius = mean(p.wb ./ tan(toe) + [-p.ht/2; p.ht/2]); % mean turning radius of front wheels [m]
    yaw_rate = y.GS_CF / turn_radius; % right turn is positive [rad/s]
    groundspeed = centerline_speed + [y.yaw_rate * p.ht/2; y.yaw_rate * p.ht/2]; % ideal groundspeed of rear wheels
    y.WM_VS = groundspeed / p.r * p.gr; % convert groundspeed into motorshaft angular velocity 
end