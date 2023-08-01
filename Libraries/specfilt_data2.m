function specfilt_data2(data_path,mic_num,time_start,time_end,filt_center)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will filter out noise from the system and
%   will be able to analyze tests properly to find chirp data. This has set
%   filter settings aside from the filter center which is an input value.
%   This can be changed but not the width which is set. This has a width of
%   0.25.
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
        filtered_data = filter_data(data,fs,filt_center,0.25,"False");
    catch
        fprintf("Issue Filtering Data \n");
        filtered_data = data;
    end

% --Finding Spectrogram
    spectrogram_function_dB(filtered_data,fs,time_start,time_end)
end