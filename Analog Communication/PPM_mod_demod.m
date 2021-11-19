fs=100000;
t=0:1/fs:1;
fm=10;
fc=100;
duty=0.5;
sam=fs/fc;                          %samples per period
ontime=sam*duty;                     %on time ppm

m=0.6*sin(2*pi*fm*t);
c=sawtooth(-2*pi*fc*t);
y=m+c;                                   %adder

figure(1);      
subplot(4,1,1);
plot(t,m);
title('Message signal');

subplot(4,1,2);
plot(t,c);
title('Sawtooth function');

subplot(4,1,3);
plot(t,y);
title('Sawtooth + Message signal adder');
grid('on');

%pwm waveform
n=length(y);
for i=1:n
    if (y(i)>=0)
        pwm_wave(i)=1;
    else
        pwm_wave(i)=0;
    end
end

subplot(4,1,4)
plot(t,pwm_wave);
title('PWM waveform');

%ppm waveform
y1=diff(pwm_wave);
y1=[0,y1];

for i=1:length(y1)
    if y1(i)>0
        y1(i)=0;
    end
end

for i=1:length(y1)
    y1(i)=-y1(i);                %impulses
end

figure(2);
subplot(3,1,1)
plot(t,y1);
title("Impulses");

ind=find(y1);%indices of maxima

for i=1:length(ind)
    ppm_wave(ind(i):ind(i)+ontime)=1;       %ppm wave
end

add_zero=length(t)-length(ppm_wave);
ppm_wave=[ppm_wave,zeros(1,add_zero)];

subplot(3,1,2)
plot(t,ppm_wave);                         %ppm wave plot
title("PPM waveform");

%ppm to pwm converter
[pks,locks] = findpeaks(y);
pwm_new=zeros(1,100001);              %100001 total samples
for i=1:length(ind)
    pwm_new(locks(i):ind(i))=1;
end


subplot(3,1,3)
plot(t,pwm_new);
title("Converted PWM");

%demod part
nfc=2*fm/fs;
[a,b]=butter(3,nfc);
demod=filter(a,b,pwm_new);

figure(3);
subplot(2,1,1);
plot(t,demod);
title('Demodulated Signal');

subplot(2,1,2);
plot(t,m);
title('Message Signal');
