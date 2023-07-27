%% Running Correlations to find chirps

% --Setup
    close all;
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\Bat_Trial_1";

% --Loading in new Dataset
    mic_number = 32;
    mic = mic_data(:,mic_number);
    mic = filter_data(mic,fs,120000,0.2,"false");

% --Cross correlate the dataset
    [correlated_data,lags] = xcorr(mic,filtered_model_chirp);
    time = (1/fs).*(-length(mic)+1:length(mic)-1);

% --Plot
    plot(time,correlated_data)
        xlim([0 max(time)-(1/fs)])
        xlabel("Approximate Test Time (s)")
        ylabel("Correlation")
        title("Correlation of mic 26 to the chirps")
        grid on

%{
    There appears to be a large correlation spike at the middle of the
    data set. This lag would correspond to a specific position within the
    dataset correlating to position by n*fs - 1/fs, so this would give us a
    position at roughly 2.951 seconds which is where the other spike was in
    the dataset in the first test. Lets look at the spectrogram now.
%}

% --Spectrogram data
    spectrogram_data(data_path,mic_number, 2.94, 2.96)

% --Plot out that section of the data
    %micmic = mic
    figure()
    plot(mic(fs*2.948:fs*2.96))
    