function [ rb re ] = mkline( x0, y0, z0,  x1, y1, z1, N )
% [ rb re ] = mkline( x0, y0, z0,  x1, y1, z1, N )
%
%   Used in the mesh generation, makes a straight line
%

x = linspace( x0, x1, N + 1 )';
y = linspace( y0, y1, N + 1 )';
z = linspace( z0, z1, N + 1 )';

% Beginnings of the segments
rb = [ x(1:end-1), y(1:end-1), z(1:end-1) ];

% Ends of the segments
re = [ x(2:end), y(2:end), z(2:end) ];
