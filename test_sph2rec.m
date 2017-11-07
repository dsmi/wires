% testing sph2rec

[ x y z ] = sph2rec( 1 , 0 , 0 );
assert(max(abs([ x ; y ; z ] - [ 0 ; 0 ; 1 ])) < 1e-10)

[ x y z ] = sph2rec( 1 , pi/2 , 0 );
assert(max(abs([ x ; y ; z ] - [ 1 ; 0 ; 0 ])) < 1e-10)

[ x y z ] = sph2rec( 1 , pi/2 , pi/2 );
assert(max(abs([ x ; y ; z ] - [ 0 ; 1 ; 0 ])) < 1e-10)
