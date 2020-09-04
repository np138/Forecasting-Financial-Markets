clear 
close all

%% Problem 3 (a, iii)
omega=0:0.01:pi
spec1 = paraspec(-0.9,omega)/2/pi
spec2 = paraspec(-0.5,omega)/2/pi
spec3 = paraspec(0.0,omega)/2/pi
spec4 = paraspec(0.5,omega)/2/pi
spec5 = paraspec(0.9,omega)/2/pi

figure 
p1 = plot(omega,spec1); l1 = "phi=-0.9"
hold on
p2 = plot(omega,spec2); l2 = "phi=-0.5"
hold on
p3 = plot(omega,spec3); l3 = "phi=0"
hold on
p4 = plot(omega,spec4); l4 = "phi=0.5"
hold on
p5 = plot(omega,spec5); l5 = "phi=0.9"
legend([p1,p2,p3,p4,p5], [l1, l2,l3,l4,l5])
hold off

%% Problem 3 (b)
model1 = arima('Constant',0,'AR',{0.4,-0.8},'MA',{-0.1},'Variance',1)

autocov=xcov(Y,'biased');  %generate autocorr for ARMA
start=(length(autocov)+1)/2; %start = 4000/2 = 2000
lengthspan=length(autocov)-start; %legthspan = 3999-2000=1999
SPEC=[]; %blank vector

for omega=0:0.01:pi  % omega [0,pi] inc by 0.01
temp1=cos(omega*[1:lengthspan]); % temp = cos(omega*[1:1999])
temp2=autocov(start+1:end); %temp2 = autocov(2001:3999)
SPEC=[SPEC;(sum(temp1'.*temp2)*2+autocov(start))]; %SPEC = [vector, ...]
end


%% Problem 3 (c ,i)
sample = table2array(readtable('Sample Data.xlsx','Range','B2:B401'))
[samcor,lags1,boundauto] = autocorr(sample)
[sampcor,lags2,boundpauto] = parcorr(sample)
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
bar([0:20],samcor(1:21));
hold on
plot(upper1);
hold on
plot(lower1);
hold off
title('ACF');
xlabel('Lags');
ylabel('Sample Autocorrelation')

% Assume ARMA(1,1) for now

p6 = plot(samcor(1:20)); l6 = "ACF"
hold on
p7 = plot(sampcor(1:20)); l7 = "PACF"
legend([p6,p7], [l6,l7])
hold off 

%% Problem 3 (c ,ii)
autocov=xcov(sample,'biased');  %generate autocorr for ARMA
start=(length(autocov)+1)/2; %start = 4000/2 = 2000
lengthspan=length(autocov)-start; %legthspan = 3999-2000=1999
SPEC2=[]; %blank vector
for omega=0:0.01:pi  % omega [0,pi] inc by 0.01
temp1=cos(omega*[1:lengthspan]); % temp = cos(omega*[1:1999])
temp2=autocov(start+1:end); %temp2 = autocov(2001:3999)
SPEC2=[SPEC2;(sum(temp1'.*temp2)*2+autocov(start))]; %SPEC = [vector, ...]
end

%estimate ARMA(p,q)
%ARMA(1,1) for now....


% Kernel smoothing
k= [1/16, 1/8, 3/16, 1/4, 3/16, 1/8, 1/16];
SPEC_W = zeros(size(SPEC2,1),1);
SPEC_W(1:3)=SPEC2(1:3); %USE DEFAULT 1-3
SPEC_W(end-2:end)=SPEC2(end-2:end); %FIX ENDING
for t=4:length(SPEC_W)-3
SPEC_W(t) = k*SPEC(t-3:t+3);
end
figure
plot(0:0.01:pi,SPEC_W/2/pi)

