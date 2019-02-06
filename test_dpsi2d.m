
freq = 1e10;
wavelen = 2*pi/(freq * sqrt(eps0 * mu0));
k = freq * sqrt(eps0 * mu0);

l = wavelen/20;

a = l/50;

dx = 1e-10;
dy = 1e-10;
dz = 1e-10;

xm = [  1   ,  1 + dx ,  1      ,  1      ];
ym = [  2   ,  2      ,  2 + dy ,  2      ];
zm = [  3   ,  3      ,  3      ,  3 + dz ];
xn = [ -1   , -1      , -1      , -1      ];
yn = [ -0.2 , -0.2    , -0.2    , -0.2    ];
zn = [  0.5 ,  0.5    ,  0.5    ,  0.5    ];

p = psi2d( xm, ym, zm, xn, yn, zn, [ l l l l ], a, k );

xm = xm( 1 );
ym = ym( 1 );
zm = zm( 1 );
xn = xn( 1 );
yn = yn( 1 );
zn = zn( 1 );

[ dpdx, dpdy, dpdz ] = dpsi2d( xm, ym, zm, xn, yn, zn, [ l l l l ], a, k );

dpdx_test = ( p(2) - p(1) ) / dx;
dpdy_test = ( p(3) - p(1) ) / dy;
dpdz_test = ( p(4) - p(1) ) / dz;

assert(abs( dpdx - dpdx_test) < abs( dpdx_test ) * 1e-4)
assert(abs( dpdy - dpdy_test) < abs( dpdy_test ) * 1e-4)
assert(abs( dpdz - dpdz_test) < abs( dpdz_test ) * 1e-4)
