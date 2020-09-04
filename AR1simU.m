function [Y] = AR1simU(theta)
    Y = zeros(theta(5), 1);
    eps = theta(3)+ (theta(4)-theta(3)).*rand(theta(5),1);
    Y(1) = 0;
    for t = 1:(theta(5)-1)
        Y(t+1) = theta(1) + theta(2)*Y(t) + eps(t);
    end

end