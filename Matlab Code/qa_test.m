function qa_test(data,freq,rate)
    % data is pressure data in shape n x 32, freq is frequency of signal,
    % rate is sampling rate

    % shape data
    pressures = data(2:end-1,:); pressures(:,1)=[];
    pressures = normalize(pressures,"center","mean"); % Center data at 0 V
    
    % Calculate signal to noise ratios for test
    ratios = snr(pressures,freq,rate);
    
    % ai_0 mics
    exclude_indices = [1,9,17,25];
    ratios(exclude_indices) = 0;
    
    x = 1:numel(ratios);
    
    figure;
    bar(x, ratios, 'FaceColor', 'blue', 'EdgeColor', 'black');
    title('20 kHz Test')
    xlabel('Mics')
    xticks(x)
    xticklabels(x)
    ylabel('Signal to noise ratio [db]')
end