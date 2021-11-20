function [pd_rect,t]=pd_rect(int_t,fin_t,fs,f,a,d)
%[x,t]=rect_wave(inti_t,final_t,fs,a,d,f);
%inti_t is the initial Time.
%final_t is the final Time.
%fs is the sampling rate.
%a is the amplitude
%d is duty cycle,
%f is frequency
t=int_t:1/fs:fin_t;
pd_rect = a*square(2*pi*f*t,d);
pd_rect = (pd_rect + 1)/2 ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [pd_rect,t]=rect_wave(int_t,fin_t,fs,f,a,d)
%[x,t]=rect_wave(inti_t,final_t,fs,a,d,f);
%inti_t is the initial Time.
%final_t is the final Time.
%fs is the sampling rate.
%a is the amplitude
%d is duty cycle,
%f is frequency
t=inti_t:1/fs:final_t;
rect=a*square(2pi*f*t*d);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function []=rect_wave1(f,fs,amp,d,time)    %rectangular wave generation
t=0:1/fs:time;
tunit = f*t;                             %time scaling to be used
rect = amp*(tunit+d/2-floor(tunit+d/2)<d)*1;
stem(t,rect);
title('rectangular wave sampling');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
amp = input('enter amplitude');          %amplitude of wave=1
d = input('enter duty cycle');           %duty cycle=0.5
f = input('enter frequnecy of wave');    %frequency of rectangular wave=1
fs = input('enter sampling frequency');      %sampling frequency=20
time = input('enter time duration');     %time duration of wave=3
rect_wave1(f,fs,amp,d,time);             %rect_wave1(f,fs,amp,d,time)
