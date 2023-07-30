function find_chirps(data_path,mic_num,bat_type)
%   
%   This is a function that will systematically create a spectrogram of the
%   chirps that are detected from a specific dataset that is passed to the
%   function.
% 
%   Sam Kramer
%   July 28th, 2023
%

%%%%%%%%%%%%%%%%%%%%%%%%%% Selecting Data Type %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Load in data
    [data,time,fs] = load_data(data_path);

% --Select Microphone
    data = data(:,mic_num);

% --Select Bat type
    if bat_type == "Hipposideros" || bat_type == "hipposideros"
        [hippo,~,~] = load_data("C:\Users\FIT UBD\Desktop\Array Acoustics\Libraries\Hippo_example_chirp.mat");
    else
        disp("No example chirp selected")
        disp("Checking only on a linear chirp pattern")
    end

% --create linear chirp pattern
    FM_chirp = create_chirp("Linear",1,1,120000,100000,500000,"false");

%%%%%%%%%%%%%%%%%%%%%%%%%%% Time Domain Section %%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Cross correlate vs. simple FM chirp
    








end
