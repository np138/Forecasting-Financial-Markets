function[beta] = OLS(Y,X)
beta = inv(transpose(X)*X)*(transpose(X)*Y);
end
