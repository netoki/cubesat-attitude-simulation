function tau_gg = gravityGradientTorque(state, params)
% Computes gravity gradient torque in body frame

% Earth gravitational parameter
mu = params.mu;

% Orbital radius (assumed circular for now)
r = params.orbit_radius;

% Inertia matrix
I = params.I;

% Earth direction in inertial frame (assume nadir-pointing orbit)
r_hat_I = [1; 0; 0];   % Simplified: Earth is along inertial x

% Rotate into body frame
C_BI = quatToDCM(state.q');   % Body from inertial
r_hat_B = C_BI * r_hat_I;

% Gravity gradient torque
tau_gg = 3 * mu / r^3 * cross(r_hat_B, I * r_hat_B);
end
