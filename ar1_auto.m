function [value] = ar1_auto(L, sig2_eps, phi_1)

lags = [1:L];
value = zeros(L,1);

    for l = 1:L
      value(l) = (phi_1^lags(l))*(sig2_eps)/(1-phi_1^2);
    end
    
end

