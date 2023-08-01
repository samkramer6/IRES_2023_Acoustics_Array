%% Data Analysis on Bat Flight Data
%{
    This is an analysis script on the flight data that we took on the 20th
    of July 2023, it is meant to help us see the chirps that were collected
    from the data set. The main goal is to produce spectrograms for the
    machine learning models. 

    Sam Kramer
    July 26th, 2023
%}

%% Trial 1
%{
    This is the analysis for the Bat 1 and trial 1. There is video data for
    this trial.

    Sam Kramer
    July 26th, 2023
%}



%% Trial 2
%{
    These are the spectrograms for all the data collected from Trial 2.
    This is from Bat 1 and we have video for this trial.

    Sam Kramer
    July 26th, 2023
%}

% --Setup
    clear; clc; format compact; close all; warning off;
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\Bat1_Trial2_20JUL2023.mat";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MIC 32 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% --First Chirp Isolated
    spectrogram_data(data_path,32,2.948,2.96)

%% --Another Isolated
    spectrogram_data(data_path,32,2.93,2.94)

%% --Another Isolated
    spectrogram_data(data_path,32,2.445,2.455)

% --Another Isolated
    spectrogram_data(data_path,32,2.428,2.438)

% --Double Isolated Chirps
    spectrogram_data(data_path,32,0.4,0.44)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mic 26 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% --First chirp
    spectrogram_data(data_path,26,3.12,3.14)

% --Second chirp
    spectrogram_data(data_path,26,3.02,3.03)

% --Third Chirp
    spectrogram_data(data_path,26,3.5,3.51)

% --Fourth Chirp
    spectrogram_data(data_path,26,2.83,2.84)
    
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

%%
for i = 0:0.015:0.5
        spectrogram_data(data_path,32,i,i+0.02,"linear");
end