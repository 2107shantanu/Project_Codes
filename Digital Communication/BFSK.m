fc1= 2;
fc2= 5;
n=randi([0 1],1,10);
t=0:0.01:length(n);
x1 = cos(2*pi*fc1*t);
x2 = cos(2*pi*fc2*t);
 
for i = 1:length(n)
    if n(i)==1
        d(i)=1;
    else
        d(i)=0;
    end
end

i=1;
t=0:0.01:length(n);
for j=1:length(t)
    if t(j)<=i
        y(j)=d(i);
    else
        y(j)=d(i);
        i=i+1;
    end
end
subplot(4,1,1);
plot(t,y);
xlabel('Time');
ylabel('Amplitude');
title('Input signal');

subplot(4,1,2);
plot(t,x1);
xlabel('Time');
ylabel('Amplitude');
title('Low Frequency Carrier');

subplot(4,1,3);
plot(t,x2);
xlabel('Time');
ylabel('Amplitude');
title('High Frequency Carrier');

for j = 1:length(t)
    if y(j) == 0
        u(j)=x1(j);
    else
        u(j)=x2(j);
    end
end
subplot(4,1,4);
plot(t,u);
xlabel('Time');
ylabel('Amplitude');
title('BFSK Signal');
