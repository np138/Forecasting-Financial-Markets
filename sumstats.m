function[stats]=sumstats(y)
meany = mean(y);
mediany = median(y);
maxy = max(y);
miny = min(y);
sdy = std(y);
k = kurtosis(y);
[jbstat,p] = jbtest(y);
label = ["mean" "median" "maximum" 'minimum' "standard deviation" "kurtosis" "Jarque-Bera Statistics" "Jarque-Bera P-Value"];
value = [meany mediany maxy miny sdy k, jbstat,p];
stats = vertcat(label,value);
end


