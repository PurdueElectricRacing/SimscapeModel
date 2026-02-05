function [plot_array] = plotSegments(point_array, segments)

    plot_array = zeros(1,size(point_array,2));

    for i = 1:size(segments,1)
        plot_array(3*i-2,:) = point_array(segments(i,1),:);
        plot_array(3*i-1,:) = point_array(segments(i,2),:);
        plot_array(3*i,:) = NaN;
    end

end