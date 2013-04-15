function [inds w_real w_rand] = mutual_info_selection(M,ismale,bins,makeplot)

[numRows, numFeatures] = size(M);

F1 = ceil(bins * tiedrank(M) / numRows);

w_real=zeros(1,numFeatures);
w_rand=zeros(1,numFeatures);
for i = 1:numFeatures
    w_real(i) = nmi(ismale               ,F1(:,i));
    w_rand(i) = nmi(ismale(randperm(length(ismale))),F1(:,i));
end

if makeplot
    
    figure(); hold on
    [vals_rand bins_rand] = hist(w_rand);
    [vals_real bins_real] = hist(w_real);
    
    plot(bins_rand,vals_rand,'r');
    plot(bins_real,vals_real,'b');
    set(gca','YScale','log')
    mnb_prettyfig
    
end

[vals inds] = sort(w_real);