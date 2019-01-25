function [ Zin V I S Z2 rb re ] = dipolea( freq, L, a )
% [ Zin V I S Z2 rb re ] = dipolea( freq, L, a )
%  Calculate the input impedance of a dipole antenna, also returns
%  the excitation voltage vector and the current distribution.
%  L is the length and a is the radius.
%  S is the subsampling matrix (see mktriss, mkzmat) Z2 is the generalized
%  impedance matrix of the antenna, rb and re are the segment endpoints.

% number of segments used in solution
nss = 9;
N2 = 33;
N = N2 * nss + ( nss - 1 );

% Segment length. Wire endpoint is a center of a segment with zero current
% so half-segment is added at each end -- thus N+1
l = L/(N + 1);

% Antenna wire is parallel to Z
z = linspace(-(L-l)/2, (L-l)/2, N + 1)';
x = z*0;
y = z*0;

% Beginnings of the segments
rb = [ x(1:end-1), y(1:end-1), z(1:end-1) ];

% Ends of the segments
re = [ x(2:end), y(2:end), z(2:end) ];

Z = mkzmat( rb, re, a, freq, mu0, eps0 );
S = mktriss(N, nss);
Z2 = S'*Z*S;

% Center segment index (source)
is = (N2+1)/2;

% Excitation, V=1 source at center
V = is == (1:N2)';

I = Z2\V;

% Antenna impedance
Zin = 1./I(is);
