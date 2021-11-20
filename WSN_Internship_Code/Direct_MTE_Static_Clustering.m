% Direct                       %MTE                  %Static Clustering
xm=100;
ym=100;
sink.x=0.5*xm; %sink structure
sink.y=0.5*ym;
n=80;
E_elec = 50 * 10^(-9); %(joules)
E_amp = 100 * 10^(-12); %(joules)
k=2000; %1 bit data
Eo=0.5; %(joules)

figure(1);     %100 random network
for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    XR(i)=S(i).xd;
    S(i).yd=rand(1,1)*ym;
    YR(i)=S(i).yd;
    %initially there are no cluster heads only nodes
    S(i).type='N';
    plot(S(i).xd,S(i).yd,'o');
    drawline([S(i).xd S(i).yd] , [sink.x sink.y]);
    title({'Direct Communication Transmission';})
    hold on;
end
S(n+1).xd=sink.x;
S(n+1).yd=sink.y;
S(n+1).sq_dist=0;

plot(S(n+1).xd,S(n+1).yd,'rx');


%%%%%%%%%%%%%%%%%%%%%% Direct Communication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:1:n
    S(i).sq_dist=(((S(i).xd) - (S(n+1).xd))^2) + (((S(i).yd) - (S(n+1).yd))^2);
    S(i).E_direct = k*(E_elec +E_amp *(S(i).sq_dist));  %transmit only
end

%%%%%%%%%%%%%%%%%%%%%%%%%% MTE Communication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
for i=1:1:n
    plot(S(i).xd,S(i).yd,'o');
    title({'MTE Transmission';})   
    hold on;
end
plot(S(n+1).xd,S(n+1).yd,'x');


          %%check

min_SqD = S(1).sq_dist;
for i=1:1:n
    if S(i).sq_dist < min_SqD
        min_SqD = S(i).sq_dist;
    end
end
[~,index] = sortrows([S.sq_dist].'); S = S(index); clear index  %sorting
        %%check



S(2).eff_dist = S(2).sq_dist;
S(2).trans_dist = S(2).eff_dist;
figure(2);
drawline([S(2).xd S(2).yd] , [sink.x,sink.y]);
hold on;
%%%%% drawline %%%%%
for i=3:1:n+1
    for j=2:1:i-1
        T(i).T(j)=(((S(i).xd) - (S(j).xd))^2) + (((S(i).yd) - (S(j).yd))^2);
    end
end


C=zeros(n+1);
for i=3:1:n+1
    S(i).eff_dist=S(i).sq_dist;
    for j=2:1:i-1
        if T(i).T(j)+S(j).eff_dist < S(i).eff_dist    % 0  result eliminate
           S(i).eff_dist=T(i).T(j)+S(j).eff_dist;
           C(i,j)=T(i).T(j)+S(j).eff_dist;  
        end     
    end 
end

for i=3:1:n+1
    if  S(i).eff_dist==S(i).sq_dist
        S(i).trans_dist=S(i).eff_dist;
        figure(2);
        drawline([S(i).xd S(i).yd] , [sink.x,sink.y]);
        hold on;
    end
end

for j=1:1:n+1
S(j).bit_counter=0;
S(j).bits_count=0;
S(j).addn_bits=0;
end

D(n+1,n+1)=0;

for i=3:1:n+1
    for j=n+1:-1:2
        if C(i,j)==0
            continue
        else
            S(i).trans_dist=S(i).eff_dist-S(j).eff_dist;
            figure(2);
            drawline([S(i).xd S(i).yd], [S(j).xd S(j).yd]);
            hold on;
            S(j).bit_counter=S(j).bit_counter + k;
            S(i).bits_count=S(i).bits_count + k;
            D(i,j)=1;
            break
        end
    end
end


        
        
S(1).E_MTE=0;
S(1).E_direct=0;
for j=n+1:-1:2
    for i=1:1:n+1
        if D(i,j)==0
            continue
        else
            S(j).addn_bits=S(j).addn_bits+S(i).addn_bits+k; %k=1
        end
    end
end


S(1).total_bits=0;
for i=2:1:n+1
    S(i).total_bits=S(i).addn_bits+k;
    S(i).E_MTE=S(i).total_bits * (E_elec+(E_amp* S(i).trans_dist))+ S(i).addn_bits * E_elec;         %transmit + receive
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ENERGY  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_E_direct=0;
Total_E_MTE=0;
for i=1:1:n+1
    Total_E_direct = Total_E_direct + S(i).E_direct;
    Total_E_MTE = Total_E_MTE + S(i).E_MTE;
end


round=2000;
S(1).Eod=0;
S(1).EoM=0;
S(1).EoS=0;
for i=2:1:n+1
    S(i).Eod=0.5;
    S(i).EoM=0.5;
    S(i).EoS=0.5;
end

dead_direct=0;

for i=1:1:round
    dead1(i)=0;
    dead2(i)=0;
    dead3(i)=0;
    TE_direct(i)=0;
    TE_MTE(i)=0;
    TE_Static(i)=0;
    Tbits_MTE(i)=0;
    Tbits_Static(i)=0;
end


for i=1:1:round
    for j=2:1:n+1
        S(j).Eod=S(j).Eod - S(j).E_direct;
        if S(j).Eod<=0
            dead1(i)=dead1(i)+1;
        end
        if S(j).Eod>=0
            TE_direct(i)=TE_direct(i)+S(j).E_direct;
        end
    end
end

for i=2:1:n+1
    if S(i).Eod<=0
        figure(1);
        plot(S(i).xd,S(i).yd,'k*');
        hold on;
        dead_direct=dead_direct+1;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%  MTE ENERGY  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dead_MTE=0;
for i=1:1:round
    for j=2:1:n+1
        S(j).EoM=S(j).EoM - S(j).E_MTE;
        if S(j).EoM<=0
            dead2(i)=dead2(i)+1;
        end
        if S(j).EoM>=0
            TE_MTE(i)=TE_MTE(i)+S(j).E_MTE;
            if S(j).EoM>=0 && S(j).bits_count==0
                Tbits_MTE(i)=Tbits_MTE(i)+S(j).total_bits;
            end
            
        end
    end
end

for i=2:1:n+1
    if S(i).EoM<=0
        figure(2);
        plot(S(i).xd,S(i).yd,'k*');
        hold on;
        dead_MTE=dead_MTE+1;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% STATIC CLUSTERING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=0.05;                    % change after making optimization
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
        a3=a2;
        Sub_Station_Final=Sub_Station;      %a3=Sum of static clustering model distance
    end
end

g=size(Sub_Station_Final);
f=g(2);
S(1).subfinal_dist=0;

for i=2:1:n+1
        S(i).subfinal_dist=min(S(i).temp_dist(Sub_Station_Final+1));
end

S(1).sub_stationid=0;

for i=1:1:n+1
    S(i).sub_counter=0;
end


figure(3);
for i=2:1:n+1
    plot(S(i).xd,S(i).yd,'o');
    title({'Static Clustering Transmission';})
    hold on;
end
plot(S(1).xd,S(1).yd,'x');


for i=2:1:n+1
    for j=2:1:n+1
        if S(i).subfinal_dist==S(i).temp_dist(j)
            S(i).sub_stationid=j;                   %draw 
            S(j).sub_counter=S(j).sub_counter+1;
            figure(3);
            drawline([S(i).xd S(i).yd] , [S(j).xd,S(j).yd]);
            hold on;
        end
    end
end

for i=2:1:n+1
    if S(i).sub_counter>0
        S(i).type='S';
    end
end

for i=2:1:n+1
    if S(i).type=='S'
        figure(3);
        drawline([S(i).xd S(i).yd] , [sink.x,sink.y]);
    end
end
        
%%%%%%%%%%%%%%  STATIC ENERGY  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dead_Substation=0;
S(1).E_Static=0;
for j=2:1:n+1
    if S(j).type=='S'
        S(j).E_Static=S(j).sub_counter*k*(E_elec+(E_amp*S(j).sq_dist)) + (S(j).sub_counter-1)*k*E_elec;  %transmit+receice
    end
    if S(j).type=='N'
        S(j).E_Static=k*(E_elec+(E_amp*S(j).subfinal_dist));
    end
end

for i=1:1:round
    for j=2:1:n+1
        S(j).EoS=S(j).EoS - S(j).E_Static;
        if S(j).EoS<=0
            dead3(i)=dead3(i)+1;
        end                                           %break if dead = sub station
        if S(j).EoS>=0
            TE_Static(i)=TE_Static(i)+S(j).E_Static;
            if S(j).EoS>=0 && S(j).sub_counter>0
                Tbits_Static(i)=Tbits_Static(i)+S(j).sub_counter*k;
            end
        end
    end
    if dead3(i)==f
        dead3(i)=n;          %change with alive
        break
    end
end


figure(4)
plot(1:round, n-dead1(1:round),'-r', 'Linewidth',2);
hold on;
plot(1:round, n-dead2(1:round),'-b', 'Linewidth',2);
hold on;
plot(1:round, n-dead3(1:round),'-g', 'Linewidth',2);
title ({'No. of Operating Nodes';'Direct(Red),MTE(Blue),Static(Green)';})
xlabel 'Time rounds';
ylabel 'No. of nodes alive';
hold on;

figure(5)
plot(1:round, k*(n-dead1(1:round)),'-r', 'Linewidth',2);
hold on; 
% In direct bit packets reaching BS = k*(No. of operating nodes)
plot(1:round, Tbits_MTE(1:round),'-b', 'Linewidth',2);
hold on;
plot(1:round, Tbits_Static(1:round),'-g', 'Linewidth',2);
title ({'No. of data packets received at Base Station';'Direct(Red),MTE(Blue),Static(Green)';})
xlabel 'Time rounds';
ylabel 'No. of data packets received by BS(bits)';
hold on;

figure(6)
plot(1:round, TE_direct(1:round) ,'-r', 'Linewidth',2);
hold on;
plot(1:round, TE_MTE(1:round) ,'-b', 'Linewidth',2);
hold on;
plot(1:round, TE_Static(1:round),'-g', 'Linewidth',2);
title ({'Total System Energy Dissipated';'Direct(Red),MTE(Blue),Static(Green)';})
xlabel 'Time rounds';
ylabel 'Energy(J)';
hold on;
                     
                     
