function state_dirv = bicycle_model(t, state, u1, u2, lf, lr)
    X = state(1);
    Y = state(2);
    V = state(3);
    psi = state(4);

    beta = atan(tan(u2) * lr / (lf + lr));

    % Equations of motion (kinematic bicycle model)
    dXdt = V * cos(psi + beta); % Rate of change of X position
    dYdt = V * sin(psi + beta); % Rate of change of Y position
    dVdt = u1;                  % Rate of change of velocity (throttle)
    dpsidt = V / lr * sin(beta);% Rate of change of yaw angle

    state_dirv = [dXdt; dYdt; dVdt; dpsidt];
end