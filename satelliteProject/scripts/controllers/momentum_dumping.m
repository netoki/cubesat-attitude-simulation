function [m_cmd, dumping_on] = momentum_dumping(h_w, B_body, params)
% MOMENTUM_DUMPING
% Computes magnetic dipole command to unload reaction wheels

% --- Parameters
h_dump = params.h_dump;   % dumping threshold
k_m    = params.k_m;      % dumping gain

% --- Default
m_cmd = zeros(3,1);
dumping_on = false;

% --- Check momentum magnitude
h_norm = norm(h_w);

if h_norm > h_dump
    dumping_on = true;

    % Core dumping law
    m_cmd = -k_m * cross(B_body, h_w);
end

end
