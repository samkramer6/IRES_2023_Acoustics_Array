%% Data Analysis For chirp data from 13JUL23
%{
    This is the data analysis script that is for the analysis of the data
    from the chirps sent into the array on the 13th of July, 2023. The main
    purpose is to see if there is quality chirp data moving through the
    array that is created by the Batbot.

    Sam Kramer
    July 14th, 2023
%}

% --Setup
    clear; clc; format compact; close all;

% --Load in data
    load('C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Validation Data\Testing 13JUL23\chirps_rign6to1_straight.mat');
    
% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    data = final_output_data(:,2:end);
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));
    
% --Plot data and appended data
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,30));
        title('Original signal from mic 30');
        subtitle('Entire Signal')
        ylabel('Amplitude (V)')

    subplot(3,1,2)
    plot(time,data(:,30))
        ylabel('Amplitude (V)')
        subtitle('Appended Signal')
        xlim([2.5 3])

% --Check for a chirp signal using cross correlation
    sample_chirp = create_chirp("Linear",15,.066,120000,40000,fs,"false");
    %plot(time(1:length(sample_chirp)),sample_chirp)

% --Filter signal
    filtered_data = filter_data(data(:,24),fs,80000,0.5,true);

    figure(1)
    subplot(3,1,3)
    plot(time,filtered_data)
        xlabel('Time (s)')
        subtitle('Filtered Signal')
        ylim([-0.2 0.2])

% --Autocorrelating dataset of entire system
    mean_data = mean(data,2);
    mean_data = mean_data - mean(mean_data);
    Autocorrelation_data = xcorr(mean_data,sample_chirp);
    lags = -length(Autocorrelation_data)/2:length(Autocorrelation_data)/2 -1;
    figure(4)
        plot(lags,Autocorrelation_data)
            xlabel('Lags')
            xlim([0 125000])
            title('Crosscorrelation of Averaged Dataset')

% --Spectrogram of data
    specfilt_data('C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Validation Data\Testing 13JUL23\chirps_rign6to1_straight.mat',...
                      30,2.5,3);
    title('Spectrogram of chirps from 13July2023 Test')

