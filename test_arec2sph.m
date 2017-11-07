% Mutual test of asph2rec and arec2sph. Generate a number of
% positions, and then convert three (basis) vectors from spherical
% to rectangular and back at these coordinates.

nt = 11;
t = linspace(pi/nt/2, pi - pi/nt/2, nt);

np = 11;
p = linspace(pi/np, 2*pi - pi/np, np);

[ tgrid, pgrid ] = meshgrid(t, p);

trow = reshape(tgrid, 1, []);
prow = reshape(pgrid, 1, []);

L = 3;
r = L + 0*trow;
[ rx ry rz ] = sph2rec(r, trow, prow);
[ u1x u1y u1z ] = asph2rec(1, 0, 0, r, trow, prow);
[ u2x u2y u2z ] = asph2rec(0, 1, 0, r, trow, prow);
[ u3x u3y u3z ] = asph2rec(0, 0, 1, r, trow, prow);

% Transform back using arec2sph
[ u1r u1t u1p ] = arec2sph(u1x, u1y, u1z, r, trow, prow);
assert(abs(u1r - 1.0) < 1e-10)
assert(abs(u1t      ) < 1e-10)
assert(abs(u1p      ) < 1e-10)

[ u2r u2t u2p ] = arec2sph(u2x, u2y, u2z, r, trow, prow);
assert(abs(u2r      ) < 1e-10)
assert(abs(u2t - 1.0) < 1e-10)
assert(abs(u2p      ) < 1e-10)

[ u3r u3t u3p ] = arec2sph(u3x, u3y, u3z, r, trow, prow);
assert(abs(u3r      ) < 1e-10)
assert(abs(u3t      ) < 1e-10)
assert(abs(u3p - 1.0) < 1e-10)
