clear all
close all
clc

MIN_RANK = 2;
MAX_RANK = 12;

c=1;

p1 =@(k,e) (k^4)*(c^-3)*(e^-3);
p2 =@(k,e) (k^2)*(c^-3)*(e^-4);
p3 =@(k,e) (10^7)*max(p1(k,e), p2(k,e));

cmap = hsv(MAX_RANK-MIN_RANK+1); 


for mat_rank=MIN_RANK:MAX_RANK
    min_k = inf;
    max_k = -inf;
    min_e = inf;
    max_e = -inf;
    
    E = [];
    K = [];
    C = [];
    e1 = [0.0001:0.0001:1,1:10000];
    for k=1:mat_rank
        for e=e1
            p = p3(k,e);
            if p <= mat_rank && k <= p
%                 disp('HERE2')
                if min_k > k
                    min_k = k;
                end
                if max_k < k
                    max_k = k;
                end
                if min_e > e
                    min_e = e;
                end
                if max_e < e
                    max_e = e;
                end
                E = [E;e];
                K = [K;k];
                C = [C;cmap(mat_rank-1,:)];
            end
        end
    end
    figure()
    scatter(E,K,2,'r');
    xlabel('e')
    ylabel('k')
    title(sprintf('Rank %d',mat_rank))
%     disp('HERE3')
    fprintf('Rank %d, E: {%d,%d}, K: {%d,%d}\n',mat_rank,min_e,max_e,min_k,max_k)
    saveas(gca,sprintf('k_e_p_rank_%d.png',mat_rank))
end
