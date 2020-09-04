%%
% Problem 1
% 1a
thbusd = readtable('usdthb.xls','range','B2:B72');
thbusd = table2array(thbusd);
plot(thbusd);
xlabel('date')
ylabel('THB/USD')

%%
% 1b








summary = sumstats(thbusd)
%%
% Problem 2
% 2(a)
R=5000;
N=1000;
beta=[1;-1];
sigma=1/2;
for r=1:R
    epsilon(:,r) = sigma*randn([N,1]);
    X(:,:,r) = [ones(N,1), randn(N,1)];
    Y(:,r) = X(:,:,r)*beta+epsilon(:,r);
end

Ymeanr = mean(Y,1);
Yvarr = nanvar(Y,1);
Y25r = prctile(Y,25);
Y75r = prctile(Y,75);
%%
%2(b)
ymean = mean(Ymeanr)
yvar = mean(Yvarr)
y25 = mean(Y25r)
y75 = mean(Y75r)

%%
%2(c)
%function[SSR] = func_SSR(beta,Y, X)
%    SSR = transpose(Y-X*beta)*(Y- X*beta)
%end
%%
%2(d)

beta0 = [1,-1]

%for r=1:R
%[beta(:,r), fval(r)] = fminunc(@(beta) func_SSR(beta,Y(:,r), X(:,:,r)), beta0])
%end

for r=1:R
    [beta(:,r)] = OLS(Y(:,r), X(:,:,r))
end
%%
%2(e)
meanbeta = mean(beta,2)
%%
%3(b)
AR = AR1(0,0.8,1,250,0)
plot(AR);
%%
%3(c)
phi0 = 0; phi1 = 0.8
for t=1:20
ARth(t) = phi1^(t-1)
end

autocorr(AR)
hold on
plot(ARth)
