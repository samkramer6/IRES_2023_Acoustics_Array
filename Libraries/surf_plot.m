function surf_plot(data, timestep, sample_rate)
    ind = timestep * sample_rate;

    % Extract the pressure values from the data matrix
    pressure = data(ind, :) ./ (10.^(2.5));

    % Normalize the pressure values between 0 and 1
    npressure = (pressure - min(pressure(:))) / (max(pressure(:)) - min(pressure(:)));

    % Real world dimensions in [m]
    x = 5;
    y = 2.59;
    z = 2.92;

    % 3D points for constructing the mesh
    meshPoints = [
        0,       1/3*y,   0;       0,       0,       1/6*z;   0,       0,       5/6*z;
        0,       1/3*y,   z;       0,       2/3*y,   z;       0,       y,       5/6*z;
        0,       y,       1/6*z;   0,       2/3*y,   0;       1/6*x,   1/3*y,   0;
        1/6*x,   0,       1/6*z;   1/6*x,   0,       5/6*z;   1/6*x,   1/3*y,   z;
        1/6*x,   2/3*y,   z;       1/6*x,   y,       5/6*z;   1/6*x,   y,       1/6*z;
        2/6*x,   2/3*y,   0;       2/6*x,   1/3*y,   0;       2/6*x,   1/3*y,   0;
        2/6*x,   0,       1/6*z;   2/6*x,   0,       5/6*z;   2/6*x,   1/3*y,   z;
        2/6*x,   2/3*y,   z;       2/6*x,   y,       5/6*z;   2/6*x,   y,       1/6*z;
        2/6*x,   2/3*y,   0;       2/6*x,   1/3*y,   0;       3/6*x,   0,       1/6*z;
        3/6*x,   0,       5/6*z;   3/6*x,   1/3*y,   z;       3/6*x,   2/3*y,   z;
        3/6*x,   y,       5/6*z;   3/6*x,   y,       1/6*z;   3/6*x,   2/3*y,   0;
        4/6*x,   0,       1/6*z;   4/6*x,   0,       5/6*z;   4/6*x,   1/3*y,   z;
        4/6*x,   2/3*y,   z;       4/6*x,   y,       5/6*z;   4/6*x,   y,       1/6*z;
        4/6*x,   2/3*y,   0;       5/6*x,   0,       1/6*z;   5/6*x,   0,       5/6*z;
        5/6*x,   1/3*y,   z;       5/6*x,   2/3*y,   z;       5/6*x,   y,       5/6*z;
        5/6*x,   y,       1/6*z;   5/6*x,   2/3*y,   0;       x,       1/3*y,   0;
        x,       0,       1/6*z;   x,       0,       5/6*z;   x,       1/3*y,   z;
        x,       2/3*y,   z;       x,       y,       5/6*z;   x,       y,       1/6*z;
        x,       2/3*y,   0
        ];

    % 3D points of mic placement along the tunnel
    micPoints = [
        0,       1/6*y,   1/12*z;   0,       0,       2/3*z;    0,       1/2*y,   z;
        0,       y,       2/3*z;    0,       5/6*y,   1/12*z;   1/5*x,   1/6*y,   1/12*z;
        1/5*x,   0,       2/3*z;    1/5*x,   1/2*y,   z;        1/5*x,   y,       2/3*z;
        1/5*x,   5/6*y,   1/12*z;   2/5*x,   1/6*y,   1/12*z;   2/5*x,   0,       2/3*z;
        2/5*x,   1/2*y,   z;        2/5*x,   y,       2/3*z;    2/5*x,   5/6*y,   1/12*z;
        3/5*x,   1/6*y,   1/12*z;   3/5*x,   0,       2/3*z;    3/5*x,   1/2*y,   z;
        3/5*x,   y,       2/3*z;    3/5*x,   5/6*y,   1/12*z;   4/5*x,   1/6*y,   1/12*z;
        4/5*x,   0,       2/3*z;    4/5*x,   1/2*y,   z;        4/5*x,   y,       2/3*z;
        4/5*x,   5/6*y,   1/12*z;   x,       1/6*y,   1/12*z;   x,       0,       2/3*z;
        x,   1/2*y,   z;       x,   y,       2/3*z;   x,        5/6*y,   1/12*z;
        0,       1/2*y,   1/2*z;    x,       1/2*y,   1/2*z
    ];

    % Create the figure
    figure;
    
    % Plot the 3D surface mesh
    shape = convhull(meshPoints(:,1),meshPoints(:,2),meshPoints(:,3));
    trisurf(shape,meshPoints(:, 1), meshPoints(:, 2), meshPoints(:, 3), 'FaceColor', 'black', 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);
    hold on;
    
    % Define the number of data points
    numPoints = numel(npressure);

    % Create the color map
    cmap = hot(numPoints);

    % Map the pressure values to the color map
    colorIndices = ceil((npressure - min(npressure)) / (max(npressure) - min(npressure)) * numPoints);
    colorIndices = max(colorIndices, 1); % Ensure indices are not less than 1
    colorIndices = min(colorIndices, numPoints); % Ensure indices are not greater than the colormap size
    rgbValues = cmap(round(colorIndices), :);
    
    % Scatter the 3D points with color mapping
    scatter3(micPoints(:,1), micPoints(:,2), micPoints(:,3), 30, rgbValues, 'filled');
    colormap(cmap);
    colorbar;

    % Set the axis labels and title
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(['Normalized pressures at time ', num2str(timestep)]);
    
    hold off;
end