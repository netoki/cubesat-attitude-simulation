function inverted_quaternion = invert_quaternion(q)

% THIS FUNCTION TAKES A QUATERNION AND INVERTS IT. IT MAY BE ANY QUATERNION,
% THIS FUNCTION IS NOT EXCLUSIVE TO UNIT QUATERNIONS.

squared_norm = q(1)^2 + q(2)^2 + q(3)^2 + q(4)^2;

inverted_quaternion = [q(1); -q(2); -q(3); -q(4)] ./ squared_norm;

end