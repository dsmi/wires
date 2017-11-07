function [ Ax Ay Az ] = asph2rec(Ar, At, Ap, r, t, p)
% Transforms coordinate components of a vector from spherical to rectangular.
% Theta is between Z and rho vector as used by Harrington
%

Ax = Ar.*sin(t).*cos(p) + At.*cos(t).*cos(p) - Ap.*sin(p);
Ay = Ar.*sin(t).*sin(p) + At.*cos(t).*sin(p) + Ap.*cos(p);
Az = Ar.*cos(t) - At.*sin(t);
