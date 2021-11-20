function []=tri_wave(f,fs,int_t,fin_t)    %triangular wave generation
T=int_t:1/fs:fin_t;
t=f*T;
%t=t+0.5;
tri=2*(t-floor(t)).*(t-floor(t)<0.5)+-2*(t-ceil(t)).*((ceil(t)-t)<=0.5);
stem(T,tri);
title('triangular wave sampling');
end
