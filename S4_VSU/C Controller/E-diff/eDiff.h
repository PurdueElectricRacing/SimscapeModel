# include "stdint.h"

#define BUZZER_DURATION_MS 2500 // EV.10.5: 1-3s

#define ERROR_FALL_MS (5000)

/* LV I_SENSE CALC */
#define LV_GAIN         25
#define LV_R_SENSE_mOHM 4 
#define LV_MAX_ADC_RAW  4096
#define LV_ADC_V_IN_V   5

/* BRAKE LIGHT CONFIG */
#define BRAKE_LIGHT_ON_THRESHOLD 500
#define BRAKE_LIGHT_OFF_THRESHOLD 300
#define BRAKE_BLINK_CT 3
#define BRAKE_BLINK_PERIOD 250

/* STEERING ANGLE CALCULATION CONFIG */
#define STEERING_S1 (0.00007)
#define STEERING_S2 (-0.0038)
#define STEERING_S3 (0.6535)
#define STEERING_S4 (0.1061)
#define STEERING_INCH2MM (25.4)
#define STEERING_SLOPE (0.00962)
#define STEERING_DEG2RAD (0.01745329)

/* CAR PARAMETER */
#define STEERING_W 1.269
#define STEERING_L 1.574
#define REAR_W 1.242
#define GR 7.956
#define r 0.222

/* TUNING PARAMETER */
#define STEERING_K_YAW 1.6      // increase k makes the car more oversteer
#define STEERING_K_STEER 1.0    // increase k makes the car more oversteer
#define MAX_DELTA_TORQUE 164
#define STEERING_P 20.0
#define RATE_LIMITER 0.06
#define MOTOR_TORQUE_LIMIT 25.0 // N * m (not used)

void eDiff(float AP, float sensor_left_wheel_speed, float sensor_right_wheel_speed, float Vx,
            float sensor_steering_wheel_angle, int16_t prev_torque_left, int16_t prev_torque_right,
            float yaw, float* filter_yaw, int16_t* torque_output_left, int16_t* torque_output_right);