%% Problem 4 (a)
houston = table2array(readtable('HOUSTNSA.xls','Range','D13:D287'))
houston12 = zeros(12,1)
houston12 = [houston12; houston(1:262)]
[houcor,hlags1,hboundauto] = autocorr(houston)
[houpcor,hlags2,hboundpauto] = parcorr(houston)

bar([0:20],houcor(1:21))
bar([0:20],houpcor(1:21))

%% Problem 4 (b)
houyoy = houston - houston12
[yoyhoucor,hyoylags1,hyoyboundauto] = autocorr(houyoy)
[yoyhoupcor,hyoylags2,hyoyboundpauto] = parcorr(houyoy)
bar([0:20],yoyhoucor(1:21))
bar([0:20],yoyhoupcor(1:21))

houmodel = arima('Constant',0,'ARLags',1,'SARLags',12,...
            'Seasonality',12,'MALags',1,'SMALags',12)
        
esthou = estimate(houmodel,houston)

%% Problem 4 (c)
autocov=xcov(houston,'biased');  %generate autocorr for ARMA
start=(length(autocov)+1)/2; %start = 4000/2 = 2000
lengthspan=length(autocov)-start; %legthspan = 3999-2000=1999
SPECh=[]; %blank vector
for omega=0:0.01:pi  % omega [0,pi] inc by 0.01
temp1=cos(omega*[1:lengthspan]); % temp = cos(omega*[1:1999])
temp2=autocov(start+1:end); %temp2 = autocov(2001:3999)
SPECh=[SPECh;(sum(temp1'.*temp2)*2+autocov(start))]; %SPEC = [vector, ...]
end

%% Problem 4 (d)
% Kernel smoothing
k= [1/16, 1/8, 3/16, 1/4, 3/16, 1/8, 1/16];
SPEC_W = zeros(size(SPECh,1),1);
SPEC_W(1:3)=SPECh(1:3); %USE DEFAULT 1-3
SPEC_W(end-2:end)=SPECh(end-2:end); %FIX ENDING
for t=4:length(SPEC_W)-3
SPEC_W(t) = k*SPECh(t-3:t+3);
end
figure
plot(0:0.01:pi,SPEC_W/2/pi)

%% Problem 4 (e)
omega=0:0.01:pi;

paraspec=1./((1-0.89655*exp(-1i*omega)).*(1-0.89655*exp(1i*omega)));

figure
plot(omega,paraspec*0.010139/2/pi)
