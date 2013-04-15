rng('default')
%%
p = path;
path(p,'Functions/')

%%
temp = csvread('find_the_magic.csv',1,1);

%% sort of aggressive
f = @(x) logloss(temp(:,1),1./(1+exp(-x(1)*(temp(:,2)-x(2)))));
res1 = fminunc(f,[1,1])

%%

figure(); hold on
scatter(temp(:,2),temp(:,1))

lin = linspace(min(temp(:,2)),max(temp(:,2)),100);
plot(lin,1./(1+exp(-res1(1)*(lin-res1(2)))),'-k')

mnb_prettyfig