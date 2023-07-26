%% Data Analysis on Bat Flight Data
%{
    This is an analysis script on the flight data that we took on the 20th
    of July 2023, it is meant to help us see the chirps that were collected
    from the data set. The main goal is to produce spectrograms for the
    machine learning models. 

    Sam Kramer
    July 26th, 2023
%}

%% Trial 2

% --Setup
    clear; clc; format compact; close all; warning off;
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\Bat_Trial_2";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MIC 32 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --First Chirp Isolated
    spectrogram_data(data_path,32,2.948,2.96)

% --Another Isolated
    spectrogram_data(data_path,32,2.93,2.94)

% --Another Isolated
    spectrogram_data(data_path,32,2.445,2.455)

% --Another Isolated
    spectrogram_data(data_path,32,2.428,2.438)

% --Double Isolated Chirps
    spectrogram_data(data_path,32,0.4,0.44)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mic 26 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% --First chirp
    spectrogram_data(data_path,mic_number,3.12,3.14)

% --Second chirp
    spectrogram_data(data_path,mic_number,3.02,3.03)

% --Third Chirp
    spectrogram_data(data_path,mic_number,3.5,3.51)

% --Fourth Chirp
    spectrogram_data(data_path,mic_number,2.83,2.84)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mic 28 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --First Chirp
    
    
%% Running Correlations to find chirps
% --Loading in new Dataset
    mic_number = 28;
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
    spectrogram_data(data_path,mic_number,2.94,2.96)

% --Plot out that section of the data
    %micmic = mic
    figure()
    plot(mic(fs*2.948:fs*2.96))
    

%% Creating a Model Chirp for Correlation data
%{
    This filtered model chirp is located within the libraries
    folder and is mainly used for running correlations versus the
    data. Please refer to documentation for how to use it in future data
    analysis scripts
    
    Sam Kramer
    July 26th, 2023
%}

% --Pulling out the data to create a "Model Chirp" from first chirp
    [mic_data,~,fs] = load_data(data_path);

% --Model Chirp
    model_chirp = mic_data(2.951*fs:2.96*fs,32);

% --Filter out the model chirp
    filtered_model_chirp = filter_data(model_chirp,fs,120000,0.2,"false");
