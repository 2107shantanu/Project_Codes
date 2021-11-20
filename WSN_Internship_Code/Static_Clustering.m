xm=100;
ym=100;
sink.x=0.5*xm; %sink structure
sink.y=0.5*ym;
n=20;
E_elec = 50 * 10^(-9); %(joules)
E_amp = 100 * 10^(-12); %(joules)
k=2000; %1 bit data
Eo=0.5; %(joules)    %100 random network
for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    S(i).yd=rand(1,1)*ym;
end
S(n+1).xd=sink.x;
S(n+1).yd=sink.y;


p=0.2;                    % change after making optimization
No=p*n;
v=zeros(1,n);
S(1).id=0;
for i=2:1:n+1
    S(i).id=i-1;
    v(1,i-1)=S(i).id;
end
B=nchoosek(v,No);      %possible Sub-station(SS)
b=size(B,1);
Sub_Station=zeros(1,No);



for i=2:1:n+1
    for j=2:1:n+1
        S(i).temp_dist(j)=(((S(i).xd) - (S(j).xd))^2) + (((S(i).yd) - (S(j).yd))^2);
    end
end

S(1).sum_sub=0;
a3=10000000;                %arbitary large
for i=1:1:b
    for j=1:1:No
        for h=2:1:n+1
            if B(i,j)==S(h).id
                Sub_Station(1,j)=S(h).id;
            end
        end
    end
    for h=2:1:n+1
        Sub_Station1=Sub_Station;               %Sub-Station
        S(h).sub=min(S(h).temp_dist(Sub_Station+1));
    end
    Sub_Station3=Sub_Station;
    for r=2:1:n+1
        a1=S(r).sub; 
        S(r).sum_sub=S(r).sub+S(r-1).sum_sub;
    end
    a2=S(n+1).sum_sub;
    if a2<a3
        a3=a2
        Sub_Station2=Sub_Station       %a3=Sum of static clustering model distance
    end
end
