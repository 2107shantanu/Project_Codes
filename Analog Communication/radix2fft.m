t = -5:0.01:5;       
y = sin(3.*t);
N = length(y);          %signal

if N<2
    error('Samples must be greater than 2.')      %error check
end

X_T = myfft(y,[]);
figure('Name','DIT FFT Magnitude and Phase');
subplot(3,1,1);
plot(t,y,'linewidth',2);
xlabel('Time axis');
ylabel('Amplitude');
title('Original Signal');            %Orignal Signal
subplot(3,1,2);
plot(abs(fftshift((X_T))),'linewidth',2);
xlabel('Samples');
ylabel('Magnitude');
title('Magnitude Response');              %Magnitude Response
subplot(3,1,3);
plot(phase(fftshift((X_T))),'linewidth',2);
xlabel('Samples');
ylabel('Phase');
title('Phase Response');                 %phase Response
