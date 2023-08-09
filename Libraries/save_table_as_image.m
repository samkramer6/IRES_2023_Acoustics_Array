function save_table_as_image(table_data, image_filename)
    % Assuming table_data is your large table with multiple rows and columns

    % Save the table as a tab-separated text file
    writetable(table_data, image_filename, 'Delimiter', '\t');

    disp(['Table saved as: ', image_filename]);
end
