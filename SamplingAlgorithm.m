function [approxA] = SamplingAlgorithm(A,k,e)

c = 1.;

p = int16(k/(c*e));
p = min(size(A,1));
fprintf('P = %d\n',p)
S = MatrixSample(A,p,c,'rows');

disp('S complete')
W = MatrixSample(S,p,c/2,'cols');
disp('W complete')

fprintf('size W: %d %d\n',size(W))

[U,~,~] = svds(W,k);
U = U';
fprintf('size U: %d %d\n',size(U))

approxA = zeros();
gamma = c*e/(8*k);
w2f = sum(W.*W,'all');
gw2f = gamma*w2f;
for i=1:k
    fprintf('inner loop %d\n',i)
    disp(size(W'))
    disp(size(U(i,:)))
    wtut = W'*U(i,:)';
    if sum(wtut.*2,'all') >= gw2f
        v = S'*U(i,:)'/sqrt(wtut);
        approxA = approxA+(v*v');
    end
end
approxA = A*approxA;

