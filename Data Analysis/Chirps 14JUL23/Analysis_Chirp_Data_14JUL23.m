%% Data Analysis For Tone Data from 15JUL23
%{
    This is the data analysis script that is for the analysis of the data
    from the chirps sent into the array on the 15th of July, 2023. The main
    purpose is to see if there is quality data moving through the
    array.

    Sam Kramer
    July 18th, 2023
%}

% --Setup
    clear; clc; format compact; close all;

% --Load in data
    data_path = 'C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Validation Data\Testing 14JUL2023\5kHzto10kHz_ring6to1_straight.mat';
    load(data_path);

% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    data = final_output_data(:,2:end);
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));
    
% --Plot data and appended data
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,8));
        title('Original signal from mic 30');
        subtitle('Entire Signal')
        ylabel('Amplitude (V)')

    subplot(3,1,2)
        plot(time,data(:,8))
            ylabel('Amplitude (V)')
            subtitle('Appended Signal')
            xlim([1 2])

% --Filter signal
    filtered_data = filter_data(data(:,30),fs,7500,0.33,"true");

    figure(1)
    subplot(3,1,3)
    plot(time,filtered_data)
        xlabel('Time (s)')
        subtitle('Filtered Signal')
        ylim([-0.5 0.5])
        xlim([1 2])

% --Spectrogram of data
    data_location = 'C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Validation Data\Testing 14JUL2023\5kHzto10kHz_ring6to1_straight.mat';
    specfilt_data2(data_location,14,0,7,7500);
    title('Spectrogram of chirps from 13July2023 Test')
    ylim([0 50000])

% --Unfiltered spectrogram of data
    spectrogram_data(data_path,30,0,7);
        ylim([0 50000])

