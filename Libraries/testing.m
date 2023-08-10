% data = importdata('C:\Users\Nicholas Rock\Desktop\Brunei Research\7-5 Test\20khz_ring6to1_straight.mat');
datatimetable = importdata("Chirps.mat");
data = datatimetable.Dev1_ai1;
data = normalize(data, "center", "mean"); % Center data at 0 V
time = datatimetable.Time;
peak_windows = get_peak_windows(data, 250000);

figure(1);
plot(time, data)
title('7-5 Test')
xlabel('Time [ms]')
ylabel('Amplitude [V]')
grid on;
hold on;

% for p=1:numel(peak_windows{1}(1))
%     plot(peak_windows{p,1},peak_windows{p,2})
% end

plot(peak_windows{1,1}(:,:),peak_windows{1,2}(:,:))



% % Note that this only works for a stable signal -> Will need to use a fft
% % and normalize into bins for chirps
% 
% % Importing and normalizing test data
% 
% % 5kHz monopole sound source, 100 kHz sampling rate for 2 seconds
% data = importdata('C:\Users\Nicholas Rock\Desktop\Brunei Research\3JUL23\5khz_ring1to6_left.mat'); 
% data = data(2:end-1,:); time = data(:,1)*1000; data(:,1)=[];
% ndata = normalize(data,"center","mean");
% 
% background = importdata('C:\Users\Nicholas Rock\Desktop\Brunei Research\3JUL23\5khz_background.mat'); 
% background = background(2:end-1,:); time = background(:,1)*1000; background(:,1)=[];
% nbackground = normalize(background,"center","mean");
% 
% 
% 
% mic = 19;
% frameLength = 16; % Power of 2, each frame is ~2.56 ms
% 
% sgolayFilt = sgolayfilt(ndata(:,mic),13,frameLength+1); % 5 periods per 1 ms for 5 khz -> 13th degree per frame
% butterFilt = filter_data(ndata(:,mic),5000,400000);
% 
% noisyVar = var(ndata(:,mic));
% filtVar = var(sgolayFilt);
% filtVar2 = mean(butterFilt);
% 
% snr = 10 * log10(abs(filtVar / noisyVar));
% snr2 = 10 * log10(abs(filtVar2 / noisyVar));
% 
% subplot(3,1,1)
% plot(time(1:1000),10*log10(abs(ndata(1:1000,mic))),'black-')
% title(sprintf('Signal'));
% ylabel('Power [db]');
% xlabel('Time [ms]');
% grid on;
% 
% subplot(3,1,2)
% plot(time(1:1000),10*log10(abs(sgolayFilt(1:1000))),'r-')
% title(sprintf('%f snr Savitzky-Golay',snr))
% ylabel('Power [db]');
% xlabel('Time [ms]');
% grid on;
% 
% subplot(3,1,3)
% plot(time(1:1000),10*log10(abs(butterFilt(1:1000))),'blue-')
% title(sprintf('%f snr2 Butterworth',snr2))
% ylabel('Power [db]');
% xlabel('Time [ms]');
% grid on;
% 


























% 
% s = load("C:\Users\Nicholas Rock\Desktop\Brunei Research\Matlab Code\Chirps.mat");
% chirp = s.Dev1_3.Variables;
% chirp_time = s.Dev1_3.Time;
% 
% [e,w] = RLSFilterIt(nbackground(:,2),chirp(1:75000),250000);


% cutoff_freq = 4000;
% sampling_freq = 100000;
% order = 7; % Adjust to correct periodicity
% normalized_cutoff = cutoff_freq / (sampling_freq/2);
% [b,a] = butter(order, normalized_cutoff, 'high');
% 
% filtered_signal = filter(b,a, ndata);
% 
% subplot(2,1,1)
% plot(time,ndata(:,2))
% title('Original Signal')
% xlabel('Time [ms]')
% ylabel('Amp [V]')
% 
% subplot(2,1,2)
% plot(time,filtered_signal(:,2))
% title('Filtered Signal')
% xlabel('Time [ms]')
% ylabel('Amp [V]')

% % Following plotting paradigm found here <https://www.mathworks.com/matlabcentral/answers/696995-find-peaks-valleys-of-a-noisy-signal>
% 
% [peakValues,indicesOfPeaks,widths,proms] = findpeaks(smoothP,'MinPeakDistance',13); % 5 periods per 1 ms for 5 kHz signal -> 5*2.56
% meanSignal = mean(smoothP);
% outlierIndices = peakValues < meanSignal;
% peakValues(outlierIndices) = [];
% indicesOfPeaks(outlierIndices) = [];
% plot(time(indicesOfPeaks),peakValues,'b.','MarkerSize',15);
% 
% [valleyValues,indicesOfValleys] = findpeaks(-smoothP,'MinPeakDistance',13);
% valleyValues = -valleyValues;
% valleyOutlierIndices = valleyValues < meanSignal;
% valleyValues(valleyOutlierIndices) = [];
% indicesOfValleys(valleyOutlierIndices) = [];
% plot(time(indicesOfValleys),valleyValues,'c.','MarkerSize',15);
% 
% message = sprintf('%d peaks and %d valleys',length(indicesOfPeaks),length(indicesOfValleys));
% title(message,'Mic #')
% ylabel('Amp [V]')
% xlabel('Time [ms]')
% legend('Signal','Filtered','Peaks','Valleys');
% 
