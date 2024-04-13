== createTrack.m ==
Input: path to .svg track to convert, scaling length
Output: plot of the the track, list of distance and angle instructions for constructing track

== to use ==
> download/install Inkscape
> use pen tool ([B], left toolbar) to create a track using only straight lines; avoid perfectly horizontal or vertical lines
> use pen tool to create a single line segment of a known real-life length (for scale)
> using 'layers and objects' ([ctrl+shift+L], Object > Layers and objects), delete all layers, name the track "track" and the scaling line "scale"
> edit 'svgPath' to path to .svg file, including ".svg"
> edit 'scaleReal' to real-life length of scale line segment
> run program, outputs a list of instructions for distance and absolute angle from one point to next