% Impedance and gain of a dipole antenna

freq = 1e9;
k = freq * sqrt(eps0 * mu0);
wavelen = 2*pi/k

% Antenna parameters
L = wavelen*0.5    % length
a = L/(74.2*2.0)   % radius

% Antenna impedance
[ Zin V I S Z2 rb re ] = dipolea( freq, L, a );

Zin

% Calculate stationary impedance under the assumption of sinusoidal current
N2 = length( V ) % number of elements in the MoM solution
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
    g = gain( R0, theta, phi, 1, 0, rb, re, freq, mu0, eps0, V, I, S );
    gn = [ gn g ];
end

polar(tt, gn)
title('Power-gain pattern of a center-fed half-wave dipole antenna')
