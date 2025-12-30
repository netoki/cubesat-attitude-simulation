function params = loadParams()

    % Time
    params.dt = 0.01;
    params.T  = 100;

    % Inertia (CubeSat-scale)
    params.I = diag([0.02 0.02 0.01]);

    % Controller gains
    params.kp = 1.0;
    params.kd = 1.7;
    params.ki = 0.2;

    % Integral state & threshold
    params.omega_int = zeros(3,1); % Initialize Angular Velocity State
    params.h_w = zeros(3,1); % Initialize Angular Momentum State 
    params.omega_thresh = 1e-3;
    
    % Disturbance torque
    params.tau_dist = [1e-4; 0; 0];

    % Actuation Limits
    params.tau_max = 1e-3; % Newton meters
    params.h_max = 5e-3; % Newton meter seconds

    % Magnetorquer Settings
    params.h_dump = 0.02;
    params.k_m = 5e-2;

   %% Earth Parameters
    params.B_earth = [0; 0; 3.12e-5];  % Tesla, approximate LEO geomagnetic field along Z
    params.mu      = 3.986004418e14;   % m^3/s^2, Earth's standard gravitational parameter
    params.orbit_radius = 6.78e6;      % m, typical LEO altitude ~400 km + Earth's radius
    
%% Atmospheric Drag Parameters (CubeSat-scale)
    params.rho    = 5e-12;             % kg/m^3, density at ~400 km LEO (slightly higher than your 4e-12)
    params.Cd     = 2.2;                % Drag coefficient, typical for CubeSat
    params.A      = [0.01, 0.01, 0.01];% m^2 projected area along x, y, z axes
    params.r_cp   = [0.02; 0; 0];       % m, vector from COM to center of pressure (smaller offset than 5cm)
    params.v_rel  = [7700; 0; 0];       % m/s, LEO orbital velocity (more precise than 7500 m/s)

% Solar Radiation Pressure Parameters
    params.sun_dir  = [1; 0; 0];    % unit vector from satellite to Sun (inertial)
    params.P_solar = 4.56e-6;       % N/m^2, at 1 AU
    params.Cr      = 1.5;           % reflectivity coefficient (typical for CubeSat)
    params.A_srp   = [0.01; 0.01; 0.01]; % m^2 projected areas along x,y,z
    params.r_cp_srp = [0.02; 0; 0]; % m, vector from COM to center of pressure

%% Gyro Sensor Parameters (CubeSat-class)
    params.gyro_bias       = deg2rad([0.01; -0.015; 0.02]);   % rad/s
    params.gyro_noise_std  = deg2rad(0.002);                 % rad/sqrt(s)

%% Attitude Sensor Parameters
    params.att_noise_std   = deg2rad(0.05);   % rad (≈ 0.05 deg star tracker)


end
