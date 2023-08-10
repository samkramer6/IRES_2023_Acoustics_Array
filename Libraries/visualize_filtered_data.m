function visualize_filtered_data(data_path,t_span,filter_center)
%
%   This function is used to visualize the data with an additional filter
%   on top of the data. This will use the other two functions that have
%   been written to visualize the data. Compatible with the Array Control
%   Pannel only. Do not use with the array acoustics app data. 
%
%   Inputs: test_data -- This is the raw test data to be input
%           t_span  -- This is the time span for the test view window
%           filter_center -- Center frequency of bandpass
%           Fs -- Sample frequency of data
%   
%   Outputs: 2 figures with 14 subplots showing data from mics for 0.1 sec
%   
%   Sam Kramer
%   June 14th, 2023
% 
%   See also visualize_data, and filter_data

% --Load in data
    [data,time,fs] = load_data(data_path);

% --Pick out single mic
    data = data(:,mic_num);

% --Reformat time span data
    time = time(1:t_span*fs);
    data = data(1:t_span*fs);

% --Plot data in successive figures
    j = 1;  % figure Ticker
    k = 2;  % Mic Ticker
    m = 1;  % Subplot ticker

    for i = 1:28    % Subplot Ticker 

        % --Zero mean data
            zmd = data(:,k);
            zmd = zmd - mean(zmd);

        % --Filter data
            zmd = filter_data(zmd,fs,filter_center,.25,"false");

        % --Plot figures
            figure(j)
            subplot(7,2,m)
            plot(time,zmd)
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

