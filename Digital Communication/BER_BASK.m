Sig_length = 200000;
Eb = 1;
%SNR for theoretical calculations
SNR_dB = linspace(0,20,100);
SNR = 10.^(SNR_dB/10);
%SNR for simulation 
SNR_dB_sim = linspace(0,20,5); % ( for five data points)
SNR_sim = 10.^(SNR_dB_sim/10);
No = Eb./SNR_sim;
%Theoretical BER calculations
BER_BASK_te = (1/2)*erfc(sqrt(SNR/4));
for i = 1:length(SNR_sim) 
 E_BASK = 0;
 bit = randi([0 1],1,Sig_length);
 x_BASK = bit;
 N_real = sqrt(No(i)/2)*randn(1,Sig_length);
 N_img = sqrt(No(i)/2)*randn(1,Sig_length);
 N = N_real + 1j*(N_img);
 Y_BASK = x_BASK + N;
 
 for i2 = 1:Sig_length
 %BASK detector
 Z_BASK(i2) = (Y_BASK(i2));
 % Logic for decision of BASK error
 if (Z_BASK(i2) > 0.5 && bit(i2) == 0) || (Z_BASK(i2) < 0.5 && bit(i2) == 1);
 E_BASK = E_BASK + 1;
 end
 end
% calculation for Simulated BER
 BER_BASK_sim(i) = E_BASK/Sig_length;
 end
 
%Plotting the graph
semilogy(SNR_dB,BER_BASK_te,'k','color','red');
hold on
semilogy(SNR_dB_sim,BER_BASK_sim,'k*','color','blue');
legend('BASK theori','BASK simulatoni','location','best');
axis([min(SNR_dB) max(SNR_dB) 10^(-6) 1]);
xlabel('SNR(dB)');
ylabel('BER');
title('BER Vs SNR for BASK');
grid on;
hold off
%Constellation Diagram of the BASK
scatterplot(Y_BASK); 
grid minor;
title('Constellation Diagram of BASK')
