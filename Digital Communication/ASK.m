r= randi([0 1],10,1); %random input
n=length(r);
fc1=5;                % carrier freq
fs=100;              % sampling freq
t=0:1/fs:n;

x=1:1:(n+1)*fs;
for i=1:n
    for j=i:1:i+1
        m(x(i*fs:(i+1)*fs))=r(i); %input data
    end
end
m=m(1*fs:end);

x=sin(2*pi*fc1*t);  % carrier signal
for i=1:1:n
    y=m.*x;        % modulated signal
end


subplot(3,1,1)
plot(t,m)
title('Input Data Signal')

subplot(3,1,2)
plot(t,x)
title('Unmodulated Carrier')

subplot(3,1,3)
plot(t,y)
title('Binary Amplitude Shift-Keying')
