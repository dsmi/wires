function p = psi(xm, ym, zm, xn, yn, zn, l, a, k)
% p = psi(xm, ym, zm, xn, yn, zn, l, a, k)
%
% Computes the potential integral given by:
%  psi = 1/(4*pi*ln)*\int_{n-}^{n+} exp(-j*k*Rm)/Rm dl
% where
%  ln is lenght of segment n
%  n- and n+ are endpoints of segment n
%  Rm is the distance between observation and integration
%     points
% For self term observation is shifted by wire radius (a)
% from the segment center and first two terms of Maclaurin
% series are integrated, for non-self pointwise source
% approximation is used.
%

dx = xm - xn;
dy = ym - yn;
dz = zm - zn;

R = sqrt(dx.*dx + dy.*dy + dz.*dz);

% Identify self-terms
selfidx = find( R < 1.0e-15 );

% To avoid division by zero
R(selfidx) = a;

% Non-self terms
p = exp(-j*k*R)./(4*pi*R);

% Self terms
p(selfidx) = 1./(2*pi*l(selfidx)).*log(l(selfidx)/a) - j*k/(4*pi);
