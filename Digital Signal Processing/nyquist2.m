amp=1;                %amp=amplitude
time=2;               
f1=20;                %f1=Frequency of 1st component signal               
f2=30;                %f2=Frequency of 2nd component signal
fs=45;                %fs=Sampling Frequency
T=1/fs;               
t=0:T:time;
x=amp*sin(2*pi*f1*t)+amp*sin(2*pi*f2*t);     %Signal
figure(2)
subplot(2,1,1);
plot(t,x);
title('Wave Signal 45 Hz');
xlabel('Time');
ylabel('Amplitude');

N=length(x);
fftSignal=fft(x);
fftSignal=fftshift(fftSignal);
f=fs*(-N/2:N/2-1)/N;
figure(2)
subplot(2,1,2);
plot(f,abs(fftSignal));
title('FFT wave signal 45 Hz');            %FFT Signal
xlabel('Frequency');
ylabel('Magnitude');
