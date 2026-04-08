%% initialize data classes
p = pVCU_master();
x = xVCU_master();
y = yVCU_master(p);

%% convert to struct
p = class2struct(p);
x = class2struct(x);
y = class2struct(y);

%% generate vcu.h data
struct2c_typedef(p, "generated_c_files/pVCU_struct.txt")
struct2c_typedef(x, "generated_c_files/xVCU_struct.txt")
struct2c_typedef(y, "generated_c_files/yVCU_struct.txt")

%% generate init_#VCU data
struct2c(p, "generated_c_files/pVCU_init.txt")
struct2c(x, "generated_c_files/xVCU_init.txt")
struct2c(y, "generated_c_files/yVCU_init.txt")

%% combine into vcu_init.c
create_c_header(["xVCU", "yVCU", "pVCU"], ...
    ["generated_c_files/xVCU_struct.txt", "generated_c_files/yVCU_struct.txt", "generated_c_files/pVCU_struct.txt"], ...
    "generated_c_files/vcu.h")

%% combine into vcu.h
create_c_init(["xVCU", "yVCU", "pVCU"], ...
    ["generated_c_files/xVCU_init.txt", "generated_c_files/yVCU_init.txt", "generated_c_files/pVCU_init.txt"], ...
    "generated_c_files/vcu_init.c")