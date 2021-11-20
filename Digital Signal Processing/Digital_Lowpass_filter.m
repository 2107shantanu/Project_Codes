clear;
close all;
clc;
  % Analog RC low pass filter  
wa=0:0.01:500; %analog frequency 
R=0.1; % 1ohm 
C=0.1; % 1F
j=sqrt(-1);
s=j*wa;              % laplace domain
Ha=1./(1+s*R*C);    % analog fitler transfer function
figure;
%fvtool(Ha);
semilogx(wa,abs(Ha));
grid on;
ylabel('Magnitute');
xlabel('Frequency(in log scale)');
title('Frequency Response of the RC low pass Analog Filter');

% Converting analog into digital
fs = 100;
T= 1/fs;                %1 sec, sampling time

z=zeros(1,length(wa));  %z domain transfer
for i=1:length(wa)
z(i)=exp(s(i)*T);
end

s_dig=zeros(1,length(wa));
for i=1:length(wa)
s_dig(i)=(2/T)*((z(i)-1)/(z(i)+1)); 
end

Hd=zeros(1,length(wa));    %digital filter 
for i=1:length(wa)
Hd(i)=1./(1+s_dig(i)*R*C);
end

wd=(2/T)*atan(wa*(T/2));
figure;
semilogx(wd,abs(Hd));  % plots x- and y-coordinates using a base-10 logarithmic scale on the x-axis and a linear scale on the y-axis.
ylabel('Magnitute');
xlabel('Frequency(in log scale)');
title('Frequency Response of the RC low pass Digital Filter');
grid on;


n=0:1/100:1;
x1=sin(2*pi*n*2);
x2=sin(2*pi*n*5);
x=x1+x2;
figure;
plot(n,x);
title('Sine signals');

[N,D]=abs(Hd);
y=filter(abs(N),abs(D),x);
figure;
plot(n,y);
title('Filtered Sine Signal');
