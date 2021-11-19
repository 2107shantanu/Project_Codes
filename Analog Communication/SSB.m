fm=50;
fc=1000;
fs=20000;
Ts=1/fs;
N=1200;
t=(1:N)*Ts;

x1=cos(2*pi*fm*t).*cos(2*pi*fc*t);
figure(1)
plot(t,x1);
title('DSB-SC signal');

x2=sin(2*pi*fm*t).*sin(2*pi*fc*t);        %hilbert transform
figure(2)
plot(t,x2);
title('DSB-sc signal');

x=x1+x2;
figure(3)
plot(t,x);
title('SSB band X')

X=fftshift(fft(x));
f=-fs/2:fs/N:(fs/2-fs/N);
figure(4)
plot(f,abs(X));
title('Fourier Transform of SSB');

%band pass filter
S=zeros(length(X),1);
%cropping USB
for i=1:length(X)
   
   if(f(i)>=(fc-fm)&&f(i)<=(fc+fm))
      S(i)=X(i);
   else
      S(i)=0;
   end
    
end
figure(5)
plot(f,abs(S));
title('Spectrum of SSB-SC Modulated Signal');
Q=ifft(ifftshift(S));
figure(6)
plot(t,Q);
title('Modulated Signal Using SSB');


