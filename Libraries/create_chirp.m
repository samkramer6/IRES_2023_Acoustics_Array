function signal = create_chirp(chirp_type, number, length, freq_start, freq_end, fs, show_spect)
%{
    This function will be used to create a chirp signal that will be used
    for the advanced filtering of the signals that are returned from the
    bat recordings.

    Inputs:     chirp_type  == linear or logarithmic, takes a string
                freq_start  == Start frequency of chirp  (Hz)
                freq_end    == Ending frequency of chirp (Hz)
                fs          == Sample frequency (Hz)
                show_chirp  == option to show chirp boolean
                show_spect  == option to show spectrogram bool
                number      == number of chirps per second
                

    Sam Kramer
    July 11th, 2023
%}

% --Call on the dsp.chirp function
    number = 1/number;
    chirp = dsp.Chirp('SweepDirection', 'Unidirectional', ...
                      'Type', chirp_type, ...
                      'TargetFrequency', freq_end, ...
                      'InitialFrequency', freq_start,...
                      'TargetTime', number, ...
                      'SweepTime', number, ...
                      'SamplesPerFrame', length*fs, ...
                      'SampleRate', fs);

% --Output Signal
    signal = chirp();

% --Show Spectrogram
    if show_spect == "True" || show_spect == "true"
        spectrogram_function(signal,fs,[],[])   % My own function
    end

end