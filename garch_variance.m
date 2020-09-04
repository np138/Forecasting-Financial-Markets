function [sigma2] = garch_variance(theta,data)
%theta = [omega, alpha, beta]
T = size(data,1);
sigma2 = zeros(T,1);
sigma2(1) = var(data);

    for t=2:T
        sigma2(t) = theta(1) + theta(2)*(data(t-1))^2 + theta(3)*sigma2(t-1);
    end
   
end

