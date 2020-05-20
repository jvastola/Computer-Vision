function [mu, U] = eigenface(X, k)


    %% compute mean face
    mu = mean(X, 2);

    %% substract mean from X
    X = bsxfun(@minus, X, mu);

    %% compute covariance matrix
    C = X * X';

    %% singular value decomposition
    [U, S, D] = svd(C);

    %% select the first k column from U
    U = U(:, 1:k);

end