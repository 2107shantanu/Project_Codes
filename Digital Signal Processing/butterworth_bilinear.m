delta1 =0.8 ;
delta2 =0.2 ;
wp =  0.628;
ws = 0.6*3.14;
T = 1;
%Analog Frequencies Calculated using Bilinear Transformation
omegap = (2/T)*tan(wp/2);
omegas = (2/T)*tan(ws/2);
%calcualte filter order
den = 2*log10(omegas/omegap);
delta = ((1/(delta2^2))-1);
epsi  = ((1/(delta1^2))-1);
num = log10(delta/epsi);
N = ceil(num/den);
%To Calculate the Analog Cut off frequency
omegac = omegap/(epsi^(1/(2*N)));
wc = 2*atan(omegac/2);
[b,a] = butter(N,wc/pi);
[H,W] = freqz(b,a,128);
plot(W/pi,20*log10(abs(H)));
grid on;
xlabel('Frequency x Pi in radians per sample');
ylabel('Magnitude in dB');
title('Butterworth Filter Design using Bilinear Method');
        
