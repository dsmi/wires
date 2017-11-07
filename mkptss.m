function S = mkptss(N, nss)
% S = mkptss(N, nss)
%  Similar to mktriss, but just picks every nss'th point
% 

N2 = (N-(nss-1))/nss;
S = zeros(N2, N);
S( sub2ind(size(S), 1:N2, nss*(1:N2)) ) = 1;
