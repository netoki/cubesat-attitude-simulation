function animateAltitude(q_history, t)
    % q_history: 4 x N matrix of quaternions over time
    % t: 1 x N time vector

    % 1. Define the 3D spacecraft model
    % For simplicity, use a simple cuboid or patch object
    [X, Y, Z] = meshgrid([-0.5 0.5], [-0.2 0.2], [-0.1 0.1]); % Cube dimensions
    vertices = [X(:) Y(:) Z(:)];
    faces = convhull(vertices); % Quick convex hull for visualization

    % 2. Set up the figure
    fig = figure;
    axis equal;
    xlabel('X'); ylabel('Y'); zlabel('Z');
    view(3);
    grid on;
    hold on;

    h_patch = patch('Vertices', vertices, 'Faces', faces, ...
                    'FaceColor', 'black', 'FaceAlpha', 0.7);

    % 3. Loop over time and apply quaternion rotation
    for k = 1:length(t)
        q = q_history(:,k); % Current quaternion

        % Convert quaternion to rotation matrix
        R = quatToRotMat(q); % You'll need a small helper function

        % Rotate vertices
        rotatedVertices = (R * vertices')';

        % Update patch
        set(h_patch, 'Vertices', rotatedVertices);

        drawnow;
        pause(0.01); % Optional: adjust for simulation speed
    end
end