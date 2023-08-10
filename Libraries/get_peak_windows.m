function peak_windows = get_peak_windows(data, sample_rate)
    %{
      Input:
      n by mic_number voltage by time dataset
      sample_rate of dataset in Hertz

      Output:
      peak_windows{mic_number, 1} = time by peaks matrix
      peak_windows{mic_number, 2} = voltage by peaks matrix

      Edited by Nicholas Rock 7/6/23
    %}

    time = 1:(size(data(:,1)));
    number_mics = size(data, 2);

    % Polling back 1 ms and forward 5 ms
    window_duration = round(0.006 * sample_rate) + 1;

    % Initialize empty cell arrays for storing peaks and time values
    peak_windows = cell(number_mics, 2);

    if number_mics < 28
        skipped_indices = []; % REMOVE ONCE SONAR DATA TAKEN
    else
        % ai_0 mics
        skipped_indices = [1, 9, 17, 25];
    end
    
    for i = 1:number_mics
        if ismember(i, skipped_indices)
            peak_windows{i,1} = 0; 
            peak_windows{i,2} = 0;
            continue;
        end

        % Find peaks in data for the current microphone.
        
        % Calculate the maximum value in the data
        max_value = max(data(:, i));
        
        % Define the fraction or multiple of the maximum value for the minimum peak height
        min_peak_height_ratio = 0.90;  % Adjust this value as needed
        
        % Calculate the minimum peak height based on the maximum value
        min_peak_height = min_peak_height_ratio * max_value;

        [peaks, peak_indices] = findpeaks(data(:, i), 'MinPeakDistance', round(0.005 * sample_rate), 'MinPeakHeight',  min_peak_height);

        % Preallocate arrays for each microphone based on the number of peaks found
        peak_window_mic = zeros(window_duration, numel(peaks));
        time_values_mic = zeros(window_duration, numel(peaks));

        for j = 1:numel(peaks)
            % Start 1 ms before the chirp and continue for 5 ms after
            window_start = peak_indices(j) - round(0.001 * sample_rate);
            window_end = peak_indices(j) + round(0.005 * sample_rate);

            % Check if the window indices are within the data range
            if window_start >= 1 && window_end <= numel(data(:, i))
                % Assign values to the peak and time arrays
                peak_window_mic(:, j) = data(window_start:window_end, i); % pressure values by peak #
                time_values_mic(:, j) = time(window_start:window_end); % Subtract 1 to start from 0 time, % time values by peak #
            end
        end

        % Store the peak and time arrays in the cell array
        peak_windows{i,1} = time_values_mic / sample_rate * 1000; 
        peak_windows{i,2} = peak_window_mic;
    end
end