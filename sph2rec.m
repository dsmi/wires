function [ x y z ] = sph2rec(r, t, p)
% Spherical to rectangular coordinate transform.
%  Converts spherical rho, theta, phi coordinates to rectangular
%  x, y, z. Theta is between Z and rho vector as used by Harrington
%

x = r.*sin(t).*cos(p);
y = r.*sin(t).*sin(p);
z = r.*cos(t);
