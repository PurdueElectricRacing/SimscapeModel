% load data
file = "may3_part3/out_003.csv";
[data, header] = load_data(file, "all");
data = fillmissing(fillmissing(data, "previous"), "next"); % fill all NaN values in data

%% Get column index in data for each xVCU field
VCU_MODE_REQ_col = find(all(header == ["VCAN";"DASHBOARD";"vcu_driver_request";"vcu_mode"], 1));
REGEN_EN_col =     find(all(header == ["VCAN"; "TORQUE_VECTOR"; "vcu_settings"; "is_regen_enabled"], 1));
THROT_RAW_col =    find(all(header == ["VCAN"; "DASHBOARD"; "pedals"; "throttle"], 1));
BRAKE_RAW_col =    find(all(header == ["VCAN"; "DASHBOARD"; "pedals"; "brake"], 1));
REGEN_RAW_col =    find(all(header == ["VCAN"; "DASHBOARD"; "pedals"; "regen"], 1));
ST_RAW_col =       find(all(header == ["VCAN"; "DASHBOARD"; "steering_angle"; "angle"], 1));
VB_RAW_col =       find(all(header == ["VCAN"; "A_BOX"; "pack_stats"; "pack_voltage"], 1));
WM_RAW_col =      [find(all(header == ["VCAN"; "MAIN_MODULE"; "wheel_speeds"; "front_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "wheel_speeds"; "front_right"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "wheel_speeds"; "rear_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "wheel_speeds"; "rear_right"], 1))];
% GS_RAW_col =     find(all(header == asdf, 1)); not tracked
% AV_RAW_col =     find(all(header == asdf, 1)); not tracked
IB_RAW_col =       find(all(header == ["VCAN"; "A_BOX"; "pack_stats"; "pack_current"], 1));
MT_RAW_col =      [find(all(header == ["VCAN"; "MAIN_MODULE"; "motor_temps"; "front_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "motor_temps"; "front_right"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "motor_temps"; "rear_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "motor_temps"; "rear_right"], 1))];
IGBT_T_RAW_col =  [find(all(header == ["VCAN"; "MAIN_MODULE"; "igbt_temps"; "front_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "igbt_temps"; "front_right"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "igbt_temps"; "rear_left"], 1)), ...
                   find(all(header == ["VCAN"; "MAIN_MODULE"; "igbt_temps"; "rear_right"], 1))];
% INV_T_RAW_col =    find(all(header == asdf, 1)); not even passed in
% OV_MOT_col = find(all(header == asdf, 1));
% OV_INV_col = find(all(header == asdf, 1));
% BT_RAW_col = find(all(header == asdf, 1)); not tracked
% TO_RAW_col = find(all(header == asdf, 1)); 
LAT_GAIN_col = find(all(header == ["VCAN"; "TORQUE_VECTOR"; "vcu_settings"; "lateral_gain"], 1));
LONG_GAIN_col = find(all(header == ["VCAN"; "TORQUE_VECTOR"; "vcu_settings"; "longitudinal_gain"], 1));
EBB_col = find(all(header == ["VCAN"; "TORQUE_VECTOR"; "vcu_settings"; "electronic_brake_bias"], 1));
% RG_FR_split_RAW_col = find(all(header == asdf, 1));
% SK_FR_split_RAW_col = find(all(header == asdf, 1));
% SK_LR_gain_RAW_col = find(all(header == asdf, 1));
% AX_FR_split_RAW_col = find(all(header == asdf, 1));
% AX_LR_control_force_RAW_col = find(all(header == asdf, 1));
% TS_FR_split_RAW_col = find(all(header == asdf, 1));
% TS_LR_split_RAW_col = find(all(header == asdf, 1));

%% load data into variables
VCU_MODE_REQ_data = data(:, VCU_MODE_REQ_col);
REGEN_EN_data = data(:, REGEN_EN_col);
THROT_RAW_data = data(:, THROT_RAW_col);
BRAKE_RAW_data = data(:, BRAKE_RAW_col);
REGEN_RAW_data = data(:, REGEN_RAW_col);
ST_RAW_data = data(:, ST_RAW_col);
VB_RAW_data = data(:, VB_RAW_col);
WM_RAW_data = data(:, WM_RAW_col);
% GS_RAW_col
% AV_RAW_col
IB_RAW_data = data(:, IB_RAW_col);
MT_RAW_data = data(:, MT_RAW_col);
IGBT_T_data = data(:, IGBT_T_RAW_col);
% INV_T_RAW_col 
% OV_MOT_col 
% OV_INV_col 
% BT_RAW_col 
% TO_RAW_col 
LAT_GAIN_data = data(:, LAT_GAIN_col );
LONG_GAIN_data = data(:, LONG_GAIN_col );
EBB_data = data(:, EBB_col );

clear data % get rid of huge data variable

%% Run vcu_step with inputs
% setup structs
p = pVCU_master();
x = xVCU_master();
y = yVCU_master(p);

for i = 1:length(VCU_MODE_REQ_col)

    x.VCU_MODE_REQ = VCU_MODE_REQ_data(i);
    x.REGEN_EN = REGEN_EN_data(i);
    x.THROT_RAW = THROT_RAW_data(i);
    x.BRAKE_RAW = BRAKE_RAW_data(i);
    x.REGEN_RAW = REGEN_RAW_data(i);
    x.ST_RAW = ST_RAW_data(i);
    x.VB_RAW = VB_RAW_data(i);
    x.WM_RAW = WM_RAW_data(i, :);
    % x.GS_RAW = ;
    % x.AV_RAW = ;
    x.IB_RAW = IB_RAW_data(i);
    x.MT_RAW = max(MT_RAW_data(i,:));
    x.IGBT_T_RAW = max(IGBT_T_data(i,:));
    % x.INV_T_RAW = ;
    % x.OV_MOT = ;
    % x.OV_INV = ;
    % x.BT_RAW = ;
    % x.TO_RAW = ;
    x.RG_FR_split_RAW = EBB_data(i);
    x.SK_FR_split_RAW = LONG_GAIN_data(i);
    x.SK_LR_gain_RAW = LAT_GAIN_data(i);
    x.AX_FR_split_RAW = LONG_GAIN_data(i);
    x.AX_LR_control_force_RAW = LAT_GAIN_data(i);
    x.TS_FR_split_RAW = LONG_GAIN_data(i);
    x.TS_LR_split_RAW = LAT_GAIN_data(i);

    y = vcu_step(p, x, y);
    1;
end
