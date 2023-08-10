function analyze_data_batbot(data_path, mic_number, entire_set, t_start, t_end)
%
%   This function is used to do basic analysis of the data. The user is
%   able to draw conclusions about the quality of their data from this
%   function. This is useful for cutting down on code that the user must
%   write to analyze a dataset. The data_path must be the entire path that
%   the computer points to. 
%   
%   Sam Kramer
%   July 19th, 2023
%
%   See also visualize_data, specfilt_data, and filter_data

% --Load in data
    load(data_path);

% --Reformat data
    final_output_data = final_output_data(2:end-1,:);
    data = final_output_data(:,2:end);
    time = final_output_data(:,1);
    fs = round(1/(time(10)-time(9)));

% --Visualize entire dataset
    if entire_set == "true"
        visualize_data(data_path,max(time))
        visualize_filtered_data(data_path,max(time),45000)
    end

    box_x = 0.69; % Adjust the X position of the text box
    box_y = 0.89; % Adjust the Y position of the text box
    
    ratio = snr(data(:,mic_number), filter_data_batbot(data(:,mic_number),fs,40000,0.5,"False"));
    ratio = round(ratio,3);
    
    % -- Look at single mic dataset
    figure(1)
    subplot(2,1,1)
    plot(time, data(:,mic_number));
    title('Original signal: 160 cm');
    subtitle('Entire Signal')
    ylabel('Amplitude (V)')
    xlim([0 max(time)])
    
    % Remove previous annotations
    delete(findall(gcf, 'Type', 'annotation'));

    % Create the annotation text box with the SNR value outside the plot
    annotation('textbox', 'Units', 'normalized', ...
        'Position', [box_x, box_y, 0.1, 0.1], ...
        'String', ['SNR: ' num2str(ratio) ' dB'], ... % Add "dB" after the SNR value
        'FontWeight', 'bold', ...
        'EdgeColor', 'black', ...
        'FontSize', 10);

    subplot(2,1,2)
    plot(time,data(:,mic_number))
        ylabel('Amplitude (V)')
        subtitle('Appended Signal: 160 cm')
        xlim([t_start t_end])

% % --Filter data and ouput it onto a figure
%      filtered_data = filter_data_batbot(data(:,mic_number),fs,100000,0.5,"true");
% 
%     figure(1)
%     subplot(3,1,3)
%     plot(time,filtered_data)
%         xlabel('Time (s)')
%         subtitle('Filtered Signal')
%         xlim([t_start t_end])
        
% --Filtered Spectrogram of data
   

    specfilt_data_batbot(data_path,mic_number,t_start,t_end);
        title('Spectrogram: 160 cm')
        

% --Unfiltered Spectrogram of data
    %spectrogram_data_batbot(data_path,mic_number,t_start,t_end)



end