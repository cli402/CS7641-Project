function prob = algorithm(q)
load sp500;
% plot and return the probability
% alpha pass
% forward algorithm
num = size(price_move,1);
%initialize
alpha = zeros(num, 2);
alpha(1,1) = (1-q) * 0.2;
alpha(1,2) = q * 0.8;
a = [0.8 0.2];
% iteration
for i=2:num,
    if price_move(i,1) == 1
        alpha(i,1) = (q) * ( alpha(i-1,1) * a(1,1) + alpha(i-1,2)* a(1,2) );
        alpha(i,2) = (1 - q) * ( alpha(i-1,1) * a(1,2) + alpha(i-1,2) * a(1,1) );
    end
    if price_move(i,1) == -1
        alpha(i,1) = (1-q) * ( alpha(i-1,1) * a(1,1) + alpha(i-1,2) * a(1,2) );
        alpha(i,2) = (q) * ( alpha(i-1,1) * a(1,2) + alpha(i-1,2) * a(1,1) );
    end
end
% termination
P_x = alpha(39,1) + alpha(39,2);
% beta pass
beta = zeros(num, 2);
% initialization 
beta(39,1) = 1;
beta(39,2) = 1;
% iteration
for i=38:-1:1,
    if price_move(i+1,1) == 1
        beta(i, 1) = ( a(1,1) * q * beta(i+1,1)) + (a(1,2) * (1-q) * beta(i+1,2));
        beta(i, 2) = ( a(1,2) * q * beta(i+1,1) + (1-q) * a(1,1) * beta(i+1,2) );
    end
    if price_move(i+1,1) == -1
        beta(i,1) = ( a(1,1) * (1-q) * beta(i+1,1) + a(1,2) * q * beta(i+1,2) );
        beta(i,2) = ( a(1,2) * (1- q) * beta(i+1,1) + (q) * a(1,1)*beta(i+1,2) );
    end
end
% termination
prob = alpha(39,1) * beta (39,1) / P_x;
probab = zeros(num,1);
for i=1:num,
    probab(i) = alpha(i,1) * beta(i,1) / P_x;
end

% plot(alpha(:,1).*beta(:,1) / P_x)
% plot(probab,'-*','color', rand(1,3) );
% title('Probability of the good economy state')
% xlabel('weeks'); % x-axis label
% ylabel('Probability'); % y-axis label
% legend( 'q=0.9');
% hold on
end
