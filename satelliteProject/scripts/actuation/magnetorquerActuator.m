function tau_mag = magnetorquerActuator(m_cmd, B_body)
% MAGNETORQUER
% Converts magnetic dipole into body-frame torque

tau_mag = cross(m_cmd, B_body);

end
