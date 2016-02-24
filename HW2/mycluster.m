function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!
[nd,nw] = size(bow);
pi_c=rand(1,K);
%normalize it
pi_c=pi_c./sum(pi_c);
mu=rand(nw,K);
%normalize it
mu=mu./repmat(sum(mu),[nw,1]);
r=zeros(nd,K);

p_d=zeros(nd,1);
for iteration=1:100
%expectation:
for i = 1:nd
    for c = 1:K
        r(i,c)=pi_c(c)*prod(power(mu(:,c),bow(i,:)'));
    end
end
% pd_new=sum(r,2);
% if log(prod(pd_new)) - log(prod(p_d)) < 0.01
%     break
% end
% p_d=pd_new;
p_d=sum(r,2);
r=r./repmat(p_d,[1,K]);
%maximization
for j=1:nw
    for c =1:K
        mu(j,c)=r(:,c)'*bow(:,j);
    end
end
x=zeros(1,K);
for i=1:K
    x(i)=sum(sum(bsxfun(@times,r(:,i),bow)));
end
mu=mu./repmat(x,[nw,1]);
pi_c=sum(r)/nd;
end
%get the results

[~,class]=max(r,[],2);
%fprintf('iteration at %f',log(prod(p_d)));
%fprintf('iteration at %d',iteration) ;
end
