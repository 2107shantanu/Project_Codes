fc=input('Enter the Cut Off Frequency'); %cutOffFrequency
d_f=input('Enter the Transition band');%Transition Band
A=input('Enter the StopBand attenuation'); %As

if(A>21)
    beta=0;
end

if(A>=21&&A<=50)
    beta=0.07886*(A-21);
end

if(A>50)
    beta=0.1102*(A-8.7);
end

M=(A-8)/2.285*(2*pi*d_f);
L=M+1;

%{
w=kaiser(L,beta);
wvtool(w);
%}

alpha=M/2; %Group delay
%n=0:1:M;
wc=2*pi*fc;
 Dem=besseli(0,beta);
for n=0:1:M
    a=beta*sqrt((1-((n-alpha)/alpha)*((n-alpha)/alpha)));
    Num=besseli(0,a);
    w(n+1)=Num/Dem;
    h_i(n+1)=sin(wc*(n-M/2))/pi*(n-M/2);
end

h_n=h_i.*w;
plot(h_i);
figure;
