function[rho] = autocorrthoery( phi0, phi1, sig2eps, T)
for t=1:T
    rho(t)= (phi1^(t))*(sig2eps/(1-phi1^2))
end
end


