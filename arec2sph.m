function [ Ar At Ap ] = arec2sph(Ax, Ay, Az, r, t, p)
% Transforms coordinate components of a vector from rectangular to spherical.
% Theta is between Z and rho vector as used by Harrington
%

Ar = Ax.*sin(t).*cos(p) + Ay.*sin(t).*sin(p) + Az.*cos(t);
At = Ax.*cos(t).*cos(p) + Ay.*cos(t).*sin(p) - Az.*sin(t);
Ap = -Ax.*sin(p) + Ay.*cos(p);
