% Calculate inductance of a circular loop

% The geometry
R = 1e-1; % radius of the loop
r = 1e-3; % radius of the wire

% number of segments used in solution
N = 10;

[ rb re ] = mkloop( R, N );

%% rx = [ rb(:,1) re(:,1) ];
%% ry = [ rb(:,2) re(:,2) ];
%% plot(rx', ry', 'b-*');

freq = 1e7;

Z = mkzmat( rb, re, r, freq, mu0, eps0 );

% Port segment index -- we can take any
pidx = 1;

% Excitation, V=1 source at center
V = pidx == (1:N)';

I = Z\V;

% Port impedance
Zin = 1./I(pidx)

Lexp = R*mu0*(log(8*R/r)-2)

L = Zin/(j*freq)
