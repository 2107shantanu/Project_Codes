[y,fs]=audioread("testing_shan.wav");
y=y(:,1);  %channel1
N = length(y); % sample length
t=0:1/fs:N/fs-1/fs;

%orignal Signal
figure(3);
subplot(2,1,1);
plot(t, y); 
title('Orignal Audio Signal');
figure(3);
subplot(2,1,2);
[x,f]=spectrogram(y);
plot(f,abs(x));
title('Original Audio Signal');


%low frequency 20Hz to 300Hz
filter1=filter(lowpass,y);
figure(2);
subplot(3,1,1);
plot(t,filter1);
title('Low Frequency Signal');
figure(1);
subplot(311);
[spec_1,f]=spectrogram(filter1);
plot(f,abs(spec_1));
title('Spectrum of Low Frequency');

%high frequency 4000Hz to 40000Hz
filter3=filter(highpass,y);
figure(2);
subplot(3,1,3);
plot(t,filter3);
title('High Frequency Signal');
figure(1);
subplot(313);
[spec_3,f]=spectrogram(filter3);
plot(f,abs(spec_3));
title('Spectrum of High Frequency');

%mid frequency 300Hz to 4000Hz 
filter2=filter(bandpass,y);
figure(2);
subplot(3,1,2);
plot(t,filter2);
title('Mid Frequency Signal');
figure(1);
subplot(312);
[spec_2,f]=spectrogram(filter2);
plot(f,abs(spec_2));
title('Spectrum of Mid Frequency');
