function spectrogram_data(data_path,mic_num,time_start,time_end)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will be for finding the resonant
%   frequencies of the microphone data and confirming there is no noise
%   pollution into the data.
%
%   Sam Kramer
%   June 30th, 2023
%   
%   See also load_data and spectrogram_function
%

% --Load in data
    [data,~,fs] = load_data(data_path);

% --Select microphone of interest
    data = data(:,mic_num);

% --Finding Spectrogram
    try
        spectrogram_function_dB(data,fs,time_start,time_end)
    catch
        disp("Could not create spectrogram")
    end

end