function B_body = earthMagneticField(state, params)

% Simple constant field in inertial frame
B_inertial = params.B_earth;  % e.g. [0; 0; 3e-5] Tesla

% Rotate into body frame
C_bi = quatToDCM(state.q);
B_body = C_bi * B_inertial;

end
