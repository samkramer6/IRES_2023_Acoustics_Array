function ratio = snr(data, filtered_data)
% pressures is data of mics in 1 x 32 array, freq is frequency of the
% signal, rate is sampling rate of signal
    ratio = 10 * log10(abs(var(filtered_data) / var(data)));
end