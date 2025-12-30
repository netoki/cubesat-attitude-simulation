function [tau, params, omega_int] = attitudeControllerPID(state, q_ref, omega_ref, params, omega_int)

q = state.q;
omega = state.omega;

% Error quaternion
q_e = error_quaternion(q, q_ref);
if q_e(1) < 0
    q_e = -q_e;
end

% Log map
phi = quatLog(q_e);

% Integrator

if norm(omega) < params.omega_thresh
    omega_int = omega_int + omega * params.dt;
end

% Control law
tau = -params.kp * phi ...
      -params.kd * (omega - omega_ref) ...
      -params.ki * omega_int;

% Disturbance
tau = tau + params.tau_dist;

end
