function [Qstat, pval, corr] = LBtest(X,L)
    corr = zeros(L,3);
    T = size(X,1);
    samplecorr = autocorr(X, 'NumLags', L);

    for j = 1:L
        corr(j,1) = samplecorr(j+1);
    end

    se  = 1/sqrt(T);

    for j = 1:L
        corr(j,2) = corr(j,1)/se;
        corr(j,3) = 1.96*se;
    end
    
    lhosq = zeros(L,1);
    for j = 1:L
        lhosq(j) = (corr(j,1).^2)*(1/(T-j));
    end
    
    sumlho = sum(lhosq);
    Qstat = T*(T+2)*sumlho;
    
    pval = chi2cdf(Qstat,L);
    
end 

