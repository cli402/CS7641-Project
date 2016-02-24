function [ pwz,pdz,pz ] = mycluster2(bow, k)
[nd, nc] = size(bow);
max_iter = 100;
tol = 0.005;
%initialize the parameters  
pwz = rand(nc, k);
pdz = rand(nd, k);
pz = rand(k, 1);
%normalize it
pwz = bsxfun(@rdivide, pwz, sum(pwz));
pdz = bsxfun(@rdivide, pdz, sum(pdz));
pz = pz ./ sum(pz);
%compute the likelihood of pre
P_DW = bsxfun(@times, pdz, pz') * pwz';
Lik_hood_old = full(sum(sum(bow .* log(P_DW))));
%internmedian component for vectorized computation
prd_intern = zeros(k, nd, nc);
%iteration toward convergence
for iteration = 1:max_iter
% estep
pzdw = bsxfun(@times, pz, pdz');

pzdw = bsxfun(@times, pzdw, reshape(pwz', [k, 1, nc]));
pzdw = bsxfun(@rdivide, pzdw, reshape(sum(pzdw, 1), [1, nd, nc]));
% mstep
for z = 1:k
prd_intern(z, :, :) = bsxfun(@times,bow,squeeze(pzdw(z, :, :)));
end
pwz = squeeze(sum(prd_intern, 2))';
pwz = bsxfun(@rdivide, pwz, sum(pwz));
pdz = squeeze(sum(prd_intern, 3))';
pdz = bsxfun(@rdivide, pdz, sum(pdz));
pz = sum(sum(prd_intern, 3), 2);
pz = pz ./ sum(pz);
    
P_DW = bsxfun(@times, pdz, pz') * pwz';
likli_new = full(sum(sum(bow .* log(P_DW))));
impro_ratio = (likli_new - Lik_hood_old) / abs(Lik_hood_old);
if impro_ratio < tol
   break;
end
%just copy to new
    Lik_hood_old = likli_new;
end
end