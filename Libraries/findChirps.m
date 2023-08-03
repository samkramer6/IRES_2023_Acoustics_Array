function findChirps(data_path,mic_num,bat_type)
%   
%   This is a function that will systematically create a spectrogram of the
%   chirps that are detected from a specific dataset that is passed to the
%   function. This uses a filtered dataset for the time_domain_finder and
%   an unfiltered dataset for the frequency domain finder. Both sections do
%   not output filtered spectrograms, only unfiltered spectrograms are
%   used. 
% 
%   Sam Kramer
%   July 28th, 2023
%

% --Confirmation outline
    disp("Finding Chirps...This may take a few moments.")

%%%%%%%%%%%%%%%%%%%%%%%%%% Selecting Data Type %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Load in data
    [data,time,fs] = load_data(data_path);

% --Select Microphone
    data = data(:,mic_num);

% --Select Bat type
    bat_type = char(upper(bat_type));
    if bat_type(1) == 'H'
        [call,~,~] = load_data("C:\Users\FIT UBD\Desktop\Array Acoustics\Libraries\Hippo_example_chirp.mat");
    else
        disp("Defaulting to Hipposideros Chirp")
        [call,~,~] = load_data("C:\Users\FIT UBD\Desktop\Array Acoustics\Libraries\Hippo_example_chirp.mat");
    end

% --create linear chirp pattern
    FM_chirp = create_chirp("Linear",1,1,120000,100000,500000,"false");

% --Feedback message
    fprintf("Finding Data...\n")
    fprintf("This may take a moment.\n")

%%%%%%%%%%%%%%%%%%%%%%%%%%% Time Domain Section %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ghost Code:
    % --Compare the two time domain signals {Call time_domain_finder()}
        indeces = time_domain_finder(data,fs,FM_chirp,call);
        
    % --Outline for time domain section
        fprintf("Time Domain Finder Done.\n")
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Freq Domain Section %%%%%%%%%%%%%%%%%%%%%%%%%%

% Ghost Code:
    % --Compare two frequency domain signals {Call freq_domain_fnder()}

    
    % --Outline for time domain section
        fprintf("Frequency Domain Finder Done.\n")

%%%%%%%%%%%%%%%%%%%%%%%%%%% Output Spectrograms %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ghost Code:
    % --Compare the two finder indeces
        

    % --Generate Spectrograms

end
