function [ rb re ] = mkloop( r, n )
% [ rb re ] = mkloop( r, n )
%
% Makes a circular loop in x-y plane centered at the origin.
% Radius is r, number of edges around the circle is n.
%

a = linspace(0, 2*pi, n+1).';

x = cos(a)*r;
y = sin(a)*r;
z = x*0;

% Beginnings of the segments
rb = [ x(1:end-1), y(1:end-1), z(1:end-1) ];

% Ends of the segments
re = [ x(2:end), y(2:end), z(2:end) ];
