function analyze_data(data_path, mic_number, entire_set, t_start, t_end,f_center)
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
    [data,time,fs] = load_data(data_path);

% --Pick out single mic
    data = data(:,mic_num);

% --Visualize entire dataset
    if entire_set == "true"
        visualize_data(data_path,max(time))
    end

% --Look at single mic dataset
    figure(1)
    subplot(3,1,1)
    plot(time,data(:,mic_number));
        title('Original signal');
        subtitle('Entire Signal')
        ylabel('Amplitude (V)')
        xlim([0 max(time)])

    subplot(3,1,2)
    plot(time,data(:,mic_number))
        ylabel('Amplitude (V)')
        subtitle('Appended Signal')
        xlim([t_start t_end])

% --Filter data and ouput it onto a figure
    filtered_data = filter_data(data(:,mic_number),fs,f_center,0.3,"true");
    
    figure(1)
    subplot(3,1,3)
    plot(time,filtered_data)
        xlabel('Time (s)')
        subtitle('Filtered Signal')
        xlim([t_start t_end])

% --Unfiltered Spectrogram of data
    spectrogram_data(data_path,mic_number,t_start,t_end)
        title("Unfiltered Spectrogram of Test")

end