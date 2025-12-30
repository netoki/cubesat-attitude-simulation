function tau_d = dragTorque(state, params)
% dragTorque calculates aerodynamic drag torque on a CubeSat
% 
% Inputs:
%   state - struct containing:
%       state.q     : 4x1 quaternion (body relative to inertial)
%       state.omega : 3x1 angular velocity in body frame
%   params - struct containing:
%       params.rho    : atmospheric density [kg/m^3]
%       params.Cd     : drag coefficient
%       params.A      : projected area [m^2] (can be vector [Ax Ay Az])
%       params.r_cp   : 3x1 vector from COM to center of pressure [m]
%       params.v_rel  : 3x1 velocity relative to atmosphere in inertial frame [m/s]
%
% Output:
%   tau_d : 3x1 aerodynamic drag torque in body frame [N·m]

% Transform velocity to body frame 
C_bi = quatToDCM(state.q);  % convert quaternion to DCM (body w.r.t inertial)
v_body = C_bi * params.v_rel(:);  % velocity in body frame

% Compute drag force on each axis 
Fd_x = 0.5 * params.rho * (v_body(1)^2) * params.Cd * params.A(1);
Fd_y = 0.5 * params.rho * (v_body(2)^2) * params.Cd * params.A(2);
Fd_z = 0.5 * params.rho * (v_body(3)^2) * params.Cd * params.A(3);

F_drag = -sign(v_body) .* [Fd_x; Fd_y; Fd_z];  % drag opposes motion

% Compute torque using cross product with center of pressure 
tau_d = cross(params.r_cp, F_drag);  % torque in body frame

end
