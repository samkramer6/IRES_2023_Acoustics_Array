%% Running Correlations to find chirps

% --Setup
    close all;
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\Bat1_Trial2_20JUL2023.mat";
    [mic_data,time,fs] = load_data(data_path);

    filtered_model_chirp = load("Array Acoustics\Libraries\Hippo_example_chirp.mat");
    filtered_model_chirp = filtered_model_chirp.model_chirp;

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
    