function mic_plot(mics)
    % Define the center point of the first octagon
    x0 = 0;
    y0 = 0;

    % Radius of the octagon
    r = 1;

    % Number of octagons in each row
    numOctagonsPerRow = 3;

    % Spacing between octagons
    spacing = r * 1.2; % Adjust as desired

    % Create a figure
    figure;

    % Initialize the highlight vertex index
    highlightIndex = 1;

    % Loop to plot each octagon
    for i = 1:(2*numOctagonsPerRow)
        % Calculate the x-coordinate shift for each octagon
        xShift = mod(i-1, numOctagonsPerRow) * (spacing + 2*r);

        % Calculate the y-coordinate shift for each octagon
        yShift = -fix((i-1) / numOctagonsPerRow) * (spacing + 2*r);

        % Calculate the coordinates of each vertex of the octagon
        angles = (0:7) * pi/4 + pi/8; % Adjust the angle offset
        x_octagon = x0 + xShift + r * cos(angles);
        y_octagon = y0 + yShift + r * sin(angles);

        % Plot the octagon
        plot([x_octagon, x_octagon(1)], [y_octagon, y_octagon(1)], 'b-', 'LineWidth', 2);
        hold on;

        % Plot a black point at the origin for octagons 1 and 6
        if i == 1
            plot(x0 + xShift, y0 + yShift, 'k.', 'MarkerSize', 10);
            text(x0 + xShift, y0 + yShift, '31', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12);
        if mics(7) == 31
            plot(x0 + xShift, y0 + yShift, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
        end
        elseif i == 6
            plot(x0 + xShift, y0 + yShift, 'k.', 'MarkerSize', 10);
            text(x0 + xShift, y0 + yShift, '32', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12);
        if mics(7) == 32
            plot(x0 + xShift, y0 + yShift, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
        end
        end

        % Calculate the coordinates of each vertex of the pentagon
        angles_pentagon = (0:4) * 2*pi/5 + pi/10; % Adjust the angle offset
        x_pentagon = x0 + xShift + r * cos(angles_pentagon);
        y_pentagon = y0 + yShift + r * sin(angles_pentagon);

        % Plot the pentagon vertices as black points
        plot(x_pentagon, y_pentagon, 'k.', 'MarkerSize', 10);

        % Highlight the specified vertex for each pentagon
        if mics(highlightIndex) ~= 0
            highlightVertex = mics(highlightIndex)-5*(i-1);
            highlightX = x_pentagon(mod(highlightVertex-2, 5) + 1);
            highlightY = y_pentagon(mod(highlightVertex-2, 5) + 1);
            plot(highlightX, highlightY, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
        end

        % Calculate the label positions
        labelOffset = 0.25; % Adjust the offset as desired
        labelX = x_pentagon + labelOffset * (x_pentagon - mean(x_pentagon));
        labelY = y_pentagon + labelOffset * (y_pentagon - mean(y_pentagon));

        % Calculate the pentagon label
        pentagonLabel = (i-1)*5 + mod((1:5), 5) + 1;

        % Add labels to the vertices
        for j = 1:numel(x_pentagon)
            text(labelX(j), labelY(j), sprintf('%d', pentagonLabel(j)), 'HorizontalAlignment', 'center');
        end

        % Label the octagon
        text(x0 + xShift, y0 + yShift - r - 0.2, sprintf('Ring %d', i), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12, 'FontWeight', 'bold');

        % Update the highlight index
        highlightIndex = highlightIndex + 1;
        if highlightIndex > numel(mics)
            highlightIndex = 1;
        end
    end

    % Set the axis limits to include the complete octagons and pentagons
    axis equal; axis off;

    % Add labels and title
    xlabel('X');
    ylabel('Y');
    title('Mic Array');
end