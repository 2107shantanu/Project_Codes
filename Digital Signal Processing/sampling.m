time=1;
fm=30;
T=1/fm;
t=0:0.00005:time;
xm=1*cos(2*pi*fm*t);
figure(1);
subplot(3,1,1);
plot(t,xm);
subplot(3,1,2);
stem(t,xm);

N=length(xm);
fftSignal=fft(xm);
fftSignal=fftshift(fftSignal);
f=fm*(-N/2:N/2-1)/N;
figure(1);
subplot(3,1,3);
plot(f,abs(fftSignal));



fs1=1.3*fm;
T1=1/fs1;
t1=0:T1:time;
x1=1*cos(2*pi*fm*t1);
figure(2);
subplot(3,1,1)
plot(t,xm,'b',t1,x1,'*-r');

N1=length(x1);
fftSignal1=fft(x1);
fftSignal1=fftshift(fftSignal1);
f1=fs1*(-N1/2:N1/2-1)/N1;
figure(3);
subplot(3,1,1);
stem(t1,x1);
figure(4);
subplot(3,1,1);
plot(f1,abs(fftSignal1));



fs2=2*fm;
T2=1/fs2;
t2=0:T2:time;
x2=1*cos(2*pi*fm*t2);
figure(2);
subplot(3,1,2)
plot(t,xm,'b',t2,x2,'*-r');

N2=length(x2);
fftSignal2=fft(x2);
fftSignal2=fftshift(fftSignal2);
f2=fs2*(-N2/2:N2/2-1)/N2;
figure(3);
subplot(3,1,2);
stem(t2,x2);
figure(4);
subplot(3,1,2);
plot(f2,abs(fftSignal2));



fs3=7*fm;
T3=1/fs3;
t3=0:T3:time;
x3=1*cos(2*pi*fm*t3);
figure(2);
subplot(3,1,3)
plot(t,xm,'b',t3,x3,'*-r');

N3=length(x3);
fftSignal3=fft(x3);
fftSignal3=fftshift(fftSignal3);
f3=fs3*(-N3/2:N3/2-1)/N3;
figure(3);
subplot(3,1,3);
stem(t3,x3);
figure(4);
subplot(3,1,3);
plot(f3,abs(fftSignal3));





