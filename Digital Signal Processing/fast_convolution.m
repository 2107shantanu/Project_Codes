function s = fastconv(xn,hn,n)
l=length(xn)+length(hn)-1;
p=pow2(nextpow2(l));
%m = nextpow2(l);
%L = 2^m;
%pad_val = L-length(xn);
%z = [xn zeros(1,pad_val)];
hlp=[h zeros(length(h),length(x)+length(h)];
xn=xn(1:n);
H=fft(hn,n);
i=1;
s=0;
while i<length(xn)-n
    xn=xn(i:i+n);
    X=fft(xn,p);
    a=ifft(X.*H);
    s=s+a;
    i=i+n;

s = ifft(X.*H);
s= s(1:1:l);

end
