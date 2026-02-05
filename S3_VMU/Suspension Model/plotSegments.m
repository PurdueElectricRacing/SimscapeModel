% Inputs
%   point_array    array of points (2D or 3D), one point per row
%   segments       array of connections. one segment per row, specified as index of point array
%                       [start1, end1; start2, end2; startN, endN]
% Outputs
%   plot_array     single array containing segments (one point per row) divided up by NaN,
%                       can be plotted using plot(plot_array(1,:), plot_array(2,:))
function [plot_array] = plotSegments(point_array, segments)

    plot_array = zeros(1,size(point_array,2));

    for i = 1:size(segments,1)
        plot_array(3*i-2,:) = point_array(segments(i,1),:);
        plot_array(3*i-1,:) = point_array(segments(i,2),:);
        plot_array(3*i,:) = NaN;
    end

end