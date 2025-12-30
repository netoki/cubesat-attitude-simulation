function tau_srp = solarRadiationTorque(R_body_inertial, params)
    % Rotate Sun vector into body frame
    sun_body = R_body_inertial * params.sun_dir; % 3x1

    % Compute SRP force in body frame
    F_srp = params.P_solar * params.Cr .* (params.A_srp .* sun_body);

    % Torque from SRP (moment arm cross force)
    tau_srp = cross(params.r_cp_srp, F_srp); % 3x1
end
