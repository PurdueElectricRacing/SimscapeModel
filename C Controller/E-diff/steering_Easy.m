velocity = (0:0.2:18)';
velocity = velocity(:, ones(126,1));
velocity = velocity(:);

steer = (-(pi/6):0.0116:(pi/6))';
steer = (steer(:, ones(126,1)))';
steer = steer(:);

L = 1.574;
W = 1.269;

diff = (W/L) .* velocity .* tan(steer);

scatter3(velocity, steer, diff)
xlabel('CoG Velocity (m/s)')
ylabel('Front Tires Average Steering Angle (rad)')
zlabel('Target Velocity Difference (m/s)')