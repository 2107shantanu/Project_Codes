clc;
clear;
fs=300;
N=0:1/fs:1;
noise=0.5-rand(1,length(N));
figure (1);
plot(N,noise);
title('White Noise');
for i=1:length(N)
if (i>=0)
    y(i)=power(0.9,i); 
else
    y(i)=0;
end
end

figure(2);
plot(N,y);
title('Low Pass Filter');
figure(3);

cn=conv(noise,y);          %Low pass noise
plot(cn);
title('Low Pass noise');

figure (4);
for k=1:(length(cn)-1)
x1=zeros(1,length(cn));

for i=1:length(cn)
    x1(i+k)=cn(i);
end

s=0;
for i=k:length(cn)
    s=s+(x1(i)*cn(i));
end

avg(k)=s/(length(cn)-k);
end

subplot(211);                     %autocorrelatioin
plot(avg);
title('Autocorrelation');

subplot(212);                   %PSD
psd=abs(fftshift(fft(avg)));
plot(psd);
title('Power Spectral Density');
