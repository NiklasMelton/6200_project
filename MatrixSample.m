function [S] = MatrixSample(A,p,c,args)
B = A;
%matrix_sample extracts samples rows or columns from a matrix A
% p = int((10^7)*max((k^4)*(c^-3)*(e^-3), (k^2)*(c^-3)*(e^-4)));
if nargin == 3 && strcmp(args,'cols')
    B = B';
end

[m,n] = size(B);
Frobenius = sum(B.*B,'all');
cFrob = c/Frobenius;

% disp(p)
% p = min(m,p);
assert(p <= m)

P_min = zeros(m,1);
for i=1:m
    P_min(i) = cFrob*sum(B(i,:).*B(i,:),'all');
end
P_min = P_min/sum(B.*B,'all');

P_min = P_min/sum(P_min,'all');

S = zeros(p,n);

for i=1:p
    ti = randsample(m,1,true,P_min);
    S(i,:) = B(ti,:)/sqrt(double(p)*P_min(i));
end

if nargin == 2 && strcmp(args,'cols')
    S = S';
end

af = Frobenius;
sf = sum(S.*S,'all');
assert(0.5*af <= sf,'.5*A frob is > S frob')
% disp(sf)
% disp(1.5*af)
assert(sf <= 1.5*af,'S frob is > 1.5*A frob')