function S = mktriss(N, nss)
% S = mktriss(N, nss)
%
% Make matrix implementing triangular subsampling.
% To illustrate the idea, for nss = 2
%  Z2 = Z*S gives Z2(i,j) = Z(i, j*2-1)/2 + Z(i, j*2) + Z(i, j*2+1)/2
% It can be used to make Galerkin from piecewise-constant and
% point matching as
%  Z2 = S'*Z*S
%
% Number of unknowns before (N) and after (N2) subsampling are related as:
%  N = N2*nss+(nss-1);
%  N2 = (N-(nss-1))/nss;
%

N2 = (N-(nss-1))/nss;

S = zeros(N, N2);
S( sub2ind(size(S), nss*(1:N2), 1:N2) ) = 1;
for ss = 1:(nss-1)
    S( sub2ind(size(S), nss*(1:N2)-ss, 1:N2 ) ) = (nss-ss)/nss;
    S( sub2ind(size(S), nss*(1:N2)+ss, 1:N2 ) ) = (nss-ss)/nss;
end
