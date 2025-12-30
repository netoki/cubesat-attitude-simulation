%% FUNCTION: CALCULATES ROTATIONAL MATRICES AND COMPUTES DCM

function R = euler_to_dcm(phi, theta, psi)
    % phi   : roll  (rotation about X-axis)
    % theta : pitch (rotation about Y-axis)
    % psi   : yaw   (rotation about Z-axis)

    R_x = [1      0           0;
           0 cos(phi) -sin(phi);
           0 sin(phi)  cos(phi)];

    R_y = [ cos(theta) 0 sin(theta);
                  0    1      0;
           -sin(theta) 0 cos(theta)];

    R_z = [cos(psi) -sin(psi) 0;
           sin(psi)  cos(psi) 0;
               0         0    1];

    % DCM from body to inertial: ZYX sequence
    R = R_z * R_y * R_x;  
end