function time_domain_finder(data,fs,FM_chirp,CFFM_chirp)
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

% --Cross correlate vs. simple FM chirp
    [FM_corr, FM_lags] = xcorr(filtered_data, FM_chirp);

% --Cross correlate vs. example CFFM chirp
    [CFFM_corr, CFFM_lags] = xcorr(filtered_data, CFFM_chirp);

% --Check to see if the two are the same length [DELETE AFTER DEVELOPMENT]
    disp(length(FM_corr))
    disp(length(CFFM_corr))

% --Reformat data to find just the single sided cross correlation
    

% --Develop peak threshold criteria


% --Find peaks of both correlations


% --Compare the peaks of both {Calls Comparison Function}

end