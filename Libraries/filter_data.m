function filtered_data = filter_data(test_data,filter_center,Fs)
% 
%   This is a function that will be used to filter the data for one 
%   microphone that is collected by the array. This filter will use a 4th 
%   order bandpass butterworth to filter the background noise out of the 
%   data. This will have a 15% band around the center filter frequency. 
%
%   Inputs: test_data   --  The raw test data for one mic
%           filter_center   --  The filter center of bandpass in Hz.
%           Fs  --  The sample frequency of the data.
%
%   Outputs: filtered_data -- The processed filtered data
%
%   Sam Kramer
%   June 19th, 2023
%

% --Develop filter band
    lower_filt = filter_center - 0.15*filter_center;
    upper_filt = filtere_center + 0.15*filter_center;
    filter_band = [lower_filt upper_filt] ./ (Fs/2);

% --Define filter used
    [B,A] = butter(4,filter_band);

% --Filter data and return
    filtered_data = filtfilt(B,A,test_data);
   
end

