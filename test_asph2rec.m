
% Position #1
rtp = [ 1 ; 0 ; 0 ];

Artp = [ 1 ; 0 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 0 ; 0 ; 1 ])) < 1e-10)

Artp = [ 1 ; 1 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; 0 ; 1 ])) < 1e-10)

Artp = [ 1 ; 1 ; -1 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; -1 ; 1 ])) < 1e-10)

% Position #2
rtp = [ 1 ; pi/2 ; 0 ];

Artp = [ 1 ; 0 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; 0 ; 0 ])) < 1e-10)

Artp = [ 1 ; 1 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; 0 ; -1 ])) < 1e-10)

Artp = [ 1 ; 1 ; -1 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; -1 ; -1 ])) < 1e-10)

% Position #3
rtp = [ 1 ; -pi/2 ; pi/2 ];

Artp = [ 1 ; 0 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 0 ; -1 ; 0 ])) < 1e-10)

Artp = [ 1 ; 1 ; 0 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 0 ; -1 ; 1 ])) < 1e-10)

Artp = [ 1 ; 1 ; -1 ];
[ Ax Ay Az ] = asph2rec(Artp(1), Artp(2), Artp(3), rtp(1), rtp(2), rtp(3));
assert(max(abs([ Ax ; Ay ; Az ] - [ 1 ; -1 ; 1 ])) < 1e-10)

