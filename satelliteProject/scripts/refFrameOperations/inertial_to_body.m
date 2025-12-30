% Converts from INERTIAL to BODY
function v_body = inertial_to_body(v_inertial, phi, theta, psi)
    % Build DCM
    R = euler_to_dcm(phi, theta, psi);
    % Convert: body = R' * inertial
    v_body = R' * v_inertial;
end