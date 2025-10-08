%% setup
% world
world = sim3d.World(Output=@output,Update=@update);

% actors
box = sim3d.Actor(ActorName='Box', Mobility=sim3d.utils.MobilityTypes.Movable);
createShape(box, 'box', [1 1 1]);
box.Color = [1 0 1];
add(world, box)

box.Rotation = [0 0 0];
box.Translation = [0 0 0];
box.Scale = [1 1 1];

% viewport
% viewport = createViewport(world,Translation=[-4.5 0 1]);
viewpoint = createViewpoint(world,Translation=[-4.5 0 1]);


% joystick
world.UserData.joystick = sim3d.io.Joystick();

%% run
sampletime = 0.02;
stoptime = inf;
run(world,sampletime,stoptime)

%% functions
function [] = output(world)
    world.Actors.Box.Translation(1) = 0.01 + world.Actors.Box.Translation(1) * world.UserData.joystick.axis(1);
end