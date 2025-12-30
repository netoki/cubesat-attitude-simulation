function exportAttitudeCSV(filename, t, q_log)
%EXPORTATTITUDECSV Export quaternion attitude history for Blender
%
% Inputs:
%   filename : string, e.g. 'attitude_data.csv'
%   t        : 1xN or Nx1 time vector [s]
%   q_log    : 4xN quaternion history [q0;q1;q2;q3]

    % --- Sanity checks ---
    if size(q_log,1) ~= 4
        error('q_log must be 4xN with rows [q0;q1;q2;q3]');
    end

    N = length(t);
    if size(q_log,2) ~= N
        error('Time vector length must match quaternion samples');
    end

    % --- Force column vectors ---
    t = t(:);            % Nx1
    q_log = q_log.';     % Nx4

    % --- Combine time + quaternions ---
    data = [t, q_log];   % Nx5

    % --- Create headers ---
    headers = {'time','q0','q1','q2','q3'};

    % --- Write CSV ---
    writecell([headers; num2cell(data)], filename);

    fprintf('Attitude CSV written: %s (%d samples)\n', filename, N);
end
