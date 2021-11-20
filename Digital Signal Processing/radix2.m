function Z =radix2(x)     %for 1st iteration
N=length(x);           %length power of 2

even_index = 1:2:N-1;  %index
odd_index = 2:2:N;

e= x(even_index);   %generating sequences
o= x(odd_index);

E=fft(e);          %DFT N/2 point
O=fft(o);

E1=[E E];           %extension
O1=[O O];

k=0:N-1;
W=-exp(-1i*2*pi*k/N);

Z=E1+W.*O1;        %formula

end
