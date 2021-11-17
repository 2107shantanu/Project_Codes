r= randi([0 1],10,1); %random input
n=length(r);
fc=5;                % carrier freq
fs=100;              % sampling freq
t=0:1/fs:n;

x=1:1:(n+1)*fs;
for i=1:n
    for j=i:1:i+1
        m(x(i*fs:(i+1)*fs))=r(i);  
    end
end
m=m(1*fs:end);      % input signal

for i=1:n
    for j=i:1:i+1
        u(x(i*fs:(i+1)*fs))=2*(r(i)-0.5);  %level converter
    end
end

u=u(1*fs:end);     % input signal
x=cos(2*pi*fc*t);  % carrier signal
y=u.*x;        % modulated signal

subplot(4,1,2)
plot(t,u)
title('Bipolar NRZ sequence')

subplot(4,1,3)
plot(t,x)
title('Carrier wave')

subplot(4,1,4)
plot(t,y)
title('BPSK waveform')

subplot(4,1,1)
plot(t,m)
title('Random Binary data Sequence')


