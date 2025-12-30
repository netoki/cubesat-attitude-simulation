function q_e = error_quaternion(q, q_ref)

% COMPUTES ERROR QUATERNION GIVEN REFERENCE QUATERNION AND CURRENT
% QUATERNION.

inverted_q_ref = invert_quaternion(q_ref);

q_e = quat_multiply(inverted_q_ref, q);

end
