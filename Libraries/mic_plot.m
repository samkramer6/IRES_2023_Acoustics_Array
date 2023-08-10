% function points_table = mic_plot(spacing)
%     % Define the center point of the octagon
%     x0 = 0;
%     y0 = 0;
% 
%     % Radius of the octagon
%     r = 1;
% 
%     % Create a figure
%     figure;
% 
%     % Calculate the maximum number of points that can fit on one side of the octagon
%     num_points_per_side_x = floor(2 * r / spacing(1));
%     num_points_per_side_y = floor(2 * r / spacing(2));
% 
%     % Calculate the actual spacing between points to maximize the number of points within the octagon
%     actual_spacing_x = 2 * r / num_points_per_side_x;
%     actual_spacing_y = 2 * r / num_points_per_side_y;
% 
%     % Plot the octagon
%     angles = (0:7) * pi/4 + pi/8;
%     x_octagon = x0 + r * cos(angles);
%     y_octagon = y0 + r * sin(angles);
%     plot([x_octagon, x_octagon(1)], [y_octagon, y_octagon(1)], 'b-', 'LineWidth', 2);
%     hold on;
% 
%     % Initialize arrays to store points within the octagon
%     points_x = [];
%     points_y = [];
% 
%     % Loop to add points within the octagon
%     for i = 1:num_points_per_side_y
%         y_shift = -r + (i - 1) * actual_spacing_y;
%         for j = 1:num_points_per_side_x
%             x_shift = -r + (j - 1) * actual_spacing_x;
%             x_point = x0 + x_shift;
%             y_point = y0 + y_shift;
% 
%             % Check if the point is within the octagon
%             if inpolygon(x_point, y_point, x_octagon, y_octagon)
%                 points_x = [points_x; x_point];
%                 points_y = [points_y; y_point];
%                 plot(x_point, y_point, 'k.', 'MarkerSize', 10);
%             end
%         end
%     end
% 
%     % Set the axis limits to include the complete octagon and points
%     axis equal;
%     axis off;
% 
%     % Add labels and title
%     xlabel('X');
%     ylabel('Y');
%     title('Mic Array');
% 
%     % Create a table with the points within the octagon
%     points_table = table(points_x, points_y, 'VariableNames', {'Y [m]', 'Z [m]'});
% end

% function points_table = mic_plot(spacing)
%     % Define the center point of the octagon
%     x0 = 0;
%     y0 = 0;
% 
%     % Radius of the octagon
%     r = 1;
% 
%     % Create a figure
%     figure;
% 
%     % Calculate the maximum number of points that can fit on one side of the octagon
%     num_points_per_side_x = floor(2 * r / spacing(1));
%     num_points_per_side_y = floor(2 * r / spacing(2));
% 
%     % Calculate the actual spacing between points to maximize the number of points within the octagon
%     actual_spacing_x = 2 * r / num_points_per_side_x;
%     actual_spacing_y = 2 * r / num_points_per_side_y;
% 
%     % Plot the octagon
%     angles = (0:7) * pi/4 + pi/8;
%     x_octagon = x0 + r * cos(angles);
%     y_octagon = y0 + r * sin(angles);
%     plot([x_octagon, x_octagon(1)], [y_octagon, y_octagon(1)], 'b-', 'LineWidth', 2);
%     hold on;
% 
%     % Initialize arrays to store points within the octagon
%     points_x = [];
%     points_y = [];
% 
%     % Loop to add points within the octagon
%     for i = 1:num_points_per_side_y
%         y_shift = -r + (i - 1) * actual_spacing_y;
%         for j = 1:num_points_per_side_x
%             x_shift = -r + (j - 1) * actual_spacing_x;
%             x_point = x0 + x_shift;
%             y_point = y0 + y_shift;
% 
%             % Check if the point is within the octagon
%             if inpolygon(x_point, y_point, x_octagon, y_octagon)
%                 points_x = [points_x; x_point];
%                 points_y = [points_y; y_point]; % No need to invert y-coordinate
%                 plot(x_point, y_point, 'k.', 'MarkerSize', 10);
%             end
%         end
%     end
% 
%     % Set the axis limits to include the complete octagon and points
%     axis([0 1.6 0 1.96]);
%     axis equal;
%     axis off;
% 
%     % Add labels and title
%     xlabel('X');
%     ylabel('Y');
%     title('Mic Array');
% 
%     % Rescale the points to run from 0 to 1.6 in x and 0 to 1.96 in y
%     points_x = (points_x + 1) * 0.8; % Scale x-coordinates to run from 0 to 1.6
%     points_y = (points_y + 1) * 0.98; % Scale y-coordinates to run from 0 to 1.96
% 
%     % Create a table with the points within the octagon (including adjusted y-coordinates)
%     points_table = table(points_x, points_y, 'VariableNames', {'Y [m]', 'Z [m]'});
% end

function points_table = mic_plot(spacing)
    % Define the center point of the octagon
    x0 = 0;
    y0 = 0;

    % Radius of the octagon
    r = 1;

    % Create a figure
    figure;

    % Calculate the maximum number of points that can fit on one side of the octagon
    num_points_per_side_x = floor(2 * r / spacing(1));
    num_points_per_side_y = floor(2 * r / spacing(2));

    % Calculate the actual spacing between points to maximize the number of points within the octagon
    actual_spacing_x = 2 * r / num_points_per_side_x;
    actual_spacing_y = 2 * r / num_points_per_side_y;

    % Plot the octagon
    angles = (0:7) * pi/4 + pi/8;
    x_octagon = x0 + r * cos(angles);
    y_octagon = y0 + r * sin(angles);
    plot([x_octagon, x_octagon(1)], [y_octagon, y_octagon(1)], 'b-', 'LineWidth', 2);
    hold on;

    % Initialize arrays to store points within the octagon
    points_x = [];
    points_y = [];

    % Loop to add points within the octagon
    for i = 1:num_points_per_side_y
        y_shift = -r + (i - 1) * actual_spacing_y;
        for j = 1:num_points_per_side_x
            x_shift = -r + (j - 1) * actual_spacing_x;
            x_point = x0 + x_shift;
            y_point = y0 + y_shift;

            % Check if the point is within the octagon
            if inpolygon(x_point, y_point, x_octagon, y_octagon)
                points_x = [points_x; x_point];
                points_y = [points_y; y_point];
                plot(x_point, y_point, 'k.', 'MarkerSize', 10);
            end
        end
    end

    % Set the axis limits to include the complete octagon and points
    axis equal;
    axis off;

    % Add labels and title
    xlabel('X');
    ylabel('Y');
    title('Mic Array');

    % Rescale the points to run from 0 to 1.6 in x and 0 to 1.96 in y
    points_x = (points_x + 1) * 0.8; % Scale x-coordinates to run from 0 to 1.6
    points_y = (points_y + 1) * 0.98; % Scale y-coordinates to run from 0 to 1.96

    % Create a table with the points within the octagon (including adjusted y-coordinates)
    points_table = table(points_x, points_y, 'VariableNames', {'X', 'Y'});
end