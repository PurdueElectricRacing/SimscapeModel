classdef pVCU_master < handle
    % Constant properties of the car and controller
    properties
        % Physical car properties
        r;  % tire radius Unit: [m] Size: [1 1]
        ht; % half-track Unit: [m] Size [1 2] Order: [front rear]
        wb; % length of wheelbase Unit: [m] Size[1]
        
        gr; % gear ratio: tire speed * gr = motor shaft speed Unit: [unitless] Size: [1 1]

        % Baseline (get_BL) parameters
        MAX_TORQUE; % maximum torque allowed


    end

    methods
        function f = pVCU_master()

        end
    end
end