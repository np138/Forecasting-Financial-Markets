clear 
close all

%% simulation
model = arima('Constant',0,'AR',{0.9},'Variance',.01);
rng(1000)
Y = simulate(model,2000);

%% nonparametric
autocov=xcov(Y,'biased');  %generate autocorr for ARMA
start=(length(autocov)+1)/2; %start = 4000/2 = 2000
lengthspan=length(autocov)-start; %legthspan = 3999-2000=1999
SPEC=[]; %blank vector
for omega=0:0.01:pi  % omega [0,pi] inc by 0.01
temp1=cos(omega*[1:lengthspan]); % temp = cos(omega*[1:1999])
temp2=autocov(start+1:end); %temp2 = autocov(2001:3999)
SPEC=[SPEC;(sum(temp1'.*temp2)*2+autocov(start))]; %SPEC = [vector, ...]
end

figure
plot(0:0.01:pi,SPEC/2/pi)

% Kernel smoothing
k= [1/16, 1/8, 3/16, 1/4, 3/16, 1/8, 1/16];
SPEC_W = zeros(size(SPEC,1),1);
SPEC_W(1:3)=SPEC(1:3); %USE DEFAULT 1-3
SPEC_W(end-2:end)=SPEC(end-2:end); %FIX ENDING
for t=4:length(SPEC_W)-3
SPEC_W(t) = k*SPEC(t-3:t+3);
end
figure
plot(0:0.01:pi,SPEC_W/2/pi)

%% parametric


[auto,lags1,boundauto]= autocorr(Y, 48); %ACF,lag no., 95pct. conf.
[auto,lags1,boundauto] = parcorr(Y,  48);
upper1=zeros(49,1);
lower1=zeros(49,1);
upper2=zeros(49,1);
lower2=zeros(49,1);
for i=1:49
upper1(i)=boundauto(1); %create boundary line
lower1(i)=boundauto(2);
upper2(i)=boundpauto(1);
lower2(i)=boundpauto(2);
end
figure
bar([0:48],auto);
hold on
plot(upper1);
hold on
plot(lower1);
hold off
title('ACF');
xlabel('Lags');
ylabel('Sample Autocorrelation')

figure
bar([0:48],pauto);
hold on;
plot(upper2);
hold on
plot(lower2);
hold off
title('PACF');
xlabel('Lags');
ylabel('Sample Partial Autocorrelation');



model1 = arima('ARLags',1);
EstModel1 = estimate(model1,Y);


omega=0:0.01:pi;

paraspec=1./((1-0.89655*exp(-1i*omega)).*(1-0.89655*exp(1i*omega)));

figure
plot(omega,paraspec*0.010139/2/pi)



