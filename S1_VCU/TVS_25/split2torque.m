%% Function Description
% This function computes the four individual torques given a Front:Rear
% torque split and a Left:Right torque split
% 
% 
% 
%
% Input      :  FR - front:rear torque split; 1 = 100% front, 0 = 100% rear
%               LR - left:right torque split; 1 = 100% left, 0 = 100% right
% 
% Return     :  torques - individual torques, highest torque wheel is 1,
%                   all others are equal or lower
%               Size: [1 4] Order: [FL FR RL RR]


function torques = split2torque(FR, LR)
    m = max([FR*LR, FR*(1-LR), (1-FR)*LR, (1-FR)*(1-LR)]);
    torques = [FR*LR, FR*(1-LR), (1-FR)*LR, (1-FR)*(1-LR)] ./ m;
end