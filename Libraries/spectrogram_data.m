function spectrogram_data(data,mic_num,time_start,time_end)
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

% --Finding Spectrogram
    figure()
    [s,f,t] = spectrogram(data, hamming(128), 124, [], fs,'yaxis');
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