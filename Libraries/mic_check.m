function mic_check(background_noise_test)
%
%   This function is used to test all the microphones to see if they are
%   working or not before a test is completed. Will only take in background
%   noise test data.
%   
%   Sam Kramer
%   June 14th, 2023
% 
%   See also background_noise_test, save_daq_data, and add_daq_channels

% --Load in data from background noise test
    data = load(background_noise_test);
    data = data.test_data_matrix;

% --Select 1 second of data
    data = data(2:24990,:);
    time = data(:,1);

% --Plot data in successive figures
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,3))
        hold on
        grid on

    subplot(3,1,2)
    plot(time,data(:,4))
        hold on
        grid on

    subplot(3,1,3)
    plot(time, data(:,5))
        hold on
        grid on
    
end