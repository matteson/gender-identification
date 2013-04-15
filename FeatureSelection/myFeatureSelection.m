rng('default')
%%
p = path;
path(p,'../Functions/')

%%

M_arabic1 = csvread('../Data/arabic_same_text.csv',1,1);
M_arabic2 = csvread('../Data/arabic_diff_text.csv',1,1);
M_english1 = csvread('../Data/english_same_text.csv',1,1);
M_english2 = csvread('../Data/english_diff_text.csv',1,1);

M_arabic1_test = csvread('../Data/test_arabic_same_text.csv',1,1);
M_arabic2_test = csvread('../Data/test_arabic_diff_text.csv',1,1);
M_english1_test = csvread('../Data/test_english_same_text.csv',1,1);
M_english2_test = csvread('../Data/test_english_diff_text.csv',1,1);

ismale = csvread('../Data/train_answers.csv',1,1);
ismale = [ismale; ismale];

M_arabic  = [M_arabic1; M_arabic2];
M_english = [M_english1; M_english2];
M_arabic_test  = [M_arabic1_test; M_arabic2_test];
M_english_test = [M_english1_test; M_english2_test];
%% remove 0 variance
% aelim = var(M_arabic)==0;
% eelim = var(M_english)==0;
% M_arabic(:,aelim) = [];
% M_english(:,eelim) = [];
% M_arabic_test(:,aelim) = [];
% M_english_test(:,eelim) = [];

figure(); hist(log10(var(M_english)),20)

[aSize1 aSize2] = size(M_arabic);
[eSize1 eSize2] = size(M_english);
[aSize1_test aSize2_test] = size(M_arabic_test);
[eSize1_test eSize2_test] = size(M_english_test);


%%
bins = 6;
makeplot = true;

[inds_arabic w_real_arabic w_rand_arabic] ...
    = mutual_info_selection(M_arabic ,ismale,bins,makeplot);
[inds_english w_real_english w_rand_english] ...
    = mutual_info_selection(M_english,ismale,bins,makeplot);

%%
numOutArabic  =  sum((w_real_arabic>prctile(w_rand_arabic,99.9)))
numOutEnglish =  sum((w_real_english>prctile(w_rand_english,99.9)))
%%
csvwrite('arabicMutualInfoFeaturesTrain.csv' ,M_arabic(:     ,inds_arabic(end:-1:(end-numOutArabic))))
csvwrite('arabicMutualInfoFeaturesTest.csv'  ,M_arabic_test(:,inds_arabic(end:-1:(end-numOutArabic))))
csvwrite('englishMutualInfoFeaturesTrain.csv',M_english(:     ,inds_english(end:-1:(end-numOutEnglish))))
csvwrite('englishMutualInfoFeaturesTest.csv' ,M_english_test(:,inds_english(end:-1:(end-numOutEnglish))))

