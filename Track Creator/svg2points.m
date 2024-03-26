function [scale, trackXY] = svg2points(svgPath)
%scg2points Takes an SVG as input at returns:
% [length of "scale" path, array of points in "track" path]
%   Detailed explanation goes here

% Read File
rawData = readstruct(svgPath,FileType="xml").path;

% Split into scale and track
scaleStr = rawData(arrayfun(@(path)(path.inkscape_labelAttribute=="scale"),rawData)).dAttribute;
trackStr = rawData(arrayfun(@(path)(path.inkscape_labelAttribute=="track"),rawData)).dAttribute;

% get scale
split1 = split(scaleStr," "); % split into points seperated by commas
split2 = split(split1(2:end),","); % remove head and split points into x, y arrays
scaleXY = str2double(split2); % convert to double
scale = norm(scaleXY(1,:)-scaleXY(2,:)); % length of scale path

% get track points
split1 = split(trackStr," "); % split into points seperated by commas
split2 = split(split1(2:end),","); % remove head and split points into x, y arrays
trackXYraw = str2double(split2); % convert to double
trackXY = trackXYraw - trackXYraw(1,:); % move track so first point is (0,0)

end