fs=1000;
t=0:1/fs:1;
fm=5;
m=cos(2*pi*fm*t);
fc=50;
c1=cos(2*pi*fc*t);
c2=sin(2*pi*fc*t);
I=m.*c1;
Q=imag(hilbert(m)).*c2;
x=I+Q;            %getting lower side band
plot(t,x);
xlabel('Time');
ylabel('Amplitude');
title('SSB Signal');

N=length(x);
X=fftshift(fft(x,N));
figure(2);
f=fs*(-N/2:1:N/2-1)/N;
plot(f,abs(X));
xlabel('Absolute frequency');
ylabel('DFT Values');
title('Spectrum of SSB (LSB) Signal');

%Coherent demodulator
z=x.*c1;  
figure(3)
plot(t,z);
xlabel('Time');
ylabel('Amplitude');
title('Coherent Demodulated Signal');
N=length(z);
Z=fftshift(fft(z,N));
figure(4);
f=fs*(-N/2:1:N/2-1)/N;
plot(f,abs(X));
xlabel('Absolute frequency');
ylabel('DFT Values');
title('Spectrum of Coherent Demodulated output');
%Butterworth LPF
[num,den]=butter(3,4*fm/fs);
rec=filter(num,den,z);
figure(5)
plot(t,z);
xlabel('Time');
ylabel('Amplitude');
title('Recovered Signal');

N=length(rec);
R=fftshift(fft(rec,N));
figure(6);
f=fs*(-N/2:1:N/2-1)/N;
plot(f,abs(R));
xlabel('Absolute frequency');
ylabel('DFT Values');
title('Spectrum of Recovered Signal');






