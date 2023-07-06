function trigger_cameras(rate, time_leng, start)
%
%   This is a function that will generate a trigger pulse that will be used
%   to run the cameras in the array. Will only run cameras and will not
%   collect data from the mics. Only uses write command and does not use
%   readwrite()
%
%   Inputs:     rate --         The set sample rate of the system (Hz)
%               time_leng --    The length of the signal (s)
%               start --        The start offset from button push (s)
%   No Outputs
%
%   Sam Kramer
%   July 5th, 2023
%
%   See also filter_data, spectrogram_data, save_data
%   

% --Add daq and channels
    NI_daq = daq('ni');
    NI_daq.Rate = rate;   % Toggle output rate
    addoutput(NI_daq,"Dev1","ao1","Voltage");

% --Create square wave
    x = 1:rate*time_leng;
    outputSignal1 = 5.*[heaviside(x - start)]';
    outputSignal1 = [outputSignal1; zeros(1000,1)];
    write(NI_daq,outputSignal1)

end