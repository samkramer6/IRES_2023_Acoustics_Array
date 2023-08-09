% function [time_values, peak_values] = peak_windows(data, sample_rate)
%     % Data is a n by 33 sized dataset
% 
%     % Format and assign data
%     data = data(2:end-1,2:33);
%     data = normalize(data, "center", "mean"); % Center data at 0 V
% 
%     number_mics = size(data,2) - 1;
% 
%     % Find peaks in data taken at a sample_rate that are at least 5 ms apart
%     % and 0.2 V in amplitude (determined empirically)
%     [peaks, peak_indices] = findpeaks(data, 'MinPeakDistance', round(0.005 * sample_rate), 'MinPeakHeight', 0.2);
% 
%     % Preallocate the peak_windows array
%     window_duration = round(0.006 * sample_rate) + 1;
%     peak_values = zeros(numel(peaks), window_duration, number_mics);
% 
%     % Create the time values for each sample in peak_windows
%     time_values = zeros(numel(peaks), window_duration, number_mics);
% 
%     for i = 1:number_mics
%         for j = 1:numel(peaks)
%             % Start 1 ms before the chirp and continue for 5 ms after
%             window_start = peak_indices(j) - round(0.001 * sample_rate);
%             window_end = peak_indices(j) + round(0.005 * sample_rate);
% 
%             % Check if the window indices are within the data range
%             if window_start >= 1 && window_end <= size(data,1)
%                 % Pull out pressure values from data
%                 peak_values(j, :, i) = data(window_start:window_end, i)';
% 
%                 % Calculate the time values for the corresponding samples,
%                 % in ms
%                 time_values(j, :, i) = (window_start:window_end) / sample_rate * 1000;
%             end
%         end
%     end
%     % Return time_values of shape (peak number, x_value in data) and 
%     % peak_windows of shape (peak number, y_value in data)
% end

