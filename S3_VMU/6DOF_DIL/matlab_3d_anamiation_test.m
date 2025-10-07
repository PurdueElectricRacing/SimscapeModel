%% setup
world = sim3d.World(Output=@output,Update=@update);

box = sim3d.Actor(ActorName='Box');
createShape(box, 'box', [1 1 1])
box.Color = [1 0 1];
add(world, box)

box.Rotation = [0 0 0];
box.Translation = [0 0 0];
box.Scale = [1 1 1];

viewport = createViewport(world,Translation=[-4.5 0 1]);

%% run
sampletime = 0.02;
stoptime = inf;
run(world,sampletime,stoptime)

%% functions
