function[Y] = MA1( phi0, phi1, sig2eps, T)
epsilon = normrnd(0, sig2eps,1, T);
S=[phi0];
for t=2:T
    y=phi0+epsilon(t)+phi1*epsilon(t-1);
    S=[S;y];
end
Y=S
plot(S)
end

