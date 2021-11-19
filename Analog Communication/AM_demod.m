 Ac = 1;  % Carrier Amplitude
 Am = 0.5;  % Message Amplitude
 fc = 1; % carrrier frequency
 fm = 0.1; % message frequency
 m  = Am/Ac;  %Ac>Am
 ka=1;  
 fs= 50;
 RC = 2;
 t = (0:0.1:100);
 
 carrier = Ac*cos(2*pi*fc*t);           %carrier signal
 
 subplot(3,1,1);
 msg=Am*cos(2*pi*fm*t);
 plot(t,msg);
 title('message signal');            %message signal

AM =(1+ ka .* msg ) .* carrier ;
 subplot (3 ,1 ,2) ;
 plot (t , AM ) ;
 xlabel ( " TIME " ) ;            
 ylabel ( "AMPLITUDE " )
 title ( " Amplitude  Modulated  Signal " )    %AM Signal
 
 subplot(3,1,3)
 Rn(1) = 0;
 for i= 2:length(AM)
     if AM(i) < Rn(i-1)
         Rn(i) = exp(-1/(fs*RC))*Rn(i-1);        %discharging
     else  
         Rn(i) = AM(i);                          %charging
         
     end
 end
 plot(t,Rn);
 title('Envelope Detector Demodualted Signal');
