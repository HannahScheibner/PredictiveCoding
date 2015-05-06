%% find the median and quartiles

M = cat(2,file.size{:}); 

y = sort(M);

Q(1) = median(y(find(y<median(y))));

% compute 50th percentile (second quartile)
Q(2) = median(y);

% compute 75th percentile (third quartile)
Q(3) = median(y(find(y>median(y))));

