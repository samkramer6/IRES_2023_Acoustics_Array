%% Noise Analysis
%{
    This is meant to be an analysis script to understand how the noise of
    the system can be systematically removed from our data. We know that
    the data appears periodically and we know exactly what frequencies it
    appears at. 

    Sam Kramer
    July 20th, 2023
%}

% --Setup
    clear; clc; format compact; close all;

% --Load in data
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\raw_noise_20JUL23.mat";
    load(data_path)

% --Reformat data
    data = final_output_data(2:length(final_output_data)-1, 2:width(final_output_data));
    time = final_output_data(2:length(final_output_data)-1 ,1);
    fs = round(1/(time(10)-time(9)));
    
% --Plot data and appended data
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,8));
        title('Original signal from mic 30');
        subtitle('Entire Signal')
        ylabel('Amplitude (V)')
        xlim([0 0.1])
        hold on

% --Filter signal
    filtered_data = filter_data(data(:,8),fs,70000,0.33,"false");
    figure(1)
    subplot(3,1,2)
    plot(time,filtered_data);
        subtitle('Bandpass filtered Signal')
        ylabel('Amplitude (V)')
        xlim([0 0.1])

% --Apply anti_noise filter
    filtered_data = anti_noise_filter(data_path,8);
    %filtered_data = filter_data(filtered_data,fs,70000,0.33,"false");
    figure(1)
    subplot(3,1,3)
    plot(time,filtered_data);
        subtitle('Anti-Noise filtered Signal')
        ylabel('Amplitude (V)')
        xlim([0 0.1])
