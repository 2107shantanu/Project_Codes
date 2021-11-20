function []=kaiser_window(fc,a,delw)
    b=beta(a);
    wc=fc/(2*pi);
    m=(a-8)/(2.285*delw);
    wind=window(m,b);
    fres=filter_response(wc,m,wind);
    n=1:m;
    f=-0.5:1/m:0.5-1/m;
    figure(1);
    plot(n,wind);
    title('kaiser window');
    fvtool(wind);
    ffty=abs(fftshift(fft(fres)));
    figure(2);
    plot(f,ffty);
    title('frequency response');
end
