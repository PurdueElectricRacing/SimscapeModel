ax = calibration042725(:,1);
ay = calibration042725(:,2);
az = calibration042725(:,3);
R = ac_compute_R(ax, ay, az);

test = R*[ax(1); ay(1); az(1)]