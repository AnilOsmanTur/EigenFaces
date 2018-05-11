function [v, lamda, cov_mat, mu] = apply_pca (mat)
    % finding covariance matrix
    mu = mean(mat);
    n_sample = size(mat)(1);
    a = mat - mu;
    cov_mat = (a' * a) /n_sample;

    % finding the eigenvalues
    [v,lamda] = eig(cov_mat);    
    
    end