function g = gain( R0, theta, phi, uth, uph, rb, re, freq, mu, eps, V, I, S )
% g = gain( R0, theta, phi, uth, uph, rb, re, freq, mu, eps, V, I, S )
%
%  Calcuate antenna gain in the given direction. The gain is defined as ratio of the
%  power flow from the actual antenna to one from an omnidirectional one.
%   R0, theta, phi  - spherical coordinates of the probe
%   uth, uph        - spherical coordinate components of polarization vector (this
%                     function computes the gain for only a single polarization of
%                     the radiated field, you need to sum gains for two orthogonal
%                     polarization for the full gain)
%   rb, re          - wire segment beginnings and ends, n-by-3
%   freq, mu, eps   - angular frequency and parameters of the medium
%   V               - antenna exitation voltage
%   I               - calculated antenna current
%   S               - subsampling matrix or identity if no subsampling (see mktriss, mkzmat)
%

% To simplify the notation below
xb = rb( : , 1 )';
yb = rb( : , 2 )';
zb = rb( : , 3 )';
xe = re( : , 1 )';
ye = re( : , 2 )';
ze = re( : , 3 )';

% Segment centers, 1-by-N
cx = (xb + xe)/2;
cy = (yb + ye)/2;
cz = (zb + ze)/2;

% Segment vectors, 1-by-N
lx = xe - xb;
ly = ye - yb;
lz = ze - zb;

% Wavenumber
k = freq * sqrt(eps * mu);

% Probe position
[ r0x r0y r0z ] = sph2rec(R0, theta, phi);
r0 = [ r0x , r0y , r0z ];
r0n = r0 ./ sqrt(sum(r0.*r0)); % normalized

% Wavenumber vector for wave from probe
kr = -k .* r0n; 

% Polarization
[ ux uy uz ] = asph2rec(0, uth, uph, R0, theta, phi);
u = [ ux , uy , uz ];
u = u ./ sqrt(sum(u.*u)); % normalize

% Segment centers
rn = [ cx', cy', cz' ];

% Magnitude of probe-induced E
Erp = exp(-j*sum(rn.*repmat(kr, size(rn, 1), 1), 2));

% Probe-induced excitation
Vr = Erp .* dot(repmat(u, size(rn, 1), 1), [ lx', ly', lz' ], 2);
Vr = S'*Vr; % needs to be subsampled

% Probe normalization so the induced E is of unit amplitude at the origin
m = freq*mu0*exp(-j*k*R0)/(j*4*pi*R0);

% u-polarized component of E from the antenna at the probe
Er = m*Vr.'*I;

% Intrinistic impedance of the medium
nu = sqrt(mu0/eps0);

% Power input to the antenna
Pin = real(V.'*conj(I));

% Gain! (ratio of power flow to omnidirectional power flow)
g = abs(Er)^2/nu / (Pin/(4*pi*R0*R0));
