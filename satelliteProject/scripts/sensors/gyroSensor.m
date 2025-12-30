function omega_meas = gyroSensor(omega_true, params, dt)

% White noise scaled by sqrt(dt)
noise = params.gyro_noise_std / sqrt(dt) * randn(3,1);

omega_meas = omega_true + params.gyro_bias + noise;

end
