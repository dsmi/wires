function [ ddx, ddy, ddz ] = dpsi2d( xm, ym, zm, xn, yn, zn, l, a, k )
% [ ddx, ddy, ddz ] = dpsi2d( xm, ym, zm, xn, yn, zn, l, a, k )
%
% Computes the derivatives of the the potential integral given by:
%  psi = 1/(4*j*ln)*\int_{n-}^{n+} H^(2)_0 ( k * rho_m )  dl
% with respect to the observation xm ym zm coordinates.
% For the parameters refer to psi2d
%

dx = xm - xn;
dy = ym - yn;
dz = zm - zn;

R = sqrt( dx.*dx + dy.*dy + dz.*dz );

dRdx = dx ./ R;
dRdy = dy ./ R;
dRdz = dz ./ R;

% derivative of p = besselh( 0, 2, k*R ) ./ ( 4*j );
db = k*( besselh( -1, 2, k*R ) - besselh( 1, 2, k*R ) ) ./ ( 8*j );

ddx = db .* dRdx;
ddy = db .* dRdy;
ddz = db .* dRdz;

