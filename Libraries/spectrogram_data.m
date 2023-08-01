function spectrogram_data(data_path,mic_num,time_start,time_end,type)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will be for finding the resonant
%   frequencies of the microphone data and confirming there is no noise
%   pollution into the data. There are options to have it in log or linear
%   scales
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
    type = upper(string(type));
    try
        if type == "LOG"
            spectrogram_function_dB(data,fs,time_start,time_end)
        elseif type == "LINEAR"
            spectrogram_function(data,fs,time_start,time_end)
        end

    catch
        disp("Could not create spectrogram")
    end

end