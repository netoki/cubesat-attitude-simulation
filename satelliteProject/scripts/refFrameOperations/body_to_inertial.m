% Converts from BODY to INERTIAL
function v_inertial = body_to_inertial(v_body, phi, theta, psi)
    % Build DCM
    R = euler_to_dcm(phi, theta, psi);
    % Convert: inertial = R * body
    v_inertial = R * v_body;
end
