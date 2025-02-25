function [accel] = polyfit_filter(time, speed, numPoints, degree)
    %POLYFIT_FILTER Summary of this function goes here
    %   Detailed explanation goes here
    
    accel = zeros(size(time));
    for i = numPoints+1:length(time)
        poly = polyfit(time(i-numPoints:i), speed(i-numPoints:i), degree);
        der_poly = polyder(poly);
        accel(i) = polyval(der_poly, time(i));
    end
end