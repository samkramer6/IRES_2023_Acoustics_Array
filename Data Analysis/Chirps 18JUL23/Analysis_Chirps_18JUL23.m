%% Data Analysis For chirp data from 18JUL23
%{
    This is the data analysis script that is for the analysis of the data
    from the chirps sent into the array on the 18th of July, 2023. The main
    purpose is to see if there is quality chirp data moving through the
    array that is created by the Batbot from a distance of 0.5 meters.

    Sam Kramer
    July 18th, 2023
%}

% --Setup
    clear; clc; format compact; close all;

% --Load in data
    load('C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 18JUL2023\Chirps_2.mat');
    
% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    data = final_output_data(:,2:end);
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));
    
% --Plot data and appended data
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,26));
        title('Original signal from mic 26');
        subtitle('Entire Signal')
        ylabel('Amplitude (V)')
        xlim([0 max(time)])

    subplot(3,1,2)
    plot(time,data(:,26))
        ylabel('Amplitude (V)')
        subtitle('Appended Signal')
        xlim([0 1])

% --Filter signal
    filtered_data = filter_data(data(:,26),fs,80000,0.5,"true");

    figure(1)
    subplot(3,1,3)
    plot(time,filtered_data)
        xlabel('Time (s)')
        subtitle('Filtered Signal')

% --Spectrogram of data
    data_location = 'C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 18JUL2023\Chirps_2.mat';
    spectrogram_data(data_location,26,2.96,2.975);
    title('Spectrogram of chirps from 13July2023 Test')

    