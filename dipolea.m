% Impedance and gain of a dipole antenna

freq = 1e9;
k = freq * sqrt(eps0 * mu0);
wavelen = 2*pi/k

% number of segments used in solution
nss = 9;
N2 = 33;
N = N2*nss+(nss-1);

% Antenna parameters
L = wavelen*0.5    % length
a = L/(74.2/2.0)   % radius

% Segment length. Wire endpoint is a center of a segment with zero current
% so half-segment is added at each end -- thus N+1
l = L/(N + 1);

% Antenna wire is parallel to Z
z = linspace(-(L-l)/2, (L-l)/2, N + 1);
x = z*0;
y = z*0;

Z = mkzmat(x, y, z, a, freq, mu0, eps0);
S = mktriss(N, nss);
Z2 = S'*Z*S;

% Center segment index (source)
is = (N2+1)/2;
    
% Excitation, V=1 source at center
V = is == (1:N2)';

I = Z2\V;

% Antenna impedance
Za = 1./I(is)

% Calculate stationary impedance under the assumption of sinusoidal current
tril = L/(N2+1)*2;  % len of subsampled seg with triangular distribution
cz = linspace(-(L-tril)/2, (L-tril)/2, N2); % subsampled segment centers
fi = @(z, Z) cos(z/(Z/2)*(pi/2));
I0 = fi(cz.', L);
Zstat = I0.'*Z2*I0

% Power input to the antenna
Pin = real(V.'*conj(I))

% Generate gain pattern
R0 = L*100.0;
phi = 0;
nt = 153;
dt = 2*pi/nt;
tt = linspace(dt/2, 2*pi - dt/2, nt);
gn = [];
for theta = tt
    g = gain(R0, theta, phi, 1, 0, x, y, z, freq, mu0, eps0, V, I, S);
    gn = [ gn g ];
end

polar(tt, gn)
title('Power-gain pattern of a center-fed half-wave dipole antenna')
