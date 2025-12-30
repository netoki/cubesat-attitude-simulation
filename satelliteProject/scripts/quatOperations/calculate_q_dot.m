function q_dot = calculate_q_dot(q,omega)

% This function takes a quaternion and angular velocity input to calculate
% the time derivative of the quaternion.

% NOTE: INPUT q MUST BE A 4 CELL COLUMN VECTOR. INPUT omega MUST BE A 3
% CELL COLUMN VECTOR.

q_matrix = [-q(2), -q(3), -q(4);
             q(1), -q(4),  q(3);
             q(4),  q(1), -q(2);
            -q(3),  q(2),  q(1)];



q_dot = 1/2 * q_matrix * omega;

end