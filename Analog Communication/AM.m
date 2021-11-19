function[] = jan_22(fc,fm,ka) 
                           %frequency of Message
                          %frequency of Carrier
 fs = 10*(fc+fm);           %frequency of Signal
 t =0:1/ fs :3;
 am = input ( "Enter the message signal amplitude = " ) ;
 ac = input (  " Enter the carrier signal  amplitude ( ac>am )= " ) ;
 
 msg = am*cos (2*pi*fm*t);

 figure (1) ;
 subplot (3,1,1) ;
 plot (t , msg ) ;
 xlabel ( " TIME " ) ;
 ylabel ( " AMPLITUDE " )
 title ( " Message  Signal " ) ;  %Message Signal

 carrier = ac * cos (2*pi*fc*t ) ;
 subplot (3 ,1 ,2) ;
 plot (t , carrier ) ;
 xlabel ( " TIME " ) ;
 ylabel ( " AMPLITUDE " )
 title ( " Carrier Signal " ) ;   %Carrier Signal
                                              %modulating index             

 am_mod =(1+ ka .* msg ) .* carrier ;
 subplot (3 ,1 ,3) ;
 plot (t , am_mod ) ;
 xlabel ( " TIME " ) ;            
 ylabel ( "AMPLITUDE " )
 title ( " Amplitude  Modulated  Signal " ) %AM Signal
 
 
