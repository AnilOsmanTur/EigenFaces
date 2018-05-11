close all
clear all
clc
% loading dataset
load('dataset/Yale_32x32') % this will load fea and gnd matrises
subsets = [2,3,4,5,6,7,8];
reduc = [27,43,59,70,80,90,95];

%% Scale the features (pixel values) to [0,1]
%===========================================
maxValue = max(max(fea));
fea = fea/maxValue;
%===========================================

%show example imagecle
vector_show (fea(1,:), 1)

% load subset
n_subset = size(subsets)(2);
n_split = 50;
results_nc = zeros(n_subset,n_split);
results_nn = zeros(n_subset,n_split);
for subset_no = 1:n_subset
    for split = 1:n_split
        fileName = strcat('dataset/', int2str(subsets(subset_no)), 'Train/', int2str(split));
        load(fileName)

        fea_Train = fea(trainIdx,:);
        fea_Test = fea(testIdx,:);
        gnd_Train = gnd(trainIdx);
        gnd_Test = gnd(testIdx);

        vector_show (fea_Train(1,:), 2)
        % pca 
        [v, lamda, cov_mat, mu] = apply_pca(fea_Train);
        lamdas = abs(sum(lamda, 2));
        [sorted, indx] = sort(lamdas, 'descend');

        % pca dimension reduction
        ids = indx(1:reduc(subset_no));
        eig_vals = lamdas(ids);
        eigeanface_vecs = v(:, ids);

        printf('total varince explained: %f%%\n', sum(eig_vals) / sum(lamdas) *100);

        vec1 = cov_mat * eigeanface_vecs;
        vec1 = sum(vec1, 2);
        vector_show (vec1, 3)

        fea_Train = fea_Train * eigeanface_vecs;
        fea_Test = fea_Test * eigeanface_vecs;

        [sel_classes_nc, dis_nc, scores_nc, n_class] = nearest_centeroid(fea_Train, gnd_Train, fea_Test, gnd_Test);
        [sel_classes_nn, certainty_nn, scores_nn] = nearest_neihbour(1, n_class, fea_Train, gnd_Train, fea_Test, gnd_Test);

        n_sample = size(fea_Test)(1);
        results_nc(subset_no,split) = (n_sample - sum(scores_nc)) / n_sample * 100;
        results_nn(subset_no,split) = (n_sample - sum(scores_nn)) / n_sample * 100;
    end
end

csvwrite('results_nc.csv', results_nc);
csvwrite('results_nn.csv', results_nn);

 