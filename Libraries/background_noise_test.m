function background_noise_test()
%
%   This will take a quick 5 second test that will be used for determining
%   the background noise within the room before a test is taken. Defaults
%   to 250,000 Hz sample rate for the test.
% 
%   Sam Kramer
%   June 12th, 2023
%
%   See also add_daq_channels, and save_daq_data
%

    % --Setup Daq and channels
        NI_daq = add_daq_channels(250000);

    % --Start Test
        time_start = datetime('now','Format','dd-MMM-uuuu HH:mm:ss.SSSS');

        start(NI_daq,"Duration",seconds(5))
            pause(5)
        stop(NI_daq)
        
        time_end = datetime('now','Format','dd-MMM-uuuu HH:mm:ss.SSSS');

    % --Read data
        test_data = read(NI_daq,"all");

    % --Save Data as .csv file
        save_daq_data(test_data,time_start,time_end,'Background_Noise_Test')

end
