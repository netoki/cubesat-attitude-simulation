clear; clc;

q_initial = [0.9239; 0.3827; 0; 0];
q_k = q_initial;

omega = [1; 3; 0];
omega_q = [0; 1; 3; 0];

dt = 0.1;
t = 0:dt:10;

q_euler = zeros(4,101); % Initialize Euler vs RK4 Quat Tables
q_rk4 = zeros(4,101);


%% EULER INTEGRATION

for i = 1:101
    q_euler(:,i) = q_k;

    qdot = calculate_q_dot(q_k, omega); % Premade Function

    q_knext = q_k + (qdot * dt); % Euler Formula

    q_knext = q_knext ./ norm(q_knext); % Normalization

    q_k = q_knext;
end

%% RK4 INTEGRATION
q_k = q_initial;

for i = 1:101
    q_rk4(:,i) = q_k;

    k1 = 0.5 * quat_multiply(q_k, omega_q);
    k2 = 0.5 * quat_multiply(q_k + dt/2 * k1, omega_q);
    k3 = 0.5 * quat_multiply(q_k + dt/2 * k2, omega_q);
    k4 = 0.5 * quat_multiply(q_k + dt * k3, omega_q);

    q_knext = q_k + dt/6 * (k1 + 2*k2 + 2*k3 + k4); % RK4 Formula

    q_knext = q_knext ./ norm(q_knext); % Normalization

    q_k = q_knext;


end




% PLOT

figure;

for i = 1:4
    subplot(4,1,i);
    plot(t, q_euler(i,:), '-r', 'DisplayName', 'Euler'); hold on;
    plot(t, q_rk4(i,:), '-b', 'DisplayName', 'RK4');
    ylabel(['q', num2str(i-1)]);
    if i == 1
        title('Quaternion Components over Time: Euler vs RK4');
    end
    grid on;
    legend;  % show legend for each subplot
end
xlabel('Time [s]');
