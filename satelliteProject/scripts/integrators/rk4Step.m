function state_next = rk4Step(state, tau, params, h_w)

dt = params.dt;

k1 = rigidBodyDynamics(state, tau, params, h_w);

s2.q = state.q + dt/2 * k1.q;
s2.omega = state.omega + dt/2 * k1.omega;
k2 = rigidBodyDynamics(s2, tau, params, h_w);

s3.q = state.q + dt/2 * k2.q;
s3.omega = state.omega + dt/2 * k2.omega;
k3 = rigidBodyDynamics(s3, tau, params, h_w);

s4.q = state.q + dt * k3.q;
s4.omega = state.omega + dt * k3.omega;
k4 = rigidBodyDynamics(s4, tau, params, h_w);

state_next.q = state.q + dt/6 * (k1.q + 2*k2.q + 2*k3.q + k4.q);
state_next.omega = state.omega + dt/6 * (k1.omega + 2*k2.omega + 2*k3.omega + k4.omega);

state_next.q = quatNormalize(state_next.q);

if state_next.q(1) < 0
    state_next.q = -state_next.q;
end

end
