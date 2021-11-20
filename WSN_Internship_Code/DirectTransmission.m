round=200;
%S(1).Eod=0;
dead_direct=0;
xm=100;
ym=100;
sink.x=0.5*xm; %sink structure
sink.y=0.5*ym;
n=10;
E_elec = 50 * 10^(-9); %(joules)
E_amp = 100 * 10^(-12); %(joules)
k=20000; %1 bit data
Eo=0.5;

figure(1);
for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    S(i).yd=rand(1,1)*ym;
    plot(S(i).xd,S(i).yd,'bo');
    hold on
end

S(n+1).xd=sink.x;
S(n+1).yd=sink.y;
S(n+1).sq_dist=0;

plot(S(n+1).xd,S(n+1).yd,'rx');

for i=1:1:n
    S(i).sq_dist=(((S(i).xd) - (S(n+1).xd))^2) + (((S(i).yd) - (S(n+1).yd))^2);
    S(i).E_direct = k*(E_elec +E_amp *(S(i).sq_dist));  %transmit only
end   
   

for i=1:1:n+1
    S(i).Eod=0.5;
end

for i=1:1:round
    dead(i)=0;
    TE_direct(i)=0;
end

for i=1:1:round
    for j=1:1:n+1
        S(j).Eod=S(j).Eod-S(j).E_direct;
        if S(j).Eod<=0
           dead(i)=dead(i)+1;
        end
        if S(j).Eod>=0
           TE_direct(i)=TE_direct(i)+S(j).E_direct;
        end
    end
end

for i=1:1:n+1
    if S(i).Eod<=0
        dead_direct=dead_direct+1;
    end
end

figure(2)
plot(1:round, n-dead(1:round),'-r', 'Linewidth',2);
hold on;

figure(3)
plot(1:round, k*(n-dead(1:round)),'-r', 'Linewidth',2);
hold on; 
% In direct bit packets reaching BS = k*(No. of operating nodes)

figure(4)
plot(1:round, TE_direct(1:round) ,'-r', 'Linewidth',2);
hold on;
        

