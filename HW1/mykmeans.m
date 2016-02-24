function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

%	[class, centroid] = kmeans(pixels, K);
    M=size(pixels,1);
    class=zeros(K,1);
    %initialize the centroid
    centroid=pixels(randsample(M,K),:);
    %centroid=pixels(1:K,:);
    iterno = 100; 
    for iter = 1:iterno
        c2=sum(centroid.^2,2);
        c2=c2';
        tmpdiff=bsxfun(@minus,2*pixels*centroid',c2);
        [~,class1] = max(tmpdiff,[],2);       
        P=sparse(1:M,class1',1,M,K,M);
    %recalculate the centroid
    count=sum(P,1);
    centroid=bsxfun(@rdivide,P'*pixels,count');
    %decide to break the iteration
    tf=isequal(class,class1);
        if tf == 0
          class=class1;
        else
            fprintf('--iteration end at %d\n', iter); 
            break     
        end
    end

