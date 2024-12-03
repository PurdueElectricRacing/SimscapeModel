function [index_small,index_all, v_error, d_error, psi_error, v_cog, r_ref, yaw, x_ref, y_ref, yaw_ref, omega, p_error,Vnow, Fz, ahead, di_now] = ref_gen(index_small,index_all, psi, Vg, yaw, pos, omega, Fz, ahead, driver, di_prev, sim, track)
%% Extract Data
num_elem = length(track.selected_track(:,2));

if index_all+driver.vision.dIndex <= num_elem
    Y_all = track.selected_track(index_all:index_all+driver.vision.dIndex,2);
    X_all = track.selected_track(index_all:index_all+driver.vision.dIndex,3);
else
    Y_all = track.selected_track(index_all:index_all+driver.vision.dIndex,2);
    X_all = track.selected_track(index_all:index_all+driver.vision.dIndex,3);
end

Vmax_now = track.selected_maxvm(index_small,3);
num_elem = length(track.selected_maxvm(:,1));

if num_elem > index_small
    Vmax_next = track.selected_maxvm(index_small+1,3);
    d_next = track.selected_maxvm(index_small+1,1);
else
    Vmax_next = Vmax_now;
    d_next = 100;
end

%% Determine Reference Point
d_error_all = sqrt((Y_all - pos(2)).^2 + (X_all - pos(1)).^2);
[min_d, min_index] = min(d_error_all);
index_all = index_all + min_index - 1;

%% Aquire Reference Values
y_ref = track.selected_track(index_all, 2);
x_ref = track.selected_track(index_all, 3);
y_ref_next = track.selected_track(index_all+5, 2);
x_ref_next = track.selected_track(index_all+5, 3);
r_ref = track.selected_track(index_all, 4);
turn_ref = track.selected_track(index_all, 5);
psi_ref = track.selected_track(index_all, 8);
di_now = track.selected_track(index_all, 9);

%% Velocity Error [bogus]
v_cog = sqrt((Vg(1)^2) + (Vg(2)^2));

if ahead
    di = (di_now*driver.vision.dx) + d_next;
else
    di = di_now*driver.vision.dx;
end

det = v_cog^2 + (2*driver.control.axb*di);

if det < 0
    Vnext = 0;
else
    Vnext = sqrt(det);
end

% straight driving simulation
% d_now = pos(1);
% d_later = selected_maxvm(index_small,4);
% dS = d_now - d_later;
% det = v_cog^2 - (2*axb*dS);
% 
% if det > 0
%     Vnext = sqrt(det);
% else
%     Vnext = 0;
% end

increment = 0;

% if (abs(Vmax_next - Vnext) < 0.1) && (Vmax_now > Vmax_next) && (~ahead)
%     Vnow = Vmax_next;
%     index_small = index_small + 1;
%     ahead = 1;
%     increment = 1;
if ((di_now - di_prev) > 0) && ~ahead
    Vnow = Vmax_next;
    index_small = index_small + 1;
else
    Vnow = Vmax_now;
end

if ((di_now - di_prev) > 0) && ~increment
    ahead = 0;
end

if (Vnext + 0.5 < Vnow) && (track.selected_maxvm(index_small,1) ~= 40)
    Vnow = 50;
end

if Vnow > 14
    v_error = Vnow - v_cog; % - 2
else
    v_error = Vnow - v_cog; % - 1
end

%% Turning Radius Error [good]
r_IC = abs(v_cog / yaw);
r_error = turn_ref *  ((1 / r_ref) - (1 / r_IC));

if r_ref == inf
    yaw_ref = 0;
else
    yaw_ref = turn_ref * v_cog / r_ref;
end

%% Angle Error [good]
sign_steer = 1;

if (abs(psi - psi_ref) > pi) && (sign(psi) ~= sign(psi_ref))
    if psi < 0
        sign_steer = -1;
    end
elseif (psi > psi_ref)
    sign_steer = -1;   
end

if abs(psi_ref - psi) < pi
    psi_error = sign_steer * abs(psi_ref - psi) / sim.constant.deg2rad;
else
    psi_error = sign_steer * ((pi - abs(psi_ref)) + (pi - abs(psi))) / sim.constant.deg2rad;
end

%% Distance Error [yikes]
% Determine Vehicle Quadrant
if (pos(2) - y_ref) > driver.vision.q_thresh
   if (pos(1) - x_ref) > driver.vision.q_thresh
       Qc = 5;
   elseif (pos(1) - x_ref) < -driver.vision.q_thresh
       Qc = 11;
   else
       Qc = 4;
   end
elseif (pos(2) - y_ref) < -driver.vision.q_thresh
   if (pos(1) - x_ref) > driver.vision.q_thresh
       Qc = 7;
   elseif (pos(1) - x_ref) < -driver.vision.q_thresh
       Qc = 9;
   else
       Qc = 8;
   end
else
   if (pos(1) - x_ref) > driver.vision.q_thresh
       Qc = 6;
   elseif (pos(1) - x_ref) < -driver.vision.q_thresh
       Qc = 10;
   else
       Qc = 0;
   end
end

% Determine Next Reference Point Quadrant
if y_ref_next > y_ref
   if x_ref_next > x_ref
       Qn = 5;
   elseif x_ref_next < x_ref
       Qn = 11;
   else
       Qn = 4;
   end
elseif y_ref_next < y_ref
   if x_ref_next > x_ref
       Qn = 7;
   elseif x_ref_next < x_ref
       Qn = 9;
   else
       Qn = 8;
   end
else
   if x_ref_next > x_ref
       Qn = 6;
   elseif x_ref_next < x_ref
       Qn = 10;
   else
       Qn = 0;
   end
end

% Determine Sign for Distance Error
if Qc == 0
   sign_distance = 0;
elseif (abs(x_ref_next - x_ref) == abs(pos(1) - x_ref)) && (abs(y_ref_next - y_ref) == abs(pos(2) - y_ref))
   sign_distance = 0;
elseif ((Qc ~= Qn) && (driver.vision.indicies(Qc+4) ~= Qn))
    if (driver.vision.indicies(Qc+1) == driver.vision.indicies(Qn)) || (driver.vision.indicies(Qc+2) == driver.vision.indicies(Qn)) || (driver.vision.indicies(Qc+3) == driver.vision.indicies(Qn))
        sign_distance = -1;
    else
        sign_distance = 1;
    end
else
    if driver.vision.indicies(Qc) == 1 || driver.vision.indicies(Qc) == 3
        y_axis = y_ref;
    elseif driver.vision.indicies(Qc) == 4
        y_axis = y_ref + 1;
    else
        y_axis = y_ref - 1;
    end
    
    if driver.vision.indicies(Qc) == 2 || driver.vision.indicies(Qc) == 4
        x_axis = x_ref;
    elseif driver.vision.indicies(Qc) == 1
        x_axis = x_ref + 1;
    else
        x_axis = x_ref - 1;
    end
    
    axis_coordiantes = [y_axis, x_axis];
    ref_coordiantes = [y_ref, x_ref];
    next_ref_coordinates = [y_ref_next, x_ref_next];
    vehicle_coordinates = [pos(2), pos(1)];
    
    ref_vec = axis_coordiantes - ref_coordiantes;
    veh_vec = vehicle_coordinates - ref_coordiantes;
    next_ref = next_ref_coordinates - ref_coordiantes;
    
    theta_veh_ref = acos(dot(ref_vec, veh_vec) / (norm(ref_vec)*norm(veh_vec)));
    theta_next_ref = acos(dot(ref_vec, next_ref) / (norm(ref_vec)*norm(next_ref)));
    
    if theta_veh_ref < theta_next_ref
        sign_distance = 1;
    else
        sign_distance = -1;
    end
end

d_error = sign_distance * min_d;

%% Combined Purtubation Error
if (sign_distance~=sign(psi_error)) && (d_error~=0)
    p_error = d_error;
else
    p_error = psi_error;
end

end
