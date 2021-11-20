symbol = {'1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'};
low_Freq = [697 770 852 941];           % Low frequency group
high_Freq = [1209 1336 1477 1633];    % High frequency group

%Creating matrix matrix
f  = [];                               %2x16 matrix
for c=1:4
    for r=1:4
        f= [ f [low_Freq(c);high_Freq(r)] ];
    end
end

%Taking Input for keypad
fs=12000;
t = 0:1/fs:1-1/fs;                 % t =0-0.5;
inp='7';                         % input by the keypad
for l=1:length(symbol)
    if(strcmp(inp,symbol(l)))    %String comparison gives
        break;
    end
end 

% from this we will contain the correct index of the key
fl=f(1,l);                   % low freq along the coloumn
s_low=sin(2*pi*(fl)*t);      % discrete sine wave for the low freq
fh=f(2,l);                   % high freq along the row
s_high=sin(2*pi*(fh)*t);     % discrete sin wave for high freq
y=(s_low+s_high)/2;          %final wave
figure;
F=0:1/fs:fs/2;
plot(t,y);
xlim([0 0.015]);
title('Input Wave');
figure(); 

%Spectrum of wave          
N = length(y);
Spec_y=fftshift(fft(y));
dF = fs/N;                             % hertz                
fr = -fs/2:dF:fs/2-dF;
stem(fr,abs(Spec_y));
xlim([0 2000]);
sound(y,fs);                            
p=abs(fft(y));                 %fft is complex
title('Input Wave Spectrum');


%Detection
k=find(p>600,2);                %find and store in K >p
index_low=k(1)-1;               %lower K value  (Hz)
index_high=k(2)-1;              %higher K value


for i=1:16                                  %comparing from start and storing
        if((f(1,i)==index_low)&&(f(2,i)==index_high))
            break;
        end
    
end

figure;
subplot(211);
s1=sin(2*pi*(index_low)*t);
plot(t,s1);
title('Low and High Frequency');
xlim([0 0.015]);
subplot(212);
s2=sin(2*pi*(index_high)*t);
plot(t,s2);
xlim([0 0.015]);
fprintf('The Low frequency is %iHz\n the High Frequency is %iHz\n ',index_low,index_high);
celldisp(symbol(i));
