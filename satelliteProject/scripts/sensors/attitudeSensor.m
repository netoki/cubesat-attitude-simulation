function q_meas = attitudeSensor(q_true, params)

% Small-angle noise
delta_theta = params.att_noise_std * randn(3,1);

angle = norm(delta_theta);

if angle > 0
    axis = delta_theta / angle;
    dq = [cos(angle/2);
          axis*sin(angle/2)];
else
    dq = [1; 0; 0; 0];
end

% Apply noise multiplicatively
q_meas = quat_multiply(dq, q_true);

% Normalize (always)
q_meas = q_meas / norm(q_meas);

end
