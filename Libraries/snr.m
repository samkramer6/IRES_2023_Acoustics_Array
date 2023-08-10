function ratios = snr(pressures,freq,rate)
% pressures is data of mics in 1 x 32 array, freq is frequency of the
% signal, rate is sampling rate of signal
    ratios = [];
    for i=1:32
        if freq < 10000
            % Savitzky-Golay filter, good for lower freq signals
            filtered = sgolayfilt(pressures(:,i),5,17);
            % 5 periods per 1 ms for 5 khz -> 13th degree per frame, 16 was best framelength found and needs to be odd, hence 17
        else
            filtered = filter_data(pressures(:,i),freq,rate);
        end
        ratios(i) = 10 * log10(abs(var(filtered) / var(pressures(:,i))));
    end
end