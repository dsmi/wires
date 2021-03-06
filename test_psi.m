
freq = 1e10;
wavelen = 2*pi/(freq * sqrt(eps0 * mu0));
k = freq * sqrt(eps0 * mu0);

l = wavelen/20;

a = l/50;


xm = [ 1 1 1 100 100 100 ];
ym = [ 1 1 1 1   1   1   ];
zm = [ 1 1 1 1   1   1   ];
xn = [ 1 1 1 1   1   1   ];
yn = [ 1 1 1 1   1   1   ];
zn = [ 1 1 1 1   1   1   ];
p = psi(xm, ym, zm, xn, yn, zn, [ l l l l l l ], a, k);

selfp = p(1);

% Now do numerical integration to test self-term
N = 25001;
dz = l/N;
cz = linspace(-(l-dz)/2, (l-dz)/2, N);
R = sqrt(cz.*cz + a.*a);
selfp_test = sum(exp(-j*k*R)./(4*pi*R))*dz/l;

nonselfp = p(4);
R = 99;
nonselfp_test = exp(-j*k*R)./(4*pi*R);

assert(abs(selfp - selfp_test) < abs(selfp_test) * 1e-2)
assert(abs(nonselfp - nonselfp_test) < abs(selfp_test) * 1e-2)
