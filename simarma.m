function [y] = simarma(phi1,phi2,delta1,delta2,R)
arma = arima('Constant',0,'AR',{phi1,phi2},'MA',{delta1,delta2},'Variance',1);
y = simulate(arma,R);
end