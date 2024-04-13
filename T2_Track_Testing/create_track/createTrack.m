%% Setup and Settings
clear
clc
svgPath = "test_path_plain.svg";
scaleReal = 20; % length of scale path in real life

%% Import and Process Data
[scaleSVG, trackXYrel] = svg2points(svgPath); % import data
trackXYrel = trackXYrel .* (scaleReal / scaleSVG); % scale data

% convert relative to absolute coordinates
trackXYabs = zeros(size(trackXYrel));
for point=2:size(trackXYrel,1)
    trackXYabs(point,:) = trackXYabs(point-1,:)+trackXYrel(point,:);
end

%% Create Instructions
distances = zeros(size(trackXYrel,1),1);
angles = zeros(size(trackXYrel,1),1);

for point=2:size(trackXYrel,1)
    distances(point) = norm(trackXYrel(point,:));
    angles(point) = atan2(trackXYrel(point,1), trackXYrel(point,2));
end
angles = angles*180/3.1415; % convert to degress

%% Plot Track
plot(trackXYabs(:,1),trackXYabs(:,2), Marker="o")
axis equal

%% Output angles and distance
for point = 1:size(angles)
    fprintf("Point: %2.0f  ||  distance: %4.1f  ||  angle: %3.0f\n",point,distances(point),angles(point))
end