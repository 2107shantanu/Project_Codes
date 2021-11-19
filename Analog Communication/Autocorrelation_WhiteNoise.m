clc; clear all; close all;
fs=1000;
t=0:1/fs:1-1/fs;

noise=rand(1,fs);
figure(1);
plot(t,noise);
xlabel('Time');
ylabel('Amplitude');
title('White Noise');
y(1)=0;

for i=2:fs
    y(i)=0.9*y(i-1)+noise(i);
end

figure(2);
plot(t,y);
xlabel('Time');
ylabel('Amplitude');
title('Coloured Noise');

f = 20;
[b,a] = butter(6,2*pi*f,'s');       %IIR Filtering
[bz,az] = impinvar(b,a,fs);
c=freqz(bz,az,1024,fs);

c=zeros(size(y)-10);      %auto correlation
for i=1:length(y)-10
    sum=0;
    for j=i:i+10
        sum=sum+y(j);
    end
    sum=sum/10;
    c(i)=sum;
end

figure(3);
plot(c);
xlabel('Time');
ylabel('Amplitude');
title('Auto Corelation');

N = length(c);               %psd
xf = fft(c);
xf = xf(1:N/2+1);
p = (1/(fs*N)) * abs(xf).^2;
p(2:end-1) = 2*p(2:end-1);
freq = 0:fs/length(c):fs/2;
figure(4);
plot(freq,10*log10(p));
xlabel('Time');
ylabel('Amplitude');
title('Power Spectral density');
