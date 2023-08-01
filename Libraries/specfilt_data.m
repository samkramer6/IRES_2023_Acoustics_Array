function specfilt_data(data_path,mic_num,time_start,time_end)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will filter out noise from the system and
%   will be able to analyze tests properly to find chirp data. This has set
%   filter settings that cannot be changed unless the code is adjusted. The
%   center is set to 80kHz and has a width of 0.25.
%
%   Sam Kramer
%   July 14th, 
%   
%   See also filter_data, spectrogram_data
%

% --Load in data
    [data,~,fs] = load_data(data_path);

% --Pick out single mic
    data = data(:,mic_num);

% --Filter data
    try
        filtered_data = filter_data(data,fs,80000,0.25,"False");
    catch
        fprintf("Issue Filtering Data \n");
        filtered_data = data;
    end

% --Finding Spectrogram
    spectrogram_function_dB(filtered_data,fs,time_start,time_end)
    
end