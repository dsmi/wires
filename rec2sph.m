function [ r t p ] = rec2sph(x, y, z)
% Rectangular to spherical coordinate transform.
%  Converts xyz to spherical rho, theta, phi. Theta is between Z and rho
%  vector as used by Harrington.
%

r = sqrt(x.*x + y.*y + z.*z);
t = atan2(sqrt(x.*x + y.*y), z);
p = atan2(y, x);
