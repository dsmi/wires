% testing rec2sph

[ r t p ] = rec2sph( 1 , 0 , 0 );
assert(max(abs([ r ; t ; p ] - [ 1 ; pi/2 ; 0 ])) < 1e-10)

[ r t p ] = rec2sph( -1 , 0 , 0 );
assert(max(abs([ r ; t ; p ] - [ 1 ; pi/2 ; pi ])) < 1e-10)

[ r t p ] = rec2sph( 0 , 1 , 0 );
assert(max(abs([ r ; t ; p ] - [ 1 ; pi/2 ; pi/2 ])) < 1e-10)

[ r t p ] = rec2sph( 0 , 0 , 1 );
assert(max(abs([ r ; t ; p ] - [ 1 ; 0 ; 0 ])) < 1e-10)

