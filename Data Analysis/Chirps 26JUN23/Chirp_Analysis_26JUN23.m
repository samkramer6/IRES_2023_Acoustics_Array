% --Setup code
    clear; clc; format compact; close all;

% --Load data
    load('C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Validation Data\Testing 26JUN23\Chirps.mat');

% --Reformat data
    data = Dev1_3.Dev1_ai1;
    time = seconds(Dev1_3.Time);

% --Crop data length
%     data = data(290000:end,1);
%     data = data(21000:23000,1);
%     time = time(290000:end,1);
%     time = time(21000:22500,1);

% --Zero_mean
    data = data - mean(data);

% --Calculate fs
    fs = 1/(time(10,1) - time(9,1));

% --Plot initial data
    plot(data)

% --Take fft
    fft_data = fft(data);
    fft_data_mag = abs(fft_data);
    fft_data_amp = 2*fft_data_mag/length(data);

    L = length(data);
    T = max(time);
    frequency = (1/T).*(0:(1/T):fs)';

% --Plot FFT
    figure(3)
    plot(fft_data_amp)

% --Design Filter
    Wn = 120000/fs;
    Wn2 = 125000/fs;
    %Wn = [Wn1 Wn2];
    [B,A] = butter(9,Wn,'High');
    
    figure(4)
    freqz(B,A,[],fs)

% --Filter out signal
    filterd_data = filtfilt(B,A,data);

    figure(2)
    plot(filterd_data)

% --Taking fft of filtered data
    fft_filt_data = fft(filterd_data);
    fft_filt_data_mag = abs(fft_filt_data);
    fft_filt_data_amp = 2*fft_filt_data_mag/length(filterd_data);
    
% --FFT plot of filtered data
    figure(5)
    plot(fft_filt_data_amp)

% --Spectrogram of the filtered data
    figure(6)
    [s,f,t] = spectrogram(filterd_data, hamming(128), 124, [], fs,'yaxis');
        s = 20*log10(abs(s));
        s = s - max(s);
        imagesc(t,f,s)
        clb = colorbar;
        clim([-60 0])
        set(gca,"YDir","normal")
        title('Spectrogram of Data')
        xlabel('Time (s)');
        ylabel('Frequency (Hz)')
        clb.Title.String = "Power (dB)";
