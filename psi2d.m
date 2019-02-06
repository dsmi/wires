function p = psi2d(xm, ym, zm, xn, yn, zn, l, a, k)
% p = psi2d(xm, ym, zm, xn, yn, zn, l, a, k)
%
% Computes the potential integral given by:
%  psi = 1/(4*j*ln)*\int_{n-}^{n+} H^(2)_0 ( k * rho_m )  dl
% where
%  ln is lenght of segment n
%  n- and n+ are endpoints of segment n
%  rho_m is the distance between observation and integration
%        points given by rho_m = sqrt( ( x - xm )^2 + ( y - ym )^2 )
%  H^(2)_0 is the Hankel function of the second kind
% For self term observation is shifted by wire radius (a)
% from the segment center and first two terms of Maclaurin
% series are integrated, for non-self pointwise source
% approximation is used.
%

dx = xm - xn;
dy = ym - yn;
dz = zm - zn;

R = sqrt(dx.*dx + dy.*dy + dz.*dz);

% Identify self-term
selfidx = find( R < 1.0e-15 ); 

% To avoid division by zero
R(selfidx) = a;

% Non-self terms ( typo in Harrington ? length in the denominator )
p = besselh( 0, 2, k*R ) ./ ( 4*j );

e = exp( 1 );
g = 1.7810724179901979;
lself = l(selfidx);

% Self terms ( typo in Harrington ? length in the denominator )
p(selfidx) = 1./( 4*j ) .* ( 1 - j*2/pi*log( g*k*lself ./ ( 4*e ) ) ) ;
