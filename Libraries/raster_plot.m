function points_table = raster_plot(spacing)
    % Define the center point of the shape
    x0 = 0;
    y0 = 0;

    shape_points = [0.76, 0; 0.76, 0.39; 0, 0.98; 0, 2.34; 0.76, 2.91;
        1.76, 2.91; 2.52, 2.34; 2.52, 0.98; 1.76, 0.39; 1.76, 0; 0.76, 0]; 

    figure;

    % Calculate the bounding box of the shape
    min_x = min(shape_points(:, 1));
    max_x = max(shape_points(:, 1));
    min_y = min(shape_points(:, 2));
    max_y = max(shape_points(:, 2));

    % Calculate the maximum number of points that can fit on one side of the shape
    num_points_per_side_x = floor((max_x - min_x) / spacing(1));
    num_points_per_side_y = floor((max_y - min_y) / spacing(2));

    % Calculate the actual spacing between points to maximize the number of points within the shape
    actual_spacing_x = (max_x - min_x) / num_points_per_side_x;
    actual_spacing_y = (max_y - min_y) / num_points_per_side_y;

    % Plot the shape
    plot(shape_points(:, 1), shape_points(:, 2), 'b-', 'LineWidth', 2);
    hold on;

    % Initialize arrays to store points within the shape
    points_x = [];
    points_y = [];

    % Loop to add points within the shape
    for i = 1:num_points_per_side_y
        y_shift = min_y + (i - 1) * actual_spacing_y;
        for j = 1:num_points_per_side_x
            x_shift = min_x + (j - 1) * actual_spacing_x;
            x_point = x0 + x_shift;
            y_point = y0 + y_shift;

            % Check if the point is within the shape using inpolygon
            if inpolygon(x_point, y_point, shape_points(:, 1), shape_points(:, 2))
                if x_point ~= 0 && y_point ~= 0 
                    points_x = [points_x; x_point];
                    points_y = [points_y; y_point];
                    plot(x_point, y_point, 'k.', 'MarkerSize', 10);
                end
            end
        end
    end

    % Set the axis limits to include the complete shape and points
    axis equal;
    axis off;

    % Add labels and title
    xlabel('Y [m]');
    ylabel('Z [m]');
    title('X Slice');

    % Create a table with the points within the shape (including adjusted coordinates if needed)
    points_table = table(points_x, points_y, 'VariableNames', {'Y [m]', 'Z [m]'});
end