function [outmean] = AR1meanU(phi_0, phi_1,L, U)
outmean = (phi_0 + 0.5*(L+U)) / (1-phi_1);
end

