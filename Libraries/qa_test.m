
function qa_test(data,filtered_data)
    % data is pressure data in shape n x 32, freq is frequency of signal,
    % rate is sampling rate

    % Calculate signal to noise ratios for test
    ratios = snr(data,filtered_data);
    
    % ai_0 mics
    exclude_indices = [1,9,17,25,31];
    ratios(exclude_indices) = 0;
    
    x = 1:numel(ratios);
    
    figure;
    bar(x, ratios, 'FaceColor', 'blue', 'EdgeColor', 'black');
    xlabel('Mics')
    xticks(x)
    xticklabels(x)
    ylabel('Signal to noise ratio [db]')
end