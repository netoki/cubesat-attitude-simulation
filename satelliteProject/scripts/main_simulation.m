clear; clc;

%% Load scenario and parameters
scenario_id = 4;
animate_on = false;
plots_on = false;
export_Attitude = true;
[q0, omega0] = loadScenario(scenario_id);
params = loadParams();

state.q = q0;
state.omega = omega0;

q_ref = [1;0;0;0];
omega_ref = [0;0;0]; 

dt = params.dt;
t = 0:dt:params.T;
N = length(t);

log.q = zeros(4,N);
log.omega = zeros(3,N);
log.tau_gg = zeros(3,N);
log.tau_d = zeros(3,N);
log.tau_srp = zeros(3,N);

omega_int = params.omega_int; % Initialize Angular Velocity State
h_w = params.h_w; % Initialize Angular Momentum State 

%% Simulation loop
for k = 1:N
    log.q(:,k) = state.q;
    log.omega(:,k) = state.omega;

    
    state_meas.omega = gyroSensor(state.omega, params, dt);
    state_meas.q = attitudeSensor(state.q, params);

    % Controller
    [tau_cmd, params, omega_int] = attitudeControllerPID(state, q_ref, omega_ref, params, omega_int);

    % Reaction Wheel Response
    [tau_rw, h_w] = reactionWheelActuator(tau_cmd,h_w,params,dt);


    % Magnetorquers
    B_body = earthMagneticField(state,params);
    m_cmd = momentum_dumping(h_w, B_body, params);
    tau_mag = magnetorquerActuator(m_cmd, B_body);

    % Gravity Gradient
    tau_gg = gravityGradientTorque(state, params);

    % Aerodynamic Drag
    tau_d = dragTorque(state, params);

    % Solar Radiation
    R_bi = quatToDCM(state.q);
    tau_srp = solarRadiationTorque(R_bi, params);

    % Total Torque
    tau_actual = tau_rw + tau_mag + tau_d;

    state = rk4Step(state, tau_actual, params, h_w);



    % LOGGING VALUES
    log.h_w(:,k) = h_w;
    log.tau_mag(:,k) = tau_mag;
    log.tau_gg(:,k) = tau_gg;
    log.tau_d(:,k) = tau_d;
    log_tau_srp(:,k) = tau_srp;

end

% PLOTTING

if plots_on == true

    %% Quaternion Plots
    figure;
    for i = 1:4
        subplot(4,1,i)
        plot(t, log.q(i,:))
        ylabel(['q',num2str(i-1)])
        grid on
    end
    xlabel('Time [s]')
    
    %% Plot Reaction Wheel Momentum
    figure;
    for i = 1:3
        subplot(3,1,i)
        plot(t, log.h_w(i,:))
        ylabel(['h_w_', num2str(i)])
        grid on
    end
    xlabel('Time [s]')
    sgtitle('Reaction Wheel Angular Momentum Over Time')
    
    %% Plot Magnetorquer Torque
    figure;
    for i = 1:3
        subplot(3,1,i)
        plot(t, log.tau_mag(i,:))
        ylabel(['tau_mag_', num2str(i)])
        grid on
    end
    xlabel('Time [s]')
    sgtitle('Magnetorquer Torque Over Time')
    
    %% Plot Gravity Gradient Torque
    
    figure;
    for i = 1:3
        subplot(3,1,i)
        plot(t, log.tau_gg(i,:))
        ylabel(['tau_gg_', num2str(i)])
        grid on
    end
    xlabel('Time [s]')
    sgtitle('Gravity Gradient Torque Over Time')
    
    %% Plot Aerodynamic Drag Torque
    
    figure;
    for i = 1:3
        subplot(3,1,i)
        plot(t, log.tau_d(i,:))
        ylabel(['tau_d_', num2str(i)])
        grid on
    end
    xlabel('Time [s]')
    sgtitle('Aerodynamic Drag Torque Over Time')
    
    %% Plot Solar Radiation Torque
    
    figure;
    for i = 1:3
        subplot(3,1,i)
        plot(t, log.tau_srp(i,:))
        ylabel(['tau_srp_', num2str(i)])
        grid on
    end
    xlabel('Time [s]')
    sgtitle('Solar Radiation Torque Over Time')
end

% ANIMATE

if animate_on == true
    animateAltitude(log.q, t)
end

% EXPORT

if export_Attitude == true
    exportAttitudeCSV("quaternionCSV", t, log.q);
end