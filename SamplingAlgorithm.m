function [approxA] = SamplingAlgorithm(A,k,e)

c = 1.;

p1 = (k^4)*(c^-3)*(e^-3);
p2 = (k^2)*(c^-3)*(e^-4);

p = int16((10^7)*max(p1, p2));
p = min(size(A,1),p);

k = min(p,k);
assert(k <= p)
S = MatrixSample(A,p,c,'rows');
W = MatrixSample(S,p,c/2,'cols');

[U,~,~] = svds(W,k);
U = U';


approxA = zeros();
gamma = c*e/(8*k);
w2f = sum(W.*W,'all');
gw2f = gamma*w2f;
for i=1:k
    wtut = W'*U(i,:)';
    nwtut = sum(wtut.*2,'all');
    if nwtut >= gw2f
        v = S'*U(i,:)'/sqrt(nwtut);
        approxA = approxA+(v*v');
    end
end
approxA = A*approxA;

