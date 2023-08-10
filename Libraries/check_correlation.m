function correlation = check_correlation(truth_data_filepath, test_data_filepath)
    % Want function to determine the correlation between the two datasets
    truth_data = importdata(truth_data_filepath);
    truth_data = normalize(truth_data(2:end-1,2:end),'center','mean');

    test_data = importdata(test_data_filepath);
    test_data = normalize(test_data(2:end-1,2:end),'center','mean');


    values = zeros(1:32);
    skipped_indices = [1,7,16,25]; % Check

    for m=1:32
        if m == skipped_indices
            continue;
        end
        values[m] = var(test_data(:,m)) / var(truth_data(:,m));
    end
    correlation = mean(values);
end