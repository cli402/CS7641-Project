function [ U, V ] = myRecommender( rateMatrix, lowRank)
    % Please type your name here:
    name = 'Chengwei, Li';
    disp(name); % Do not delete this line.
    % Parameters
    maxIter = 200; % Choose your own.
    [n1, n2] = size(rateMatrix);
%     U1=zeros(n1,lowRank);
%     V1=zeros(n2,lowRank);
%     L1=0;
%     R1=0;
%     error=1000;
    learningRate =0.0005; % Choose your own.
    regularizer = 0.1; % Choose your own.
    
    % Random initialization:
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;
    % Gradient Descent
    % IMPLEMENT YOUR CODE HERE.
    for steps=1:maxIter
        % Iterate update and U & V
        E_uv=rateMatrix-U*V'.*(rateMatrix>0);
        temp_U=U;
        temp_V=V;
        %update
        U=(1-2*learningRate*regularizer)*temp_U+2*learningRate*E_uv*temp_V;
        V=(1-2*learningRate*regularizer)*temp_V+2*learningRate*E_uv'*temp_U;
        % Check for reconstruction error
        e = norm((U*V' - rateMatrix) .* (rateMatrix > 0), 'fro') / sqrt(nnz(rateMatrix > 0));
        if e < 0.5
        %fprintf('the error decresed to %f \n,',e);
%         error=e;
%         U1=U;
%         V1=V;
%         L1=learningRate;
%         R1=regularizer;
        break;
        end
    end
    %fprintf('the learning rate is %.6f,regularizer is %%.6f',L1,R1);
end
