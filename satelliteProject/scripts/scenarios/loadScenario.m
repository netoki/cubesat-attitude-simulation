function [q0, omega0] = loadScenario(id)

switch id
    case 1  % small error
        q0 = [0.9998; 0.0175; 0; 0];
        omega0 = [0.01; 0; 0];

    case 2  % 30 deg about x
        q0 = [0.966; 0.2588; 0; 0];
        omega0 = [0.05; 0; 0];

    case 3  % 60 deg about [1 1 0]
        q0 = [0.866; 0.3536; 0.3536; 0];
        omega0 = [0.02; -0.03; 0.01];

    case 4  % 180 deg
        q0 = [0; 1; 0; 0];
        omega0 = [0; 0.01; -0.02];

    otherwise
        error('Unknown scenario')
end

q0 = q0 / norm(q0);

end
