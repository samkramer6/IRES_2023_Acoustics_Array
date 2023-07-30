function spectrogram_data(data_path,mic_num,time_start,time_end)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will be for finding the resonant
%   frequencies of the microphone data and confirming there is no noise
%   pollution into the data.
%
%   Sam Kramer
%   June 16th, 2023
%   
%   See also mic_check, and background_noise_test
%

% --Load in data
    load(data_path);

% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    mic_data = final_output_data(:,2:width(final_output_data));
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));

% --Find ind = 1
    ind1 = time_start*fs + 1;
    ind2 = time_end*fs;
    
% --Pull in data
    data = mic_data(ind1:ind2,mic_num);
    data = data - mean(data);

% --Finding Spectrogram
    spectrogram_function(filtered_data,fs,time_start,time_end)

end