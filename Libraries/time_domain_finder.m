function time_indeces = time_domain_finder(data,fs,FM_chirp,CFFM_chirp)
%
%   This function is a helper function for the find chirps algorithm that
%   is used to analyze the bat data to find the chirps that have been
%   detected by the microphones. This uses the time domain signal that has
%   been collected by the array. This compares the CFFM chirp from actual
%   data to the filtered dataset. 
%
%   Sam Kramer
%   August 1st, 2023

% --Filter data for correlations
    try
        filtered_data = filter_data(data,fs,100000,0.6,"false");
    catch
        filtered_data = filter_data(data,fs,[],[],"false");
            disp("Error with filter")
            disp("Ensure that Nyquist is above 200kHz")
    end

% --Cross correlate vs. simple chirps
    [FM_corr, ~] = xcorr(filtered_data, FM_chirp);
    [CFFM_corr, ~] = xcorr(filtered_data, CFFM_chirp);

% --Reformat data to find just the single sided cross correlation
    CFFM_corr = CFFM_corr(length(CFFM_corr)/2:length(CFFM_corr));
    FM_corr = FM_corr(length(FM_corr)/2:length(FM_corr));

% --Develop peak threshold criteria
    CFFM_corr = abs(CFFM_corr);
    FM_corr = abs(FM_corr);
    CFFM_peak_threshold = max(CFFM_corr) - 1.5*mean(CFFM_corr);
    FM_peak_threshold = max(FM_corr) - 1*mean(FM_corr);
    
% --Find peaks of both correlations
    [~,CF_ind] = findpeaks(CFFM_corr,"MinPeakHeight",CFFM_peak_threshold);     % ADD MIN PEAK HEIGHT
    [~,FM_ind] = findpeaks(FM_corr,"MinPeakHeight",FM_peak_threshold);       % ADD MIN PEAK HEIGHT

% --Compare the peaks of both {Calls Comparison Function}
    time_indeces = compare_function(CF_ind./fs, FM_ind./fs, 0.04);

end