function signal = create_chirp(chirp_type, freq_start, freq_end, fs )
%{
    This function will be used to create a chirp signal that will be used
    for the advanced filtering of the signals that are returned from the
    bat recordings.

    Inputs:     chirp_type  == linear or logarithmic, takes a string
                freq_start  == Start frequency of chirp  (Hz)
                freq_end    == Ending frequency of chirp (Hz)
                fs          == Sample frequency (Hz)

    Sam Kramer
    July 11th, 2023
%}

% --Call on the dsp.chirp function
    chirp = dsp.Chirp('SweepDirection', 'Unidirectional', ...
                      'Type', chirp_type, ...
                      'TargetFrequency', freq_end, ...
                      'InitialFrequency', freq_start,...
                      'TargetTime', 1, ...
                      'SweepTime', 1, ...
                      'SamplesPerFrame', fs, ...
                      'SampleRate', fs);

% --Output Signal
    signal = chirp();

end