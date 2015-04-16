function [ output_args ] = quadindvf( input_args )
%QUADTHRUSTC
%   quadindvf( input_args ) is a function to figure out induced velocity
%   in forward flight.
%
% AUTHOR
%   CHANG, WEI-CHIEH
%   Send bug reports or comments to <602430307@s02.tku.edu.tw>
%   Check https://github.com/addischang1991/QPPA for the latest version
%
% DATE
%   16-Apr-2015
%
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global GeoAlt
global Vc Vf
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global PowTot NumBat NumPrp NumMot BatCap PrpRad Mass Weight
global V1h V1f 

for i = 1: 1: LghGeh
    indv( i, : ) = sqrt( - ( Vf.^2 / 2 ) + ...
            sqrt( ( Vf.^2 / 2 ).^2 + V1h( i, 1 )^4 ) );
    delv( i, : ) = indv( i, : ) + Vf;
end

V1f = indv;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, indv );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Altitude (m) ' );
grid on;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, delv );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Altitude (m) ' );
grid on;

end