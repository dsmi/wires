% Plot admittance of a dipole antenna

freq = 1e9;
k = freq * sqrt(eps0 * mu0);
wavelen = 2*pi/k

% Length multiplier range
lmr = linspace( 0.1, 2, 200 );

% Input admittance
Y = [];

for lm = lmr
    % Antenna parameters
    L = wavelen*lm    % length
    a = L/(74.2*2.0)   % radius

    % Antenna impedance
    Z = dipolea( freq, L, a );

    Y = [ Y inv( Z ) ];
end

plot( lmr, real( Y ), '-r', lmr, imag( Y ), '-b' )
legend( 'real( Y )', 'imag( Y )' )
title('Imput admittance of a center-fed dipole antenna')
ylabel('S')
xlabel('l/wl')
