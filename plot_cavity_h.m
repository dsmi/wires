%
% 2d model of a cavity with TE fields, plot Z-directed H field
%

% The geometry
inch2meter = 2.54e-2;
mil2meter = 1.0e-3*inch2meter;
d = 10.0*mil2meter; % plane-to-plane separation
l = 500.0*mil2meter;  % cavity length
a = d / 10; % radius is not used here

N = 500; % number of the segments in top and bottom
NS = 10;  % number of the vertical source segments

%% [ rb re ] = mkline( 0, -d/2, 0, 0, d/2, 0, N );

[ rb1 re1 ] = mkline( -l/2, -d/2, 0, l/2, -d/2, 0, N );
[ rb2 re2 ] = mkline( -l/2, d/2, 0, l/2, d/2, 0, N );
[ rb3 re3 ] = mkline( 0, -d/2, 0, 0, d/2, 0, NS );
rb = [ rb1 ; rb2 ; rb3 ];
re = [ re1 ; re2 ; re3 ];

freq = 2*pi*1e11;

eps = eps0;
mu = mu0;

Z = mkzmat( rb, re, a, freq, mu, eps, @psi2d );

% Port segment index
pidx = N + N + 1;

% Total number of the segments
N2 = N + N + NS;

% Excitation, V=1 source at center
V = pidx == (1:N2)';

I = Z\V;

% Port impedance
%Zin = 1./I(pidx)

% Field plot area
boxmin = [ -500.0*mil2meter -50.0*mil2meter ];
boxmax = [    0              50.0*mil2meter ];

% Number of point/pixels
nx = 500;
ny = 100;

[ ex ey hz px py ] = calcfields( rb, re, a, freq, mu, eps, I, boxmin, boxmax, nx, ny );

nt = 30;
tt = linspace( 0, 2*pi/freq * ( 1 - 1 / nt ), nt );

for t = tt

    imgname = sprintf( 'img%02u.jpg', find( t == tt ) )

    p = exp( i * freq * t );

    imagesc( [ boxmin( 1 ) boxmax( 1 ) ], [ boxmin( 2 ) boxmax( 2 ) ], real( hz * p ) )
    caxis( [ -5e6 5e6 ] )
    colorbar

    print( imgname, '-djpg', '-S1920,250' )

end


