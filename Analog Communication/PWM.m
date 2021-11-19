t = 0:0.001:1;
fc=100;
fs=1000;
fm=10;
figure(1);                           %msg signal
m = 1*sin(2*pi*fm*t);
subplot(3,1,1);
plot(t,m);
title('Message Signal');
                                     %sawtooth carrier
c = -sawtooth(2*pi*fc*t);
subplot(3,1,2);
plot(t,c);
title('Carrier Signal');
            
sum = c+m;                            %adder
subplot(3,1,3);
plot(t,sum);
title('Adder Output');
                                %modulation and comparator
y=zeros(size(sum));
n=length(sum);
for i=1:n
    if sum(i)>0
        y(i)=1;
    else
        y(i)=0;
    end
end
figure(2);
plot(t,y);
title('PWM Signal');

                                 %demodulation
samp=(2*pi*fm)/1000;
[a,b]=butter(2,samp);
figure;
demod=filter(a,b,y);
plot(t,demod);
xlim([0.1 0.5])
hold on;
plot(t,m);
xlim([0.1 0.5])

