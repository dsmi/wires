function Z = mkzmat(x, y, z, a, freq, mu, eps)
% Z = mkzmat(x, y, z, a, freq, mu, eps)
%
%   Populates the moment/impedance matrix for a wire, piecewise constant
%  expansion and pulse testing. (See mktriss for how to convert to Galerkin)
%    x, y, z - wire segment endpoints
%    a       - wire radius
%    freq    - angular frequency
%    mu, eps - parameters of the medium
%

% Beginnings of the segments
xb = x(1:end-1);
yb = y(1:end-1);
zb = z(1:end-1);

% Ends of the segments
xe = x(2:end);
ye = y(2:end);
ze = z(2:end);

% Segment centers
xc = (xb + xe)/2;
yc = (yb + ye)/2;
zc = (zb + ze)/2;

% Segment lengths
l = sqrt((xe-xb).^2 + (ye-yb).^2 + (ze-zb).^2);

% Lenghts of half-segments pairs adjacent to beginning and end
ll = (l(1:end-1) + l(2:end))/2;
lb = [ l(1) ll ];
le = [ ll l(end) ];

k = freq * sqrt(eps * mu);

N = length(x)-1;

% Observation and source lenghts
lm = repmat(l.', 1, N);
ln = repmat(l, N, 1);
lmb = repmat(lb.', 1, N); % at the beginning
lnb = repmat(lb, N, 1);
lme = repmat(le.', 1, N); % at the end
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

Z = jfm*ln.*lm.*psi_mn + 1./jfe.*(psi_mene - psi_menb - psi_mbne + psi_mbnb);
