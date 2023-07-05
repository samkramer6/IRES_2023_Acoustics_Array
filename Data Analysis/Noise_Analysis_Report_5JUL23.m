%% Signal Noise Analysis
%{
    This is the code that was used to analyze the noise from the system
    that was appearing within the system. The main idea is to understand
    the main frequencies that the noise operates at.

    Sam Kramer
    5 July 23
%}

% --Setup data
    clc; format compact; close all;

% --Load in data
    load("Dev1_2.mat");

% --Reformat data
    time = seconds(Dev1_2.Time);
    data = Dev1_2.Dev1_ai1;

% --Zero Mean Dataset
    data = data - mean(data);

% --Plot raw data
    figure(1)
    subplot(2,1,1)
    plot(time,data)
        xlim([0 0.1])
        ylabel('Amplitude (V)')
        title('Analysis of Unfiltered Signal');
        subtitle('Raw Unfiltered Signal');
        xlabel('Time (s)')
        ylim([-0.06 0.06])
        hold on
        grid on

% --FFT setup
    T = max(time);
    fs = 1/(time(10)-time(9));

% --Take fourier transform of data
    fft_data = fft(data);
    fft_data_mag = abs(fft_data);
    fft_data_amp = 2*fft_data_mag/length(data);

% --Define Frequencies
    frequencies = (1/T)*(0:(1/T):(fs))';

% --Plot fft
    figure(1)
    subplot(2,1,2)
    plot(frequencies,fft_data_amp)
        xlim([0 fs/2]);
        subtitle('Fourier Transform of Pure Noise')
        ylabel('Amplitude')
        xlabel('Frequency (Hz)')
        hold on
        grid on

%% Develop a noise filtering system
%{
    This section will mainly focus on making a filter that will be useful
    for removing the primary harmonics of the signal. 

    Sam Kramer
    5 July 2023
%}

% --First try a O9 Highpass
    wn = 2*50000/fs;
    [B,A] = butter(9,wn,"high");

% --Filter response
    figure(3)
    freqz(B,A,[],fs)
    title('Frequency Response of Highpass')

% --Filter data
    filtered_data = filtfilt(B,A,data);

% --Plot filtered data
    figure(2)
    subplot(2,1,1)
    plot(time,filtered_data)
        xlim([0 0.1])
        subtitle('Filtered Signal')
        ylim([-0.06 0.06])
        ylabel('Amplitude (V)')
        xlabel('Time (s)')
        hold on
        grid on
        title('Analysis of Highpass Filter')

% --FFT of filtered Data
    fft_filt_data = fft(filtered_data);
    fft_filt_data_mag = abs(fft_filt_data);
    fft_filt_data_amp = 2*fft_filt_data_mag/length(fft_filt_data_mag);

% --Plot Data
    figure(2)
    subplot(2,1,2)
    plot(frequencies, fft_filt_data_amp)
        xlabel('Frequency (Hz)')
        ylabel('Amplitude')
        hold on
        grid on
        subtitle('FFT of Highpass signal')
        xlim([0 fs/2])

% --Second try at a bandpass filter on the data
    wn = [(2*50000/fs), (2*175000/fs)];
    [B,A] = butter(4,wn,"Bandpass");

% --Show filter Response
    figure(4)
    freqz(B,A,[],fs)
    title('Frequency Response of Bandpass')

% --Filter Data
    filtered_data = filtfilt(B,A,data);

% --Plot filtered Data
    figure(5)
    subplot(2,1,1)
    plot(time,filtered_data)
        grid on
        hold on
        xlabel('Time (s)')
        xlim([0 0.1])
        ylabel('Amplitude (V)')
        ylim([-0.06 0.06])
        title('Analysis of Bandpass Filter')
        subtitle('Filtered Signal')

% --Taking DFT of filtered data
    fft_filt_data = fft(filtered_data);
    fft_filt_data_mag = abs(fft_filt_data);
    fft_filt_data_amp = 2*fft_filt_data_mag/length(data);

% --Plotting DFT of filtered data
    subplot(2,1,2)
    plot(frequencies,fft_filt_data_amp)
        hold on
        grid on
        xlabel('Frequency (Hz)')
        ylabel('Amplitude')
        xlim([0 fs/2])
    
    
