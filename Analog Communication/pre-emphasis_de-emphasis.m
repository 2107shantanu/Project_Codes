%pre-emphasis
w1=2*pi*2100;
w2=2*pi*30000;
s=tf('s');

H1=(w2/w1)*((s+w1)/(s+w2));    %Pre-emphasis transfer function
ts=0.001;
H1D=c2d(H1,ts);                %discrete transfer function
figure(1);
subplot(211)
bode(H1);                       %bodeplot
t=0:ts:4;
u1=max(0,min(t-1,1));
figure(1);
subplot(212)
lsim(H1D,u1,t);                %linear simulation model

%de-emphasis
H2=w1/(s+w1);                %De-emphasis transfer function
H2D=c2d(H2,ts);              %discrete transfer sunction
figure(2);
subplot(211);
bode(H2);                    %bodeplot
t=0:ts:4;
u2=-(max(0, min(t-1,1)));
figure(2);
subplot(212);
lsim(H2D,u2,t);              %linear simulation modulation
