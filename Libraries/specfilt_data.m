function specfilt_data(data,mic_num,time_start,time_end)
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
    mic_data = load(data);
    mic_data = mic_data.final_output_data;

% --Find ind = 1
    ind1 = find(mic_data(2:end-1,1) == time_start);
    ind2 = find(mic_data(2:end-1,1) == time_end);
    fs = 1/(mic_data(4,1) - mic_data(3,1));

% --Pull in data
    mic_num = mic_num + 1;
    data = mic_data(ind1:ind2,mic_num);

    data = data - mean(data);

% --Filter data
    filtered_data = filter_data(data,fs,80000,0.25,"False");

% --Finding Spectrogram
    figure()
    [s,f,t] = spectrogram(filtered_data, hamming(128), 124, [], fs,'yaxis');
        t = time_start:(1/length(t)):time_end;
        s = 20*log10(abs(s));
        s = s - max(s);
        imagesc(t,f,s)
        set(gca,"YDir","normal")
        clb = colorbar;
        clim([-60 0])
        title('Spectrogram of Data')
        xlabel('Time (s)');
        ylabel('Frequency (Hz)')
        clb.Title.String = "Power (dB)";

end