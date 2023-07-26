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

% --Pulling out the data to create a "Model Chirp" from first chirp
    load(data_path)
    final_output_data = final_output_data(2:end-1,:);
    mic_data = final_output_data(:,2:width(final_output_data));
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));

% --Model Chirp
    model_chirp = mic_data(2.951*fs:2.96*fs,32);

% --Filter out the model chirp
    filtered_model_chirp = filter_data(model_chirp,fs,120000,0.2,"false");

%{
    This filtered model chirp is located within the libraries
    folder and is mainly used for running correlations versus the
    data. Please refer to documentation for how to use it in future data
    analysis scripts
    
    Sam Kramer
    July 26th, 2023
%}


% --Model
