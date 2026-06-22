clear; clc

%% Prepare for build
fprintf("preparing for codegen\n")

% set current folder to folder containing this script, so we know where all
% files are located
currentloc = matlab.desktop.editor.getActive().Filename;
cd(fileparts(currentloc))

% add "controllers" folder to path to be able to call "vcu_step.m"\
addpath(fullfile("..","Controllers"))
addpath(fullfile("..","Controllers","pVCU_tables"))

% run #VCU_master scripts to create classes
p = pVCU_master();
x = xVCU_master();
y = yVCU_master(p);

% convert them to structs
p = class2struct(p);
x = class2struct(x);
y = class2struct(y);

% generate vcu.h data
struct2c_typedef(p, "generated_text_files/pVCU_struct.txt")
struct2c_typedef(x, "generated_text_files/xVCU_struct.txt")
struct2c_typedef(y, "generated_text_files/yVCU_struct.txt")

% generate init_#VCU data
struct2c(p, "generated_text_files/pVCU_init.txt")
struct2c(x, "generated_text_files/xVCU_init.txt")
struct2c(y, "generated_text_files/yVCU_init.txt")

% add codegen folder to path
addpath(fullfile("2024a"))

%% Codegen
fprintf("running codegen\n")

% run codegen.m from the 2024a folder, then move back to original folder
cd(fullfile("2024a"))
codegen_script
cd(fullfile(".."))

%% Output
fprintf("outpuing files into BUILD_OUTPUT\n")

% copy codegen file to BUILD_OUTPUT folder
copyfile(fullfile("2024a","codegen","lib","vcu_step","vcu_step.c"), fullfile("BUILD_OUTPUT"))

% combine into vcu.h data vcu.h
create_c_init(["xVCU", "yVCU", "pVCU"], ...
    '#include "vcu.h"\n\n', ...
    ["generated_text_files/xVCU_init.txt", "generated_text_files/yVCU_init.txt", "generated_text_files/pVCU_init.txt"], ...
    "BUILD_OUTPUT/vcu_init.c")

% combine init_#VCU data into vcu_init.c
create_c_header(["xVCU", "yVCU", "pVCU"], ...
    "\n\n// VCU struct initialization functions\nxVCU_struct init_xVCU(void);\nyVCU_struct init_yVCU(void);\npVCU_struct init_pVCU(void);\n\nvoid vcu_step(const pVCU_struct *p, const xVCU_struct *x, yVCU_struct *y);", ...
    ["generated_text_files/xVCU_struct.txt", "generated_text_files/yVCU_struct.txt", "generated_text_files/pVCU_struct.txt"], ...
    "BUILD_OUTPUT/vcu.h")

%% edit vcu_step.c inlcudes
% remove #include "vcu_step.h" and #include "vcu_step_types.h",
% replace with #include "vcu.h"
lines = readlines(fullfile("BUILD_OUTPUT","vcu_step.c"));
rep1 = find(lines == '#include "vcu_step.h"', 1, "first");
lines(rep1) = '#include "vcu.h"';
rep2 = find(lines == '#include "vcu_step_types.h"', 1, "first");
lines(rep2) = "";

writelines(lines, fullfile("BUILD_OUTPUT","vcu_step.c"))
clear lines

%% copy into debian for building
fprintf("copying files into wsl\n")
command = 'powershell Copy-Item -Path "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Codegen\BUILD_OUTPUT\vcu_step.c" -Destination "\\wsl.localhost\Debian\home\tak\firmware\source\torque_vector\vcu\vcu_step.c"';
system(command);

command = 'powershell Copy-Item -Path "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Codegen\BUILD_OUTPUT\vcu_init.c" -Destination "\\wsl.localhost\Debian\home\tak\firmware\source\torque_vector\vcu\vcu_init.c"';
system(command);

command = 'powershell Copy-Item -Path "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Codegen\BUILD_OUTPUT\vcu.h" -Destination "\\wsl.localhost\Debian\home\tak\firmware\source\torque_vector\vcu\vcu.h"';
system(command);

%% Run build
fprintf("building...")
command = 'wsl --distribution debian bash -c "cd /home/tak/firmware && python3 per_build.py"';
result = system(command);
