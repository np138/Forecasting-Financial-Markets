function[SSR] = func_SSR(beta,Y, X)
    SSR = transpose(Y-X*beta)*(Y- X*beta)
end

