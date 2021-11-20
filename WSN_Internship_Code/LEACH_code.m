%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% LEACH Protocol MATLAB Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Uncomment line 81,82;99,100 to see full progress on node diagram 1%%%%
%%%%%%%%%%%%%%%%%%%%(It will take a lot of time to run) %%%%%%%%%%%%%%%%%%%

xm=100;             %Network Diameter
ym=100;             %Network Diameter
n=100;              %Initial No. of nodes
dead_nodes=0;       %No. of dead nodes
sink.x=50;          %Sink X-Co-ordinate
sink.y=50;          %Sink Y-Co-ordinate
Eo=0.5;             %Initial Energy of nodes (in Joules)
E_elec=50*10^(-9);  %Radio Electric Energy (in Joules/bit)
ETx=50*10^(-9);     %Transmission Energy (in Joules/bit)
ERx=50*10^(-9);     %Receiving Energy (in Joules/bit)
E_amp=100*10^(-12); %Amplifier Energy (in Joules/bit)
EDA=5*10^(-9);      %Data Aggreation Energy (in Joules/bit)
k=2000;             %Sie of Data packet (in bits)
p=0.05;             %Percentage of total amount of nodes used in the network is proposed to give results
No=p*n;             %Number of Clusters
rnd=0;              %Round of Operation
operating_nodes=n;  %Current no. of operating nodes
transmissions=0;
temp_val=0;
flag1stdead=0;

for i=1:n
    
    S(i).id=i;	            % sensor's ID number
    S(i).x=rand(1,1)*xm;	% X-axis coordinates of sensor node
    S(i).y=rand(1,1)*ym;	% Y-axis coordinates of sensor node
    S(i).E=Eo;              % nodes energy levels (initially set to be equal to "Eo"
    S(i).role=0;            % node acts as normal if the value is '0', if elected as a cluster head it  gets the value '1' (initially all nodes are normal)
    S(i).cluster=0;	        % the cluster which a node belongs to
    S(i).cond=1;	        % States the current condition of the node. when the node is operational its value is =1 and when dead =0
    S(i).rop=0;	            % number of rounds node was operational
    S(i).rleft=0;           % rounds left for node to become available for Cluster Head election
    S(i).dtch=0;	        % nodes distance from the cluster head of the cluster in which he belongs
    S(i).dts=0;             % nodes distance from the sink %%%%%% We have it past%%%%%
    S(i).tel=0;	            % states how many times the node was elected as a Cluster Head
    S(i).rn=0;              % round node got elected as cluster head
    S(i).chid=0;            % node ID of the cluster head which the "i" normal node belongs to
    
    hold on;
    figure(1)               %plotting 100 node random network
    plot(xm,ym,S(i).x,S(i).y,'o',sink.x,sink.y,'*r');
    title 'Wireless Sensor Network';
    xlabel '(m)';
    ylabel '(m)';
    
end

while operating_nodes>0          %Current Operating nodes
    rnd;                         % Current Round
    t=(p/(1-p*(mod(rnd,1/p))));  % Thresold value
    tleft=mod(rnd,1/p);          % Re-election value%
    CLheads=0;                   % Reset CLheads present in previous round
    energy=0;                    % Reset energy consumed in previous round
    data=0;                      % Reset data transferred in previous round
    for i=1:n
        S(i).cluster=0;    % reseting cluster in which the node belongs to
        S(i).role=0;       % reseting node role
        S(i).chid=0;       % reseting cluster head id
        if S(i).rleft>0    
            S(i).rleft=S(i).rleft-1;
        end
        if (S(i).E>0) && (S(i).rleft==0)
            generate=rand; 
            if generate<t               %generate random
                S(i).role=1;            % assigns the node role of a cluster head
                S(i).rn=rnd;            % Assigns the round that the cluster head was elected to the data table
                S(i).tel=S(i).tel+1;    %Assign the no. of times it had became a cluster head
                S(i).rleft=1/p-tleft;   % rounds for which the node will be unable to become a CH
                S(i).dts=sqrt((sink.x-S(i).x)^2 + (sink.y-S(i).y)^2); % calculates the distance between the sink and the cluster head 
                CLheads=CLheads+1;      % sum of cluster heads that have been elected
                CL(CLheads).x=S(i).x;   % X-axis coordinates of elected cluster head
                CL(CLheads).y=S(i).y;   % Y-axis coordinates of elected cluster head
                CL(CLheads).id=i;       % Assigns the node ID of the newly elected cluster head to an array
%                 figure(1);
%                 plot(S(i).x,S(i).y,'*r');                
            end     
        end
    end
    CL=CL(1:CLheads);  %Fixing the size of "CL" array acc. to no. of CHs %CL is struct and CLheads no. of CH
    
    %Grouping the Nodes into Clusters
    for i=1:n
        if (S(i).role==0)&&(S(i).E>0)&&(CLheads>0)        %if nodes is normal
            for m=1:CLheads
                d(m)=sqrt((CL(m).x-S(i).x)^2 + (CL(m).y-S(i).y)^2); %distance 'd' between the sensor node that is% transmitting and the cluster head that is receiving
            end
            d=d(1:CLheads);                   % fixing the size of "d" array
            [M,I]=min(d(:));                  % finds the minimum distance of node to CH
            [Row, Col] = ind2sub(size(d),I);  % displays the Cluster Number in which this node belongs to
            S(i).cluster=Col;                 % assigns node to the cluster
            S(i).dtch= d(Col);                % assigns the distance of node to CH
            S(i).chid=CL(Col).id;             % assigns the CH id
%             figure(1);
%             drawline([S(i).x S(i).y] , [S(S(i).chid).x S(S(i).chid).y]);
        end
    end
    
    
    
   %Energy Dissipation for normal nodes
   
   for i=1:n
       if (S(i).cond==1) && (S(i).role==0) && (CLheads>0)
       	if S(i).E>0
            ETx= E_elec*k + E_amp * k * S(i).dtch^2;
            S(i).E=S(i).E - ETx;
            energy=energy+ETx;
            
        % Dissipation and data transfer for cluster head during reception
        if S(S(i).chid).E>0 && S(S(i).chid).cond==1 && S(S(i).chid).role==1
            ERx=(E_elec+EDA)*k;
            energy=energy+ERx;
            data=data+k;
            S(S(i).chid).E=S(S(i).chid).E - ERx;
             if S(S(i).chid).E<=0  % if cluster heads energy depletes with reception
                S(S(i).chid).cond=0;
                S(S(i).chid).rop=rnd;
                dead_nodes=dead_nodes +1;
                figure(1);
                plot(S(S(i).chid).x,S(S(i).chid).y,'*k');
                hold on;
                operating_nodes= operating_nodes - 1;
             end
        end
        end
        
        
        if S(i).E<=0       % if nodes energy depletes with transmission
        dead_nodes=dead_nodes +1;
        figure(1);
        plot(S(i).x,S(i).y,'*k');
        hold on;
        operating_nodes= operating_nodes - 1;
        S(i).cond=0;
        S(i).chid=0;
        S(i).rop=rnd;
        end
        
      end
   end 
   % Energy Dissipation for cluster head nodes %
   
   for i=1:n
     if (S(i).cond==1)  && (S(i).role==1)
         if S(i).E>0
            ETx= (E_elec+EDA)*k + E_amp * k * S(i).dts^2;
            S(i).E=S(i).E - ETx;
            energy=energy+ETx;
            data=data+k;           %data to BS from all CH + their data
         end
         if  S(i).E<=0     % if cluster heads energy depletes with transmission
         dead_nodes=dead_nodes +1;
         figure(1);
         plot(S(i).x,S(i).y,'*k');
         hold on;
         operating_nodes= operating_nodes - 1;
         S(i).cond=0;
         S(i).rop=rnd;
         end
     end
   end
   
   if operating_nodes<n && temp_val==0
       temp_val=1;
       flag1stdead=rnd;         %1st node dead
   end
   CLheads;
   
   %Plotting Parameters
   transmissions=transmissions+1; %Next Transmission
   if CLheads==0              % if CH =0 no transmission, round will go as usual
   transmissions=transmissions-1;
   end
    
 
    % Next Round %
    rnd= rnd +1;
    
    tr(transmissions)=operating_nodes;
    op(rnd)=operating_nodes;
    
    %Plotting Parameters(Individual case)
    if energy>0
    nrg(rnd)=energy;    
    nrg2(transmissions)=energy;
    end
    
    if data>0
        dbs(rnd)=data;  
        dbs2(transmissions)=data;
    end
    
end


%Plotting Parameter(Sum case)
sumnrg(1,rnd)=0;
sumnrg(1)=nrg(1);
for i=2:rnd
sumnrg(i)=sumnrg(i-1)+nrg(i);
end

sumnrg2(1,transmissions)=0;
sumnrg2(1)=nrg2(1);
for i=2:transmissions
sumnrg2(i)=sumnrg2(i-1)+nrg2(i);
end

sumdbs(1,rnd)=0;
sumdbs(1)=dbs(1);
for i=2:rnd
sumdbs(i)=sumdbs(i-1)+dbs(i);
end

sumdbs2(1,transmissions)=0;
sumdbs2(1)=dbs2(1);
for i=2:transmissions
sumdbs2(i)=sumdbs2(i-1)+dbs2(i);
end


    
    % Plotting Simulation Results "Operating Nodes per Round" %
    figure(2)
    plot(1:rnd,op(1:rnd),'-r','Linewidth',2);
    title ({'LEACH'; 'Operating Nodes per Round';})
    xlabel 'Rounds';
    ylabel 'Operational Nodes';
    hold on;
    
    % Plotting Simulation Results  %
    figure(3)
    plot(1:transmissions,tr(1:transmissions),'-r','Linewidth',2);
    title ({'LEACH'; 'Operational Nodes per Transmission';})
    xlabel 'Transmission';
    ylabel 'Operational Nodes';
    hold on;
    
     % Plotting Simulation Results  %
    figure(4)
    plot(1:rnd,nrg(1:rnd),'-r','Linewidth',2);   
    title ({'LEACH'; 'Energy consumed per Round';})
    xlabel 'Round';
    ylabel 'Energy ( J )';
    hold on;
    
    figure(5)
    plot(1:transmissions,nrg2(1:transmissions),'-r','Linewidth',2);   
    title ({'LEACH'; 'Energy consumed per Transmission';})
    xlabel 'Transmission';
    ylabel 'Energy ( J )';
    hold on;
    
    figure(6)
    plot(1:rnd,dbs(1:rnd),'-r','Linewidth',2);   
    title ({'LEACH'; 'Data packets received by BS per Round';})
    xlabel 'Round';
    ylabel 'Data packets (bits)';
    hold on;
    
    figure(7)
    plot(1:transmissions,dbs2(1:transmissions),'-r','Linewidth',2);  
    title ({'LEACH'; 'Data packets received by BS per Transmission';})
    xlabel 'Transmission';
    ylabel 'Data packets (bits)';
    hold on;
    
    figure(8)
    plot(1:rnd,sumnrg(1:rnd),'-r','Linewidth',2);   
    title ({'LEACH'; 'Sum of Total Energy consumed per Rounds';})
    xlabel 'Total Rounds';
    ylabel 'Energy ( J )';
    hold on;
    
    figure(9)
    plot(1:transmissions,sumnrg2(1:transmissions),'-r','Linewidth',2);   
    title ({'LEACH'; 'Sum of Total Energy consumed per Transmissions';})
    xlabel 'Total Transmissions';
    ylabel 'Energy ( J )';
    hold on;
    
    figure(10)
    plot(1:rnd,sumdbs(1:rnd),'-r','Linewidth',2);   
    title ({'LEACH'; 'Sum of Toral Data packets received by BS per Rounds';})
    xlabel 'Total Runds';
    ylabel 'Data packets (bits)';
    hold on;
    
    figure(11)
    plot(1:transmissions,sumdbs2(1:transmissions),'-r','Linewidth',2);  
    title ({'LEACH'; 'Sum of Total Data packets received by BS per Transmissions';})
    xlabel 'Total Transmissions';
    ylabel 'Data packets (bits)';
    hold on;
    
    figure(12)
    plot(sumdbs(1:rnd),op(1:rnd),'-r','Linewidth',2);
    title ({'LEACH'; ' Number of nodes alive per amount of data sent to the BS per Round';})
    xlabel 'No. of data received to BS';
    ylabel 'Operating nodes';
    hold on;
    
    figure(13)
    plot(sumdbs2(1:transmissions),tr(1:transmissions),'-r','Linewidth',2);
    title ({'LEACH'; ' Number of nodes alive per amount of data sent to the BS per Transmissions';})
    xlabel 'No. of data received to BS';
    ylabel 'Operating nodes';
    hold on;
   
    
   
  
