function q = quat_multiply(q1, q2)
    % q1, q2: 1x4 or 4x1 quaternions [q0 q1 q2 q3]
    % returns q = q1 * q2
    
    q0 = q1(1)*q2(1) - q1(2)*q2(2) - q1(3)*q2(3) - q1(4)*q2(4);
    q1v = q1(1)*q2(2) + q1(2)*q2(1) + q1(3)*q2(4) - q1(4)*q2(3);
    q2v = q1(1)*q2(3) - q1(2)*q2(4) + q1(3)*q2(1) + q1(4)*q2(2);
    q3v = q1(1)*q2(4) + q1(2)*q2(3) - q1(3)*q2(2) + q1(4)*q2(1);
    
    q = [q0; q1v; q2v; q3v];
end
