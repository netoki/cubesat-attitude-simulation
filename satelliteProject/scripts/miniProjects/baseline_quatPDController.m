clear; clc;

%% SCENARIOS

scenario_1 = false; % SMALL ROTATION NEAR REFERENCE
scenario_2 = true; % 30-45 DEG ROTATION ABOUT X-AXIS
scenario_3 = false; % 60 DEG ROTATION ABOUT MULTIPLE AXES
scenario_4 = false; % BIG 180 DEG ROTATION

%% INITIAL CONDITIONS


if scenario_1 == true
    q_initial = [0.9998; 0.0175; 0; 0];
    q_initial = q_initial ./ norm(q_initial);
    omega_initial = [0.01; 0; 0];
    omega_q_initial = [0; omega_initial];
end

if scenario_2 == true
    q_initial = [0.966; 0.2588; 0; 0]; % ~30° rotation about x-axis
    q_initial = q_initial ./ norm(q_initial);
    omega_initial = [0.05; 0; 0]; % moderate angular velocity
    omega_q_initial = [0; omega_initial];
end

if scenario_3 == true
    q_initial = [0.866; 0.3536; 0.3536; 0];  % ~60° rotation about [1,1,0] axis
    q_initial = q_initial ./ norm(q_initial);
    omega_initial = [0.02; -0.03; 0.01];     % some rotation in all axes
    omega_q_initial = [0; omega_initial];
end

if scenario_4 == true
    q_initial = [0; 1; 0; 0];    % 180° rotation about x-axis
    q_initial = q_initial ./ norm(q_initial);
    omega_initial = [0; 0.01; -0.02];  % small angular velocity
    omega_q_initial = [0; omega_initial];
end
    


dt = 0.01;
t = 0:dt:10;

I = diag([0.02, 0.02, 0.01]);  % kg·m^2 (CubeSat-scale) moment of inertia matrix


% DESIRED CONDITIONS
q_ref = [1; 0; 0; 0];
q_ref = q_ref ./ norm(q_ref); % Normalization

omega_ref = [0; 0; 0];

% Initialize RK4 Quat Table
q_rk4 = zeros(4,length(t));


% FILL OUT TABLE

q_k = q_initial;
omega_k = omega_initial;

for i = 1:length(t)



    q_rk4(:,i) = q_k;

    
    % COMPUTE ATTITUDE ERROR

    q_e = error_quaternion(q_k, q_ref);

    if q_e(1) < 0
        q_e = -q_e;
    end

    e_q = q_e(2:4); % Error Vector (no scalar component)

    % ANGULAR VELOCITY ERROR

    e_omega = omega_k - omega_ref;

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % PD CONTROL 

    kp = 1; % Proportional Constant
    kd = 0.3; % Derivative Constant
    
    theta = acos(min(max(q_e(1), -1), 1));
    if theta < 1e-8
        phi = 2 * q_e(2:4);  % small-angle approximation
    else

    phi = 2 * theta / sin(theta) * q_e(2:4);
    end

    tau = -kp * phi - kd * omega_k;


    %%%%%%%%%%%%%%%%%%%%%%%%%%

    % Updating angular velocity
    omega_dot = I \ (tau - cross(omega_k, I*omega_k));
    omega_k = omega_k + omega_dot * dt;

    % Updating attitude based on new angular velocity

    omega_q = [0; omega_k];

    k1 = 0.5 * quat_multiply(q_k, omega_q);
    k2 = 0.5 * quat_multiply(q_k + dt/2 * k1, omega_q);
    k3 = 0.5 * quat_multiply(q_k + dt/2 * k2, omega_q);
    k4 = 0.5 * quat_multiply(q_k + dt * k3, omega_q);

    q_knext = q_k + dt/6 * (k1 + 2*k2 + 2*k3 + k4); % RK4 Formula

    q_knext = q_knext ./ norm(q_knext); % Normalization

    q_k = q_knext;

    if q_k(1) < 0
        q_k = -q_k;  % flip quaternion
    end

   
end


figure;

for i = 1:4
    subplot(4,1,i);
    plot(t, q_rk4(i,:), '-r', 'DisplayName', 'RK4');
    ylabel(['q', num2str(i-1)]);
    if i == 1
        title('Quaternion Components Over Time: PD Control Added');
    end
    grid on;
    legend;  % show legend for each subplot
end
xlabel('Time [s]');

%%%%%%%%%%%%%%%%%%%%%%

q_final = q_rk4(:,length(t));


