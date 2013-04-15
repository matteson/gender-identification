function out = logloss(y,y_hat)

n = length(y);

y_hat(y_hat<1e-12) = 1e-12;
y_hat(y_hat>(1-1e-12)) = 1 - 1e-12;

out = -1/n * sum(y.*log(y_hat) + (1-y).*log(1-y_hat));