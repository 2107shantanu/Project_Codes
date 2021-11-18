d=randi([0 1],10,1); % information

figure(1)
stem(d, 'linewidth',3);
title(' Binary Random Input data ');

d_NZR=2*d-1;       % Data Represented at NZR form
q_i_data=reshape(d_NZR,2,length(d)/2);  % Breaking into odd-even

br=10.^6;      %Let us transmission bit rate  1000000
f=br;          % minimum carrier frequency
T=1/br;        % bit duration
t=T/99:T/99:T; % Time vector for one bit information

y=[];
y_in=[];
y_qd=[];
for(i=1:length(d)/2)
    y1=q_i_data(1,i)*cos(2*pi*f*t);  % inphase component
    y2=q_i_data(2,i)*sin(2*pi*f*t);  % Quadrature component
    y_in=[y_in y1];                  % inphase signal vector
    y_qd=[y_qd y2];                  %quadrature signal vector
    y=[y y1+y2];                     % modulated signal vector
end

Tx=y;           % transmitting signal after modulation
tot=T/99:T/99:(T*length(d))/2;
figure(2)
subplot(3,1,1);
plot(tot,y_in,'linewidth',3);
title(' wave form for inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt');
subplot(3,1,2);
plot(tot,y_qd,'linewidth',3);
title(' wave form for Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt');
subplot(3,1,3);
plot(tot,Tx,'r','linewidth',3);
title('QPSK modulated signal (sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel(' amplitude(volt');
