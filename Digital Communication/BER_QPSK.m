clear all;                                           
close all;                                            
l=1e6;
SNRdB=1:1:20;
SNR=10.^(SNRdB/10); 
f=l;
T=1/l;
t=T/99:T/99:T;
y=[];
x_in=[];
x_qd=[];
signal_in=[];
s_q=[];
c=[];
QPSK=[];
M=4;
for n=1:length(SNRdB)
    si=2*(round(rand(1))-0.5);                    
    signal_in=[signal_in si];
    sq=2*(round(rand(1))-0.5);   
    s_q=[s_q sq]; 
    
    y1=si*cos(2*pi*f*t);
    y2=sq*sin(2*pi*f*t) ;
    x_in=[x_in y1]; 
    x_qd=[x_qd y2]; 
    QPSK=[QPSK y1+y2];
    
    s=si+j*sq;                                        
    w=(1/sqrt(2*SNR(n)))*(randn(1,l)+j*randn(1,l));  
    r=s+w; 

    si_=sign(real(r));                                
    sq_=sign(imag(r));                           
    ber1=(l-sum(si==si_))/l;                      
    ber2=(l-sum(sq==sq_))/l;                     
    ber(n)=mean([ber1 ber2]); 


    if(si==1&&sq==1)             %detection
        q(n)=0;
    elseif(si==1&&sq==-1)
        q(n)=1; 
    elseif(si==-1&&sq==1)
        q(n)=2;
    else 
        q(n)=3;
    end
end

i=1;
t1=0:1/100:length(signal_in)-1/100;
for j=1:length(t1)
    if t1(j)<=i
        inp(j)=signal_in(i);
        qp(j)=s_q(i);
    else
        inp(j)=signal_in(i);
        qp(j)=s_q(i);
        i=i+1;
    end
end

subplot(311);
plot(inp);
axis([0 1000 -1.2 1.2]);
xlabel('Time');
ylabel('Amplitude');
title('In-phase Signal');
subplot(312);
plot(qp);
axis([0 1000 -1.2 1.2]);
xlabel('Time');
ylabel('Amplitude');
title('Quadrature Signal');
subplot(313);
plot(QPSK);
xlabel('Time');
ylabel('Amplitude');
title('QPSK Signal');
figure();
semilogy(SNRdB, ber,'bo-')                                
xlabel('SNR(dB)')                                   
ylabel('SER')   
title('SER of QPSK');
grid on
hold on
BER_th=(1/2)*erfc(sqrt(SNR)); 
semilogy(SNRdB,BER_th,'r*-');
axis([0 10 10^-5 1]);

mod = pskmod(q,M,0);
SNRdB = 20;
r = awgn(mod,SNRdB,'measured');
scatterplot(r);
