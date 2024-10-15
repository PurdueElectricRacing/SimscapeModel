%% Optimize random steering angle and throttle with straight line
clear;
clc;
load Tracks\Tracks_Mat\acceleration.mat
% [Dr(slop) Ypos Xpos TurnRad TurnDr(L/R) InstCY InstCX yaw]

steerlimit = 180;
steerdeg = -1*steerlimit + (2*steerlimit) * rand(1,100);    % Steering angle in Degrees
thrtl = 1 * rand(1,100);                                    % Throttle depth 0 ~ 1

startpointXY = [0 0];   % Define start point
% error = 

