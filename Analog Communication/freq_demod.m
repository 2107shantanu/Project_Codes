Fs = 100e3; % Sampling frequency for audio
dt = 1/Fs;   %to reduce number of elements in the vector and increase 
  %             calaulation time.
T = 1;
%t = 0:dt:T/2;
t = (0:Fs-1)/Fs;
df = 1/T;
Fmax = 1/2/dt;
f = -Fmax:df:Fmax-1;

% Carrier

fc = 10e3;

% Information - Time domain

fm = 200;   %in Hz

Am = 1;

Kp = 7.5;    

ym = Am*sin(2*pi*fm.*t);

deltaF = Kp*Am;

% Modulation

beta = deltaF/(fm);

y = 4*cos(2*pi*fc.*t+beta*sin(2*pi*fm.*t));

% Frequency domain

Y = fftshift(fft(y))/length(y);  

% Plots - Time domain

figure(1);

subplot(211), plot(t,cos(2*pi*fm.*t)),axis([0.21 0.221 -1.5 1.5]), grid on;

subplot(212), plot(t,y), axis([0.21 0.221 -5 5]), grid on;

% Plots - frequency domain

figure(2);

plot(f,10*log10(abs(Y))), grid on;

%end code
