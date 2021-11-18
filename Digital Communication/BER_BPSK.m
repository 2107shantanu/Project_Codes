clc; clear all; close all;

N=10;
M=2;
x=round(rand(1,N));                                                                           
nsb=100;
fs=N*nsb;  
bit=[]; 
bits=[]; 

for n=1:1:length(x)
    if x(n)==1;
       signale=ones(1,nsb);
    else x(n)==0;
        signale=zeros(1,nsb);
    end
     bit=[bit signale];
end

bits=2*bit-1;

t=0:1/fs:1-1/fs;
subplot(411);
plot(t,bit)
axis([ 0 1 -0.2 1.2]);
ylabel('amplitude');
xlabel(' time');
title('Binary signal');

subplot(412);
plot(t,bits)
axis([ 0 1 -1.2 1.2]);
ylabel('amplitude');
xlabel(' time');
title('Binary signal');

t1=0:1/(N*fs):1-1/(N*fs);
subplot(413);
plot(t1,sin(2*pi*3*10*t1));
ylabel('amplitude');
xlabel(' time');
title('Carier signal');

A=1;
fc=4;                                                           
BPSK=[];

for (i=1:1:length(x))
    if (x(i)==1)
        y=A*sin(2*pi*fc*t+0);
    else
        y=A*sin(2*pi*fc*t+pi);
    end
    BPSK=[BPSK y];
end

subplot(414);
plot(t1,BPSK);
xlabel('time');
ylabel('amplitude');
title('Binary BPSK modulation');

N = 1e7;
E = 0:.5:12;
c = [-1 1];
nError = zeros(1,length(E));
for i=1:length(E)
    m = randsrc(1,N,c);
    n = 1/sqrt(2)*10^(-E(i)/20) * randn(1,N);
  
   X = m+n;
   
   for j=1:N
       if (X(j)>0)
           x(j)=1;
       else
           x(j)=-1;
       end
   end
   counter = 0;
   for k=1:N
       if (x(k)~=m(k))
           counter=counter+1;
       end
   end
   nError(i) = counter;
end
snr = 10.^(E./10);
P = qfunc(sqrt(2*snr));
figure()

semilogy(E,P,'k-','LineWidth',1.5)
BER = nError/N;
hold on

semilogy(E,BER,'rO','LineWidth',1.5)
xlabel('SNR (dB)')
ylabel('BER')
title ('BER for BPSK')
grid on 

s = pskmod(bit,M,0);
SNR = 20;
r = awgn(s,SNR,'measured');
scatterplot(r);
