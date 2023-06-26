function visualize_data(test_data, t_span)
%
%   This function is used to test all the microphones to see if they are
%   working or not before a test is completed. Can be used to check data
%   from microphones as well.
%
%   Inputs: test_data -- This is the raw test data to be input
%           t_span  -- This is the time span for the test view window
%   
%   Outputs: 2 figures with 14 subplots showing data from mics for 0.1 sec
%   
%   Sam Kramer
%   June 14th, 2023
% 
%   See also background_noise_test, save_daq_data, and add_daq_channels

% --Load in data from background noise test
    data = load(test_data);
    data = data.final_output_data;

% --Select 1 second of data
    time = data(:,1);
    index = find(time(2:end-1) == t_span);
    data = data(2:index,2:end);
    time = time(2:length(data)+1);

% --Plot data in successive figures
    j = 1;  % figure Ticker
    k = 2;  % Mic Ticker
    m = 1;  % Subplot ticker

    for i = 1:28    % Subplot Ticker 

        % --Zero mean data
            sdf = data(:,k);
            sdf = sdf - mean(sdf);

        % --Plot figures
            figure(j)
            subplot(7,2,m)
            plot(time,sdf)
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