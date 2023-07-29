%% Creating a Model Chirp for Correlation data
%{
    This filtered model chirp is located within the libraries
    folder and is mainly used for running correlations versus the
    data. Please refer to documentation for how to use it in future data
    analysis scripts
    
    Sam Kramer
    July 26th, 2023
%}

% --Data path and setup
    clear; clc; close all; format compact; warning off;
    data_path = "C:\Users\FIT UBD\Desktop\Array Acoustics\Test Data\Testing 20JUL2023\Bat_Trial_2";

% --Pulling out the data to create a "Model Chirp" from best chirp
    [mic_data,~,fs] = load_data(data_path);

% --Model chirp 1
    model_chirp1 = mic_data(2.953*fs:2.96*fs,32);
    filtered_model_chirp1 = filter_data(model_chirp1,fs,120000,0.2,"false");
    figure()
    plot(filtered_model_chirp1)

% --Model chirp 2
    model_chirp2 = mic_data(3.125*fs:3.132*fs,26);
    filtered_model_chirp2 = filter_data(model_chirp2,fs,120000,0.2,"false");
    figure()
    plot(filtered_model_chirp2)

% --Model chirp 3
    model_chirp3 = mic_data(0.425*fs:0.432*fs,26);
    filtered_model_chirp3 = filter_data(model_chirp3,fs,120000,0.2,"false");
    figure()
    plot(filtered_model_chirp3)

% --Model chirp 4
    model_chirp4 = mic_data(0.4*fs:0.407*fs,26);
    filtered_model_chirp4 = filter_data(model_chirp4,fs,120000,0.2,"false");
    figure()
    plot(filtered_model_chirp4)

% --Model chirp 5
   model_chirp5 = mic_data(3.021*fs:3.028*fs,26);
    filtered_model_chirp5 = filter_data(model_chirp5,fs,120000,0.2,"false");
    figure()
    plot(filtered_model_chirp5)

% --Creating my own model chirp
    x = 0:1/500000:.003;
    f = 150000;
    wn = f*2*pi;
    envelope = normpdf(x,0.0015,0.001)./400;
    CF_wave = 0.01.*envelope.*sin(wn.*x);

    FM_wave = create_chirp("Linear",1/.005,0.005,120000,100000,500000,"True");
    FM_wave = 0.01.*envelope.*[FM_wave; 0]';


%% --Convolve first two chirps
    convolved_chirp = conv(filtered_model_chirp1,filtered_model_chirp2);
    figure()
    plot(convolved_chirp)

    figure()
    [s,f,t] = spectrogram(CFFM_wave, hamming(128), 124, [], fs,'yaxis');
        %t = time_start:(1/length(t)):time_end;
        s = 20*log10(abs(s));
        s = s - max(s);
        imagesc(t,f,s)
        set(gca,"YDir","normal")
        colormap('jet')
        clb = colorbar;
        clim([-60 0])
        title('Unfiltered Spectrogram of Data')
        xlabel('Time (s)');
        ylabel('Frequency (Hz)')
        clb.Title.String = "Power (dB)";
        ylim([40000 170000])





