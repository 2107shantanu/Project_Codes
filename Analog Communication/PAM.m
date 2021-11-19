fm=10;                  %modulating frequency
fs=50;                   %sampling frequency
duty=0.2;                  %dutycycle
pulseWidth=duty/fs;
t=0:pulseWidth/10:1;
tunit=fs*t;
m=cos(2*pi*fm*t);
figure(1);subplot(3,1,1);
plot(t,m);
title('Message Signal');
                                               %Pulse Train
rect=1*(tunit-floor(tunit)<duty);
figure(1);subplot(3,1,2);
plot(t,rect);
title('Carrier Signal Impulse response');
                                                 %Modulating
mod=m.*rect;
figure(1);subplot(3,1,3);
plot(t,mod,t,m,'--');
title('Modulated Signal');

