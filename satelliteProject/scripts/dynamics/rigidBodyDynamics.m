function state_dot = rigidBodyDynamics(state, tau, params, h_w)

q = state.q;
omega = state.omega;
I = params.I;

omega_dot = I \ (tau - cross(omega, I*omega + h_w));
q_dot = 0.5 * quat_multiply(q, [0; omega]);

state_dot.q = q_dot;
state_dot.omega = omega_dot;

end
