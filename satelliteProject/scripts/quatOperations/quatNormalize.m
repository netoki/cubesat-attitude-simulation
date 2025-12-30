function q_norm = quatNormalize(q)
% Normalizes our quaternion

q_norm = q ./ norm(q);
end