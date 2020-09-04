function[y] = AR1( phi0, phi1, sig2eps, T, y0)
epsilon = normrnd(0, sig2eps,1, T);
y(1) = y0
for t=2:T
    y(t)=phi0+phi1*y(t-1)+epsilon(t);
end
end


