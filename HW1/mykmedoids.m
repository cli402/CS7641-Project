function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
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

	%[class, centroid] = kmeans(pixels, K);
    M=size(pixels,1);
    class=zeros(K,1);
    centroid=pixels(randsample(M,K),:);
    %centroid=pixels(1:K,:);
    
    iterno=100;
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
    %choose the nearest node to be the centroid
    for i = 1:K
        centroid_new=centroid(i,:);
        sum_distance=sum(bsxfun(@minus,centroid_new,pixels).^2,2);
        [~,index]=min(sum_distance);
        centroid(i,:)=pixels(index,:);
    end
    tf=isequal(class,class1);
        if tf == 0
          class=class1;
        else
            fprintf('--iteration end at %d\n', iter); 
            break     
        end
    end
end
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%using the Mahattan Distance as the metrix
%%%%%%%%%%%%%%%%%
%    M=size(pixels,1);
%     class=zeros(K,1);
%     initialize the centroid
%     centroid=pixels(randsample(M,K),:);
%     manhattan_dis_vector=sum(pixels,2);
%     iterno = 100; 
%     for iter = 1:iterno
%         c2=sum(centroid,2);
%         c2=c2';
%         tmpdiff=abs(bsxfun(@minus,c2,manhattan_dis_vector));
%         [~,class1] = min(tmpdiff,[],2);       
%         P=sparse(1:M,class1',1,M,K,M);
%     %recalculate the centroid
%     count=sum(P,1);
%     centroid=bsxfun(@rdivide,P'*pixels,count');
%      %choose the nearest node to be the centroid
%     for i = 1:K
%         centroid_new=centroid(i,:);
%         sum_distance=sum(bsxfun(@minus,centroid_new,pixels).^2,2);
%         [~,index]=min(sum_distance);
%         centroid(i,:)=pixels(index,:);
%     end
%     %decide to break the iteration
%     tf=isequal(class,class1);
%         if tf == 0
%           class=class1;
%         else
%             fprintf('--iteration end at %d\n', iter); 
%             break     
%         end
%     end

%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%using the Standardized Euclidean distance as the metric
%%%%%%%%%%%%%%%%%
%     M=size(pixels,1);
%     class=zeros(K,1);
%     %initialize the centroid
%     centroid=pixels(randsample(M,K),:);
%     StandEu_dis_vector=zeros(M,K);
%     iterno = 100; 
%     for iter = 1:iterno
%         for i =1:K
%             StandEu_dis_vector(:,i)=sqrt(sum(bsxfun(@minus,centroid(i,:),pixels).^2,2));
%         end
%         [~,class1] = min(StandEu_dis_vector,[],2);       
%         P=sparse(1:M,class1',1,M,K,M);
%     %recalculate the centroid
%     count=sum(P,1);
%     centroid=bsxfun(@rdivide,P'*pixels,count');
%      %choose the nearest node to be the centroid
%     for i = 1:K
%         centroid_new=centroid(i,:);
%         sum_distance=sum(bsxfun(@minus,centroid_new,pixels).^2,2);
%         [~,index]=min(sum_distance);
%         centroid(i,:)=pixels(index,:);
%     end
%     %decide to break the iteration
%     tf=isequal(class,class1);
%         if tf == 0
%           class=class1;
%         else
%             fprintf('--iteration end at %d\n', iter); 
%             break     
%         end
%     end
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%using the chebyshve distance as the metric 
%%%%%%%%%%%%%%%%%%%%
%     M=size(pixels,1);
%     class=zeros(K,1);
%     %initialize the centroid
%     centroid=pixels(randsample(M,K),:);
%     StandEu_dis_vector=zeros(M,K);
%     iterno = 100; 
%     for iter = 1:iterno
%         for i =1:K
%             StandEu_dis_vector(:,i)=max(bsxfun(@minus,centroid(i,:),pixels),[],2);
%         end
%         [~,class1] = min(StandEu_dis_vector,[],2);       
%         P=sparse(1:M,class1',1,M,K,M);
%     %recalculate the centroid
%     count=sum(P,1);
%     centroid=bsxfun(@rdivide,P'*pixels,count');
%      %choose the nearest node to be the centroid
%     for i = 1:K
%         centroid_new=centroid(i,:);
%         sum_distance=sum(bsxfun(@minus,centroid_new,pixels).^2,2);
%         [~,index]=min(sum_distance);
%         centroid(i,:)=pixels(index,:);
%     end
%     %decide to break the iteration
%     tf=isequal(class,class1);
%         if tf == 0
%           class=class1;
%         else
%             fprintf('--iteration end at %d\n', iter); 
%             break     
%         end
%     end
