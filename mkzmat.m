function Z = mkzmat( rb, re, a, freq, mu, eps )
% Z = mkzmat( rb, re, a, freq, mu, eps )
%
%   Populates the moment/impedance matrix for a wire, piecewise constant
%  expansion and pulse testing. (See mktriss for how to convert to Galerkin)
%    rb, re      - wire segment beginnings and ends, n-by-3
%    a           - wire radius
%    freq        - angular frequency
%    mu, eps     - parameters of the medium
%

% Wavenumber
k = freq * sqrt(eps * mu);

% Number of segments
N = size( rb, 1 );

% To simplify the notation below
xb = rb( : , 1 )';
yb = rb( : , 2 )';
zb = rb( : , 3 )';
xe = re( : , 1 )';
ye = re( : , 2 )';
ze = re( : , 3 )';

% Segment centers, 1-by-N
xc = (xb + xe)/2;
yc = (yb + ye)/2;
zc = (zb + ze)/2;

% Segment vectors, 1-by-N
lx = xe - xb;
ly = ye - yb;
lz = ze - zb;

% Segment lengths, 1-by-N
l = sqrt(lx.^2 + ly.^2 + lz.^2);

% Observation and source segment vectors
lxm = repmat(lx.', 1, N);
lym = repmat(ly.', 1, N);
lzm = repmat(lz.', 1, N);
lxn = repmat(lx, N, 1);
lyn = repmat(ly, N, 1);
lzn = repmat(lz, N, 1);

% Lenghts of half-segments pairs adjacent to beginning and end
ll = (l(1:end-1) + l(2:end))/2;
lb = [ l(1) ll ];
le = [ ll l(end) ];

% Source lenghts
ln = repmat(l, N, 1);
lnb = repmat(lb, N, 1);
lne = repmat(le, N, 1);

% Observation and source centers
xm = repmat(xc.', 1, N);
ym = repmat(yc.', 1, N);
zm = repmat(zc.', 1, N);
xn = repmat(xc, N, 1);
yn = repmat(yc, N, 1);
zn = repmat(zc, N, 1);

% Observation and source beginnings
xmb = repmat(xb.', 1, N);
ymb = repmat(yb.', 1, N);
zmb = repmat(zb.', 1, N);
xnb = repmat(xb, N, 1);
ynb = repmat(yb, N, 1);
znb = repmat(zb, N, 1);

% Observation and source ends
xme = repmat(xe.', 1, N);
yme = repmat(ye.', 1, N);
zme = repmat(ze.', 1, N);
xne = repmat(xe, N, 1);
yne = repmat(ye, N, 1);
zne = repmat(ze, N, 1);

% Finally the potential integrals
psi_mn = psi(xm, ym, zm, xn, yn, zn, ln, a, k);
psi_mbnb = psi(xmb, ymb, zmb, xnb, ynb, znb, lnb, a, k);
psi_mbne = psi(xmb, ymb, zmb, xne, yne, zne, lne, a, k);
psi_menb = psi(xme, yme, zme, xnb, ynb, znb, lnb, a, k);
psi_mene = psi(xme, yme, zme, xne, yne, zne, lne, a, k);

jfm = j*freq*mu;
jfe = j*freq*eps;

lmln = lxm.*lxn + lym.*lyn + lzm.*lzn;

Z = jfm*lmln.*psi_mn + 1./jfe.*(psi_mene - psi_menb - psi_mbne + psi_mbnb);
