function save_daq_data(test_data, time_start, time_end, file_name)
%
%   Will save the Daq data as a .csv file based on the data and name inputs
%   into the function file.
% 
%   Inputs: test_data   ==  Data from the test that was saved by daq.
%           time_start  ==  Time start of the test
%           time_end    ==  Time end of the test
%           file_name   ==  User selected file name of data matrix, does
%                           not include .csv at end
% 
%   Outputs: None
% 
%   Sam Kramer
%   June 12th, 2023
% 
%   See also add_daq_channels, and background_noise_test
%


    % --Pull data from test_data time-table
        time = seconds(test_data.Time);     % Saves in double form

        % --Terminal Box 1 ("Dev1")
            mic1 = test_data.Dev1_ai0;
            mic2 = test_data.Dev1_ai1;
            mic3 = test_data.Dev1_ai2;
            mic4 = test_data.Dev1_ai3;
            mic5 = test_data.Dev1_ai4;
            mic6 = test_data.Dev1_ai5;
            mic7 = test_data.Dev1_ai6;
            mic8 = test_data.Dev1_ai7;

        % --Terminal Box 2 ("PXI1Slot3")
            mic9 = test_data.PXI1Slot3_ai0;
            mic10 = test_data.PXI1Slot3_ai1;
            mic11 = test_data.PXI1Slot3_ai2;
            mic12 = test_data.PXI1Slot3_ai3;
            mic13 = test_data.PXI1Slot3_ai4;
            mic14 = test_data.PXI1Slot3_ai5;
            mic15 = test_data.PXI1Slot3_ai6;
            mic16 = test_data.PXI1Slot3_ai7;

        % --Terminal Boxes 3-4 ("PXI1Slot4")
            mic17 = test_data.PXI1Slot4_ai0;
            mic18 = test_data.PXI1Slot4_ai1;
            mic19 = test_data.PXI1Slot4_ai2;
            mic20 = test_data.PXI1Slot4_ai3;
            mic21 = test_data.PXI1Slot4_ai4;
            mic22 = test_data.PXI1Slot4_ai5;
            mic23 = test_data.PXI1Slot4_ai6;
            mic24 = test_data.PXI1Slot4_ai7;
            mic25 = test_data.PXI1Slot4_ai8;
            mic26 = test_data.PXI1Slot4_ai9;
            mic27 = test_data.PXI1Slot4_ai10;
            mic28 = test_data.PXI1Slot4_ai11;
            mic29 = test_data.PXI1Slot4_ai12;
            mic30 = test_data.PXI1Slot4_ai13;
            mic31 = test_data.PXI1Slot4_ai14;
            mic32 = test_data.PXI1Slot4_ai15;

    % --Add time of test start
        day_test_start = day(time_start);
        hour_test_start = hour(time_start);
        min_test_start = minute(time_start);
        second_test_start = second(time_start);

        time_start_vector = [day_test_start, hour_test_start, min_test_start, second_test_start];

        zero_append = zeros([1, 33 - length(time_start_vector)]);
        
        time_start_vector = [time_start_vector, zero_append];

    % --Add time of test end
        day_test_end = day(time_end);
        hour_test_end = hour(time_end);
        min_test_end = minute(time_end);
        second_test_end = second(time_end);

        time_end_vector = [day_test_end, hour_test_end, min_test_end, second_test_end];

        time_end_vector = [time_end_vector, zero_append];

       
    % --Save data as matrix
        test_data_matrix = [time, mic1, mic2, mic3, mic4 , mic5, mic6, mic7, mic8, ...
                                    mic9, mic10, mic11, mic12, mic13, mic14, mic15, mic16, ...
                                    mic17, mic18, mic19, mic20, mic21, mic22, mic23, mic24, ...
                                    mic25, mic26, mic27, mic28, mic29, mic30, mic31, mic32];

        test_data_matrix = [time_start_vector; test_data_matrix; time_end_vector];

    % --Save as matfile
        file_name = string(file_name);
        file_name = file_name + ".mat";
        save(file_name,"test_data_matrix");

end