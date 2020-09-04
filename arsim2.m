function [Y] = arsim(T, sig2_eps, phi_0, phi_1)
    Y = zeros(T, 1)
    eps = normrnd(0, sqrt(sig2_eps), T, 1);
    Y(1) = eps(1);

    for t = 1:T-1
        Y(t+1) = phi_0 + phi_1*Y(t) + eps(t);
    end

end