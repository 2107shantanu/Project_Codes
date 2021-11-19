function X = myfft(x,N)
if isempty(N) == 1
    N = length(x);
    xin = zero_pad(x,N);
end 
if isempty(N) == 0
    if N>=length(x) 
    xin = zero_pad(x,N);
    else
    xin = truncate(x,N);
    end 
end 
M = length(xin);
[A] = dftmtx(M/2);
x_even = xin(1:2:end); % even and odd separation
x_odd = xin(2:2:end);
s1 = (x_even*A); % fft computation

W = zeros(1,M/2);
for k = 1:M/2
    W(k) = exp(-1j*2*pi*(k-1)/(M));
end 

s2 = W.*(x_odd*A);
X1 = s1+s2;
X2 = s1-s2;
X = [X1 X2]; % final output.
end 
