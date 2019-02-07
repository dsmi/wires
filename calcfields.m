function [ ex ey hz px py ] = calcfields( rb, re, a, freq, mu, eps, I, ...
                                          xymin, xymax, nx, ny )
%
% [ ex ey hz px py ] = calcfields( rb, re, a, freq, mu, eps, I, xymin, xymax, nx, ny )
%
% Calculate E and H fields for 2d TE problems to make the field plots
%

% Fields area size
xysize = xymax - xymin;

% Scale to translate from pixels to geo
scale = xysize./[ nx ny ];

% Pixel indices, one-based
[ xi, xj ] = meshgrid( 1:nx, 1:ny );

% Pixel coordinates
px = xymin( 1 ) + scale( 1 ) * ( xi - 0.5 );
py = xymin( 2 ) + scale( 2 ) * ( xj - 0.5 );

ex = px * 0;
ey = py * 0;
hz = py * 0;

% Number of segments
N = size( rb, 1 );

% To simplify the notation below
xb = rb( : , 1 )';
yb = rb( : , 2 )';
zb = rb( : , 3 )';
xe = re( : , 1 )';
ye = re( : , 2 )';
ze = re( : , 3 )';

% Segment centers, 1-by-N
xc = (xb + xe)/2;
yc = (yb + ye)/2;
zc = (zb + ze)/2;

% Segment vectors, 1-by-N
lx = xe - xb;
ly = ye - yb;
lz = ze - zb;

% Segment lengths, 1-by-N
l = sqrt(lx.^2 + ly.^2 + lz.^2);

% Wavenumber
k = freq * sqrt( eps * mu );

wavelen = 2*pi/k

% The fields are calculated column at once
for oj = 1:nx

    % Source segment vectors
    lxn = repmat(lx, ny, 1);
    lyn = repmat(ly, ny, 1);
    lzn = repmat(lz, ny, 1);

    % Source lenghts
    ln = repmat(l, ny, 1);

    % Observation points and source centers
    xm = repmat(px(:,oj), 1, N);
    ym = repmat(py(:,oj), 1, N);
    zm = 0*ym;
    xn = repmat(xc, ny, 1);
    yn = repmat(yc, ny, 1);
    zn = repmat(zc, ny, 1);

    % Source beginnings
    xnb = repmat(xb, ny, 1);
    ynb = repmat(yb, ny, 1);
    znb = repmat(zb, ny, 1);

    % Source ends
    xne = repmat(xe, ny, 1);
    yne = repmat(ye, ny, 1);
    zne = repmat(ze, ny, 1);

    % Finally the potential integrals
    psi_mn = psi2d( xm, ym, zm, xn, yn, zn, ln, a, k );

    [ dpsi_mn_dx dpsi_mn_dy ] = dpsi2d( xm, ym, zm, xn, yn, zn, ln, a, k );

    [ dpsi_nb_dx dpsi_nb_dy ] = dpsi2d( xm, ym, zm, xnb, ynb, znb, ln, a, k);
    [ dpsi_ne_dx dpsi_ne_dy ] = dpsi2d( xm, ym, zm, xne, yne, zne, ln, a, k);

    jfm = j*freq*mu;
    jfe = j*freq*eps;

    ex(:,oj) = ( -jfm*lxn.*psi_mn - 1/jfe*( -dpsi_nb_dx + dpsi_ne_dx ) ) * I;
    ey(:,oj) = ( -jfm*lyn.*psi_mn - 1/jfe*( -dpsi_nb_dy + dpsi_ne_dy ) ) * I;

    hz(:,oj) = 1/mu*( lyn.*dpsi_mn_dx - lxn.*dpsi_mn_dy ) * I;
end
