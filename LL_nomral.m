function [negative_loglikelihood] = LL_nomral(theta,X)
T = length(X);
sum = 0; 
for t = 1:T 
    sum = sum + log(1/(sqrt(theta(2)*2*pi))*exp(-(X(t)-theta(1))^2/(2*theta(2))));
end
negative_loglikelihood = -sum;
end

