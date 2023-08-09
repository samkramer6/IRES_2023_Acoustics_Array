% function source_freq_plot(filepath, time_start, time_end, source)
% 
%     % Load, shape, and filter data
%     load(filepath);
% 
%     final_output_data = final_output_data(2:end-1,:);
%     mic_data = final_output_data(:,2:end);
%     time = final_output_data(:,1);
%     fs = round(1/(time(10)-time(9)));
% 
%     ind1 = time_start*fs + 1;
%     ind2 = time_end*fs;
% 
%     mic_data = mic_data(ind1:ind2,:);
%     mic_data = normalize(mic_data, "center", "mean");
% 
%     % Real world dimensions in [m]
%     x = 5;
%     y = 2.59;
%     z = 2.92;
% 
%     % 3D points for constructing the mesh
%     meshPoints = [
%         0,       1/3*y,   0;       0,       0,       1/6*z;   0,       0,       5/6*z;
%         0,       1/3*y,   z;       0,       2/3*y,   z;       0,       y,       5/6*z;
%         0,       y,       1/6*z;   0,       2/3*y,   0;       1/6*x,   1/3*y,   0;
%         1/6*x,   0,       1/6*z;   1/6*x,   0,       5/6*z;   1/6*x,   1/3*y,   z;
%         1/6*x,   2/3*y,   z;       1/6*x,   y,       5/6*z;   1/6*x,   y,       1/6*z;
%         2/6*x,   2/3*y,   0;       2/6*x,   1/3*y,   0;       2/6*x,   1/3*y,   0;
%         2/6*x,   0,       1/6*z;   2/6*x,   0,       5/6*z;   2/6*x,   1/3*y,   z;
%         2/6*x,   2/3*y,   z;       2/6*x,   y,       5/6*z;   2/6*x,   y,       1/6*z;
%         2/6*x,   2/3*y,   0;       2/6*x,   1/3*y,   0;       3/6*x,   0,       1/6*z;
%         3/6*x,   0,       5/6*z;   3/6*x,   1/3*y,   z;       3/6*x,   2/3*y,   z;
%         3/6*x,   y,       5/6*z;   3/6*x,   y,       1/6*z;   3/6*x,   2/3*y,   0;
%         4/6*x,   0,       1/6*z;   4/6*x,   0,       5/6*z;   4/6*x,   1/3*y,   z;
%         4/6*x,   2/3*y,   z;       4/6*x,   y,       5/6*z;   4/6*x,   y,       1/6*z;
%         4/6*x,   2/3*y,   0;       5/6*x,   0,       1/6*z;   5/6*x,   0,       5/6*z;
%         5/6*x,   1/3*y,   z;       5/6*x,   2/3*y,   z;       5/6*x,   y,       5/6*z;
%         5/6*x,   y,       1/6*z;   5/6*x,   2/3*y,   0;       x,       1/3*y,   0;
%         x,       0,       1/6*z;   x,       0,       5/6*z;   x,       1/3*y,   z;
%         x,       2/3*y,   z;       x,       y,       5/6*z;   x,       y,       1/6*z;
%         x,       2/3*y,   0
%         ];
% 
%     % 3D points of mic placement along the tunnel
%     micPoints = [
%         0,       1/6*y,   1/12*z;   0,       0,       2/3*z;    0,       1/2*y,   z;
%         0,       y,       2/3*z;    0,       5/6*y,   1/12*z;   1/5*x,   1/6*y,   1/12*z;
%         1/5*x,   0,       2/3*z;    1/5*x,   1/2*y,   z;        1/5*x,   y,       2/3*z;
%         1/5*x,   5/6*y,   1/12*z;   2/5*x,   1/6*y,   1/12*z;   2/5*x,   0,       2/3*z;
%         2/5*x,   1/2*y,   z;        2/5*x,   y,       2/3*z;    2/5*x,   5/6*y,   1/12*z;
%         3/5*x,   1/6*y,   1/12*z;   3/5*x,   0,       2/3*z;    3/5*x,   1/2*y,   z;
%         3/5*x,   y,       2/3*z;    3/5*x,   5/6*y,   1/12*z;   4/5*x,   1/6*y,   1/12*z;
%         4/5*x,   0,       2/3*z;    4/5*x,   1/2*y,   z;        4/5*x,   y,       2/3*z;
%         4/5*x,   5/6*y,   1/12*z;   x,       1/6*y,   1/12*z;   x,       0,       2/3*z;
%         x,   1/2*y,   z;       x,   y,       2/3*z;   x,        5/6*y,   1/12*z;
%         0,       1/2*y,   1/2*z;    x,       1/2*y,   1/2*z
%     ];
% 
%     % Define the number of data points
%     numPoints = size(mic_data, 2);
% 
%     % Normalize the mic_data values between 0 and 1
%     norm_data = (mic_data - min(mic_data(:))) / (max(mic_data(:)) - min(mic_data(:)));
% 
%     figure;
% 
%     for i = ind1:round(((ind2 - ind1) / (fs / 100))):ind2
% 
%         if i > numel(mic_data(:,2))
%             continue;
%         end
% 
%         data = norm_data(i,:);
% 
%         % Perform the Fourier Transform on voltage data for each microphone
%         % Create the color map
%         cmap = hot(numPoints);
% 
%         % Map the pressure values to the color map
%         colorIndices = ceil(abs(fft(data)) * numPoints);
%         colorIndices = max(colorIndices, 1); % Ensure indices are not less than 1
%         colorIndices = min(colorIndices, numPoints); % Ensure indices are not greater than the colormap size
%         rgbValues = cmap(round(colorIndices), :)
% 
%         % Clear the previous plot
%         clf;
% 
%         % Plot the 3D surface mesh
%         shape = convhull(meshPoints(:, 1), meshPoints(:, 2), meshPoints(:, 3));
%         trisurf(shape, meshPoints(:, 1), meshPoints(:, 2), meshPoints(:, 3), 'FaceColor', 'black', 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);
% 
%         colormap(cmap);
%         colorbar;
% 
%         hold on;
% 
%         % % Convert RGB cell array to a 3D numeric array
%         % rgbNumeric = cell2mat(rgbValues);
% 
%         % Scatter the 3D points with color mapping based on frequencies
%         scatter3(micPoints(:, 1), micPoints(:, 2), micPoints(:, 3), 30, rgbValues, 'filled')
% 
%         % Set the axis labels and title
%         xlabel('X');
%         ylabel('Y');
%         zlabel('Z');
%         title(['Frequencies at Time ', num2str(i / fs)]);
% 
%         % Plot the source point
%         source_x = source(1) * x;
%         source_y = source(2) * y;
%         source_z = source(3) * z;
%         scatter3(source_x, source_y, source_z, 90, 'green', 'filled');
% 
%         hold off;
% 
%         % Update the plot
%         drawnow;
%     end
% end

function source_freq_surf_plot(filepath, time_start, time_end, source)

    % Load voltage data from the file
    load(filepath);

    final_output_data = final_output_data(2:end-1,:);
    mic_data = final_output_data(:, 2:end);
    time = final_output_data(:, 1);
    fs = round(1/(time(10)-time(9)));

    ind1 = time_start * fs + 1;
    ind2 = time_end * fs;

    mic_data = mic_data(ind1:ind2,:);
    mic_data = normalize(mic_data, "center", "mean");

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

    % Define the number of data points
    numPoints = size(mic_data, 2);

    % Normalize the mic_data values between 0 and 1
    norm_data = (mic_data - min(mic_data(:))) / (max(mic_data(:)) - min(mic_data(:)));

    figure;

    for i = ind1:round(((ind2 - ind1) / (fs / 100))):ind2

        if i > numel(mic_data(:, 2))
            continue;
        end

        data = norm_data(i, :);

        % Perform the Discrete Fourier Transform (DFT) on each microphone's data
        frequency_data = fft(data);

        % Calculate the frequency values corresponding to each DFT bin (in Hz)
        frequency_bins = (0:length(data)-1) * (fs / length(data));

        % Create the color map
        cmap = jet(numPoints);

        % Map the frequency values to the color map
        colorIndices = ceil(abs(frequency_data) * numPoints);
        colorIndices = max(colorIndices, 1); % Ensure indices are not less than 1
        colorIndices = min(colorIndices, numPoints); % Ensure indices are not greater than the colormap size
        rgbValues = cmap(round(colorIndices), :);

        % Clear the previous plot
        clf;

        % Set points with normalized value less than 0.5 to black
        blackIndices = data < 0.5;
        blackColor = [0, 0, 0];
        rgbValues(blackIndices, :) = repmat(blackColor, sum(blackIndices), 1);

        % Plot the 3D surface mesh
        shape = convhull(meshPoints(:, 1), meshPoints(:, 2), meshPoints(:, 3));
        trisurf(shape, meshPoints(:, 1), meshPoints(:, 2), meshPoints(:, 3), 'FaceColor', 'black', 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);

        colormap(cmap);
        colorbar;

        hold on;

        % Scatter the 3D points with color mapping based on frequency data
        scatter3(micPoints(:, 1), micPoints(:, 2), micPoints(:, 3), 30, rgbValues, 'filled')

        % Set the axis labels and title
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title(['Frequency Content at Time ', num2str(i / fs)]);

        % Plot the source point
        source_x = source(1) * x;
        source_y = source(2) * y;
        source_z = source(3) * z;
        scatter3(source_x, source_y, source_z, 90, 'green', 'filled');

        hold off;

        % Update the plot
        drawnow;
    end
end
