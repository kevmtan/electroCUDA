function [sph,Rotation_matrix] =sphx(X,T)
    % CODE TO WHITENING OR SPHERING DATA
    % USAGE:
    %        data_sphered=sphx(data,T);
    %        data=Samples in rows; Features in Columns
    %        T=='PCA' or 'SVD'
    %
    % TESTING THE RESULTS
    % mean(data_sphered)    %ZERO MEAN
    % std(data_sphered)    %STANDARD DEVIATION = 1
    % cov(data_sphered)     %COVARIANCE MATRIX = I
    %
    %
    % This code is implemented by Fernando González
    % ANY IMPROVEMNT, ERROR, CORRECTION..? PLEASE, LET ME KNOW to:ffgn2001@yahoo.com
    
    Xu=bsxfun(@minus,X,mean(X));           %REMOVE MEAN
    Cov_matrix=cov(Xu);                   %COMPUTE COVARIANCE
    switch T
        case 'PCA' 
            [V,S]=eig(Cov_matrix);        %EIGENVALUE PROBLEM
        case 'SVD'
            [~,S,V]=svd(Cov_matrix);      %SINGULAR VALUE DECOMPOSITION
    end
    sqrt_inv_S=sqrt(inv(S));              %S^1/2
    Rotation_matrix = V*sqrt_inv_S;       %COMPUTE ROTATION MATRIX
    sph  = Xu*Rotation_matrix;            %SPHERED DATA
end 
