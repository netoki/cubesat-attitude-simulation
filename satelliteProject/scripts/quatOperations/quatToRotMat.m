function R = quatToRotMat(q)
    q1 = q(1); q2 = q(2); q3 = q(3); q4 = q(4);

    % Standard rotation matrix from unit quaternion
    R = [1-2*(q3^2+q4^2), 2*(q2*q3-q1*q4), 2*(q2*q4+q1*q3);
         2*(q2*q3+q1*q4), 1-2*(q2^2+q4^2), 2*(q3*q4-q1*q2);
         2*(q2*q4-q1*q3), 2*(q3*q4+q1*q2), 1-2*(q2^2+q3^2)];
end
