function linearize_peaks_batbot2(filepath, filter)
    % --Load in data
    load(filepath);  % Assuming the data is stored in a variable named 'final_output_data'

    % --Reformat data
    mic_data = final_output_data(2:end-1, 2:end);
    mic_data = normalize(mic_data, "center", "mean");
    time = final_output_data(2:end-1, 1);
    fs = round(1 / (time(10) - time(9)));
    number_mics = size(mic_data, 2);

    % Filter data if wanted
    if filter == "true"
        mic_data = filter_data_batbot(mic_data, fs, 55000, 0.4, "false");
    end

    skipped_indices = [1, 9, 17, 25, 31];

    figure;
    plot(time, zeros(size(time)), 'k-')
    hold on;

    for m = 1:number_mics
        if ismember(m, skipped_indices)
            continue;
        end

        % Initialize arrays to store peaks and peak times for each segment
        num_segments = round(fs / 2500);
        mic_peaks = zeros(num_segments, 1);
        mic_peak_times = zeros(num_segments, 1);

        % Loop over segments
        for t = 1:num_segments
            % Determine the start and end indices for the current segment
            start_index = 1 + (t - 1) * round(numel(time) / num_segments);
            end_index = t * round(numel(time) / num_segments);

            % Find peaks and peak times for the current segment
            [peak, peak_index] = max(mic_data(start_index:end_index, m));
            mic_peaks(t) = peak;
            mic_peak_times(t) = start_index - 1 + peak_index;
        end
        

        for j = 1:length(mic_peak_times) - 1
            plot([time(mic_peak_times(j)), time(mic_peak_times(j+1))], [(m*m)* mic_peaks(j), (m*m)* mic_peaks(j+1)], 'b-')
        end


    end
    % qa_test(mic_data,55000,fs)
    title(sprintf('Mics', m))
    xlabel('Time [s]')
    ylabel('Amplitude [V]')
    xlim([0 10])
    hold off;
end
