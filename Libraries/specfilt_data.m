function specfilt_data(data_location,mic_num,time_start,time_end)
%
%   This function will be used to find the spectrogram of the data once a
%   test has been completed. This will filter out noise from the system and
%   will be able to analyze tests properly to find chirp data. This has set
%   filter settings that cannot be changed unless the code is adjusted.
%
%   Sam Kramer
%   July 14th, 
%   
%   See also filter_data, spectrogram_data
%

% --Load in data
    load(data_location);

% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    mic_data = final_output_data(:,2:end);
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));

% --Find ind = 1
    ind1 = time_start*fs + 1;
    ind2 = time_end*fs;
    
% --Pull in data
    mic_num = mic_num + 1;
    data = mic_data(ind1:ind2,mic_num);
    data = data - mean(data);

% --Filter data
    filtered_data = filter_data(data,fs,80000,0.33,"False");

% --Finding Spectrogram
    figure()
    [s,f,t] = spectrogram(filtered_data, hamming(128), 124, [], fs,'yaxis');
        t = time_start:(1/length(t)):time_end;
        s = 20*log10(abs(s));
        s = s - max(s);
        imagesc(t,f,s)
        set(gca,"YDir","normal")
        clb = colorbar;
        colormap("jet")
        clim([-60 0])
        title('Filtered Spectrogram of Data')
        xlabel('Time (s)');
        ylabel('Frequency (Hz)')
        clb.Title.String = "Power (dB)";

end