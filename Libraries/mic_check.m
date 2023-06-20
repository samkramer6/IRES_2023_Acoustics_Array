function mic_check(background_noise_test)
%
%   This function is used to test all the microphones to see if they are
%   working or not before a test is completed. Can be used to check data
%   from microphones as well. 
%   
%   Outputs: 2 figures with 14 subplots showing data from mics for 0.1 sec
%   
%   Sam Kramer
%   June 14th, 2023
% 
%   See also background_noise_test, save_daq_data, and add_daq_channels

% --Load in data from background noise test
    data = load(background_noise_test);
    data = data.test_data_matrix;

% --Select 1 second of data
    time = data(:,1);
    index = find(time(2:end-1) == 0.1);
    data = data(2:index,2:end);
    time = time(2:length(data)+1);

% --Plot data in successive figures
    j = 1;  % figure Ticker
    k = 2;  % Mic Ticker
    m = 1;  % Subplot ticker

    for i = 1:28    % Subplot Ticker 
        % --Plot figures
            figure(j)
            subplot(7,2,m)
            plot(time,data(:,k))
                hold on
                grid on

        % --Create titles
            subT = "Mic " + string(k);
            subtitle(subT)
            m = m+1;
        
        % --Index microphones
            if k == 8 ||  k == 16 || k == 24 
                k = k+2;    % Skips those not plugged in
            else
                k = k+1;    
            end

        % --Index subplots
            if i == 14
                j = 2;
                m = 1;
            end
    end
    
end