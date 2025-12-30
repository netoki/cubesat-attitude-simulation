function phi = quatLog(q_e)

q0 = q_e(1);
qv = q_e(2:4);

qv_norm = norm(qv);

if qv_norm < 1e-8
    % Small-angle approximation
    phi = 2 * qv;
else
    theta = 2 * atan2(qv_norm, q0);
    phi = (theta / qv_norm) * qv;
end
