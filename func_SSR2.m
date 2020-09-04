function[SSR] = func_SSR2(beta,Y, X)
    SSR = sum((Y-X*beta).^2)
end

