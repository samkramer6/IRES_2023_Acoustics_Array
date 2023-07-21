%% Data Analysis For chirp data from 18JUL23
%{
    This is the data analysis script that is for the analysis of the data
    from the chirps sent into the array on the 19th of July, 2023. The main
    purpose is to see if there is quality chirp data as well as an echo.
    The bat bot was located a quarter meter from microphone 32 and on the
    opposite side a wall was located to make echoes.

    Sam Kramer
    July 19th, 2023
%}

% --Setup
    clear; clc; format compact; close all;

% --Call on analyze data function (Trial 1; Chirp 1)
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 19JUL2023\Chirp_echo_1";
%     analyze_data(data_path,32,"false",2.96,3)

% --Try a second chirp (Trial 2; Chirp 2)
    spectrogram_data(data_path,32,5.0,5.3)

% --Second data test (Trial 2; Chrip 1)
%     data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 19JUL2023\Chirp_echo_2";
%     spectrogram_data(data_path,32,3.51,3.53)