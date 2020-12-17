%main
clc
clear all
close all



dc = .07;
c=1.;

p1 =@(k,e) (k^4)*(c^-3)*(e^-3);
p2 =@(k,e) (k^2)*(c^-3)*(e^-4);
p3 =@(k,e) (10^7)*max(p1(k,e), p2(k,e));



M = 11;
R = 11;

cmap = jet(R);

T = [];
R1 = [];
Ex = [];
Kx = [];

for s=2:11
    figure(s-1)
    hold on
    xlabel('e')
    ylabel('k')
    title(sprintf('Rank %d',s))
    figure(s-1+10)
    hold on
    xlabel('e')
    ylabel('error')
    title(sprintf('Rank %d',s))
    
%     fprintf('rank a: %d\n',r_A)
    E = [0.001:0.001:1,1:10];
    E1 = [];
    K = [];
    E2 = [];
    C = [];
    for k=s:-1:1
%         fprintf('k: %d\n',k)
        for e=E
            if true%p3(k,e) <= r_A
                for x=1:3
                    try    
                        A = rand(s);
                        while rank(A) < s
                            A = rand(s);
                        end
                        r_A = rank(A);
                        D = SamplingAlgorithm(A,k,e);
                        r_D = rank(D);
                        if r_D > 0
    %                         disp('FOUND')
    %                         disp(e)
            %                 fprintf('rank D: %d\n',r_D)
                            E1 = [E1; e];
                            dk = -(dc*(M-k)/2) + dc*(R-(s-2));
                            K = [K; k];
                            
                            AD = A-D;
                            AD = A-D;
                            err = sqrt(sum(AD.*AD,'all'));
                            E2 = [E2; err];
                            C = [C;cmap(k,:)];
                            f =@() SamplingAlgorithm(A,k,e);
                            t1 = timeit(f);
                            T = [T; t1];
                            R1 = [R1; r_A];
                            Ex = [Ex;e];
                            Kx = [Kx;k];
        %                     disp(sum(AD.*AD,'all'))
                        end
                    end
                end
            end
        end
    end
    figure(s-1)
    scatter(E1,K,3,'r')
%     legend(string(2:11),'location','southeast')
    saveas(gca,sprintf('k_e_no_p_rank_%d_1000.png',s))
        figure(s-1+10)
    scatter(E1,E2,3,C)
    set(gca, 'YScale', 'log')
    saveas(gca,sprintf('e_v_e_rank_%d.png',s))
end

figure(1)
data = [ones(size(T)), Ex, Ex.^2, Kx, Kx.^2];

coeffs = data\T;

