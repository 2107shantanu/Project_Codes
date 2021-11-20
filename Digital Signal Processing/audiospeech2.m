filename='testing_shan.wav';
[x,fs] = audioread(filename); 
x=x(:,1);           % channel 1
L1= length(x);       % sample length
T1= L1/fs;
t1 = 0:T1/length(x):T1-T1/length(x);
fs_out=48000;
[N, D] = rat(fs_out/fs);    % To find the simplest fraction.N=147; D=160
fs_up = N*fs;                %Upsampled Frequency;
fs_down=fs_up/D;

% plots for original signal %
figure(1);
subplot(211);
plot(t1,x);
subplot(212);
Specx1=fftshift(fft(x));
Freqx1 = ((-1/2:1/L1:1/2-1/L1)*fs); 
plot(Freqx1,abs(Specx1));
title('Original Signal');

% upsampling the signal 
x_upsampled=upsample(x,N);  
% plots for Upsampled signal %
L2= length(x_upsampled);          
T2 = L2/fs_up; %Toal Time
t2 = 0:T2/(length(x_upsampled)):T2-T2/length(x_upsampled);
figure(2);
subplot(211);
plot(t2,x_upsampled);
subplot(212);
Freqx_upsampled = ((-1/2:1/L2:1/2-1/L2)*fs_up); 
Specx_upsampled=fftshift(fft(x_upsampled));
plot(Freqx_upsampled,abs(Specx_upsampled));
sgtitle('Upsampled Signal');

%Filtering 
fc_in=(fs/2)/N;
fc_dec=(fs_up/2)/D;
cf= min(2*pi*fc_in/fs_up,2*pi*fc_dec/fs_down);
[b,a]=fir1(5,cf);
y=filter(b,a,x_upsampled);
L3= length(y); % sample length
T3 = L3/fs_up; %Total Time
t3 = 0:T3/(length(y)):T3-T3/length(y);
figure(3);
subplot(211);
plot(t3,y);
subplot(212);
Freq_y = ((-1/2:1/L3:1/2-1/L3)*fs_up); 
Spec_y=fftshift(fft(y));
plot(Freq_y,abs(Spec_y));
sgtitle('After Filtering Signal');

% downsampling the signal 
x_downsampled=downsample(y,D);   %downsampling of the interpolated signal

% plots for Downsampled signal %
L4= length(x_downsampled);           % sample length
T4 = L4/fs_down;                        %Toal Time
t4 = 0:T4/(length(x_downsampled)):T4-T4/length(x_downsampled);
figure(4);
subplot(211);
plot(t4,x_downsampled);
subplot(212);
Freq_x_downsampled = ((-1/2:1/L4:1/2-1/L4)*fs_down); 
Spec_x_downsampled=fftshift(fft(x_downsampled));
plot(Freq_x_downsampled,abs(Spec_x_downsampled));
sgtitle('Downsampled Signal');
