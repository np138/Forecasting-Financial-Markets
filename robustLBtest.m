function [chi2stat, pval, ci] = robustLBtest(X,L)

T = size(X,1);
lagged_data = mlag(X,L,mean(X));

nwresult = nwest(X(L+1:end),[ones(T-L,1),lagged_data(L+1:end,:)],L+3);
chi2stat = nwresult.beta(2:end)'*(nwresult.vcv(2:end,2:end)\nwresult.beta(2:end));

pval = chi2cdf(chi2stat,L);

ci = 1.96*(diag(nwresult.vcv).^0.5);
end

  