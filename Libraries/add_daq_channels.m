function NI_daq = add_daq_channels(sample_rate)
% 
%   This function will be used to add all the channels from the Daq used in
%   the acoustics acquisition.
% 
%   Inputs:     sample_rate ==  selected sample rate of the daq created by the
%                               user.
% 
%   Outputs:    NI_daq  ==  Creation of the daq object that will be used.
% 
%   Sam Kramer
%   June 12th, 2023
%
%   See also save_daq_data, and background_noise_test


% --Setup initial Variables
    s1 = "Dev1";
    s2 = "PXI1Slot3";
    s3 = "PXI1Slot4";

% --Connect to DAQ
    NI_daq = daq("ni");

% --Select sample rate
    NI_daq.Rate = sample_rate;
    
% --Add input channels
    % --"Dev1" Channels
        addinput(NI_daq, s1,"ai0","Voltage")
        addinput(NI_daq, s1,"ai1","Voltage")
        addinput(NI_daq, s1,"ai2","Voltage")
        addinput(NI_daq, s1,"ai3","Voltage")
        addinput(NI_daq, s1,"ai4","Voltage")
        addinput(NI_daq, s1,"ai5","Voltage")
        addinput(NI_daq, s1,"ai6","Voltage")
        addinput(NI_daq, s1,"ai7","Voltage")

    % --"PXI1Slot3" Channels
        addinput(NI_daq, s2,"ai0","Voltage")
        addinput(NI_daq, s2,"ai1","Voltage")
        addinput(NI_daq, s2,"ai2","Voltage")
        addinput(NI_daq, s2,"ai3","Voltage")
        addinput(NI_daq, s2,"ai4","Voltage")
        addinput(NI_daq, s2,"ai5","Voltage")
        addinput(NI_daq, s2,"ai6","Voltage")
        addinput(NI_daq, s2,"ai7","Voltage")

    % --"PXI1Slot4" Channels
        addinput(NI_daq, s3,"ai0","Voltage")
        addinput(NI_daq, s3,"ai1","Voltage")
        addinput(NI_daq, s3,"ai2","Voltage")
        addinput(NI_daq, s3,"ai3","Voltage")
        addinput(NI_daq, s3,"ai4","Voltage")
        addinput(NI_daq, s3,"ai5","Voltage")
        addinput(NI_daq, s3,"ai6","Voltage")
        addinput(NI_daq, s3,"ai7","Voltage")
        addinput(NI_daq, s3,"ai8","Voltage")
        addinput(NI_daq, s3,"ai9","Voltage")
        addinput(NI_daq, s3,"ai10","Voltage")
        addinput(NI_daq, s3,"ai11","Voltage")
        addinput(NI_daq, s3,"ai12","Voltage")
        addinput(NI_daq, s3,"ai13","Voltage")
        addinput(NI_daq, s3,"ai14","Voltage")
        addinput(NI_daq, s3,"ai15","Voltage")

end