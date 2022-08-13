#include "eDiff.h"

// special c file just for being used with MATLAB wrapper function for Simulink in-loop testing

inline float pow_diy(float base, uint8_t power)
{
    float output = base;
    for(uint8_t i = 0; i < (power - 1); i++)
    {
        output *= base;
    }
    return output;
}

/*
* E-diff @ May 29, based on Demetrius's May 25 E-diff simulink model
*/

// note that t_req, *torque_output_left and *torque_output_right are all signed integer from -4095 to 4095, 
//                                                     and 0 represent 0% torque, 4095 represent 100% torque

void eDiff(float AP, float sensor_left_wheel_speed, float sensor_right_wheel_speed, float Vx,
            float sensor_steering_wheel_angle, int16_t prev_torque_left, int16_t prev_torque_right,
            float yaw, float* filter_yaw, int16_t* torque_output_left, int16_t* torque_output_right)
{
    float steering_wheel_angle;

    float wheel_speed_left;
    float wheel_speed_right;
    //float vehicle_speed;

    float rack_disp;
    float left_steer_angle;
    float right_steer_angle;
    float avg_steer_angle;

    float desired_wheel_speed_diff_steer;
    float desired_wheel_speed_diff_yaw;

    float actual_wheel_speed_diff;
    float error_wheel_speed_diff_yaw;
    float error_wheel_speed_diff_steer;
    float error_wheel_speed_diff;

    float delta_torque;
    int16_t t_req;

    t_req = LV_MAX_ADC_RAW * AP;

    // not the best vehicle speed calculation, should probably include IMU data also
    //vehicle_speed = (wheel_speed_left + wheel_speed_right) / 2.0;

    steering_wheel_angle = sensor_steering_wheel_angle;
    rack_disp = STEERING_SLOPE * STEERING_INCH2MM * steering_wheel_angle;
    left_steer_angle = - ((STEERING_S1 * pow_diy(-rack_disp, 3)) + (STEERING_S2 * pow_diy(-rack_disp, 2)) + (STEERING_S3 * (-rack_disp)) + STEERING_S4);
    right_steer_angle = ((STEERING_S1 * pow_diy(rack_disp, 3)) + (STEERING_S2 * pow_diy(rack_disp, 2)) + (STEERING_S3 * rack_disp) + STEERING_S4);
    avg_steer_angle = ((left_steer_angle + right_steer_angle) / 2) * STEERING_DEG2RAD;

    // yaw rate filter
    *filter_yaw = ((yaw) * RATE_LIMITER ) + ((1 - RATE_LIMITER ) * *filter_yaw);

    // pre-PID
    desired_wheel_speed_diff_steer = Vx * STEERING_W * tan(avg_steer_angle) * STEERING_K_STEER / (STEERING_L);
    desired_wheel_speed_diff_yaw = *filter_yaw * STEERING_W * STEERING_K_YAW ;
    actual_wheel_speed_diff = yaw * REAR_W;

    error_wheel_speed_diff_yaw = desired_wheel_speed_diff_yaw - actual_wheel_speed_diff;
    error_wheel_speed_diff_steer = desired_wheel_speed_diff_steer - actual_wheel_speed_diff;

    // actual PID
    if (fabs(error_wheel_speed_diff_steer) > 10)
    {
    	delta_torque = fabs(STEERING_P * error_wheel_speed_diff_yaw) * (LV_MAX_ADC_RAW / 25);  // just P for now
    	error_wheel_speed_diff = error_wheel_speed_diff_yaw;
    }
    else
    {
    	delta_torque = fabs(STEERING_P * error_wheel_speed_diff_steer) * (LV_MAX_ADC_RAW / 25);  // just P for now
    	error_wheel_speed_diff = error_wheel_speed_diff_steer;
    }

    // limit spikes in delta_torque
    if (delta_torque - fabs(prev_torque_left - prev_torque_right) > MAX_DELTA_TORQUE)
    {
        delta_torque = fabs(prev_torque_left - prev_torque_right) + MAX_DELTA_TORQUE;
    }

    if (t_req < 0) // when regen breaking
    {
        // regen torque output
        if ((t_req + (delta_torque / 2)) > - LV_MAX_ADC_RAW)
        {
	        if(error_wheel_speed_diff >= 0)
	        {
	            *torque_output_left  = t_req - (delta_torque / 2);
	            *torque_output_right  = t_req + (delta_torque / 2);       
	        }
	        else
	        {
	            *torque_output_left = t_req + (delta_torque / 2);
	            *torque_output_right = t_req - (delta_torque / 2);
	        }
		}
        else
        {
	        if(error_wheel_speed_diff >= 0)
	        {
	            *torque_output_left  = t_req;
	            *torque_output_right  = t_req + delta_torque;       
	        }
	        else
	        {
	            *torque_output_left = t_req + delta_torque;
	            *torque_output_right = t_req;
	        }
	    }

    } 
    else // when positive torque request
    {    
        //  TODO (not critical): include lookup table for torque fallout in high rpm

        // torque output
        if ((t_req + (delta_torque / 2)) < LV_MAX_ADC_RAW)
        {
        	if(error_wheel_speed_diff >= 0)
	        {
	            *torque_output_left  = t_req + (delta_torque / 2);
	            *torque_output_right  = t_req - (delta_torque / 2);   
	        }
	        else
	        {
	            *torque_output_left = t_req - (delta_torque / 2);
	            *torque_output_right = t_req + (delta_torque / 2);
	        }
	    }
        else
        {
	        if(error_wheel_speed_diff >= 0)
	        {
	            *torque_output_left  = t_req;
	            *torque_output_right  = t_req - delta_torque; 
	        }
	        else
	        {
	            *torque_output_left = t_req - delta_torque;
	            *torque_output_right = t_req;
	        }
	    }
    }

    // limit regen torque (temporary)
    if(*torque_output_right < (- 0.25 * LV_MAX_ADC_RAW))
    {
        *torque_output_right = (- 0.25 * LV_MAX_ADC_RAW);
    }

    // limit regen torque (temporary)
    if(*torque_output_left < (- 0.25 * LV_MAX_ADC_RAW))
    {
        *torque_output_left = (- 0.25 * LV_MAX_ADC_RAW);
    }

    // rate limiting filter
    //if (fabs(*torque_output_right - prev_torque_right) > (3 * 4095 / 25))
    //{
    //    *torque_output_right = ((*torque_output_right) * RATE_LIMITER ) + ((1 - RATE_LIMITER ) * prev_torque_right);
    //}

    //if (fabs(*torque_output_left - prev_torque_left) > (3 * 4095 / 25))
    //{
    //    *torque_output_left = ((*torque_output_left) * RATE_LIMITER ) + ((1 - RATE_LIMITER ) * prev_torque_left);
    //}


    return;
}