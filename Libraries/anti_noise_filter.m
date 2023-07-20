function filtered_data = anti_noise_filter(data_path,mic_number)
%
%   This function will be used to completely filter out all the noise from
%   the DAQ. We already know the noise that comes from the DAQ, that has
%   been quantified already, however, we know that the noise comes in at
%   very specific frequencies and can be seen every hundreth of a second.
%   The signal is highly periodic and we know exactly when it will be at
%   what frequency band. This filter set will filter out that noisy
%   signal. This should be used for cleaning up the waveform, perhaps the
%   spectrogram of the signal may not be as good.
%
%   Sam Kramer
%   July 20th, 2023

% --load in data set
    load(data_path);

% --Format data
   data = final_output_data(2:length(final_output_data)-1, 2:width(final_output_data));
    time = final_output_data(2:length(final_output_data)-1 ,1);
    fs = round(1/(time(10)-time(9)));

% --Define filter
    [b,a] = cheby1(3,5,[118500/250000 121500/250000],'stop');

% --Filter Data
    filtered_data = filtfilt(b,a,data(:,mic_number));
    
end