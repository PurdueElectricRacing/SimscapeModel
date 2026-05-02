clear; clc

%% Prepare for build
fprintf("preparing for codegen\n")

% set current folder to folder containing this script, so we know where all
% files are located
currentloc = matlab.desktop.editor.getActive().Filename;
cd(fileparts(currentloc))

% add "controllers" folder to path to be able to call "vcu_step.m"\
addpath(fullfile("..","Controllers"))

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
