function [ output_args ] = quadindvc( input_args )
%QUADINDVH
%   quadindvc( input_args ) is a function to figure out the induced
%   velocity of vertical climb at different altitude.
%
% AUTHOR
%   CHANG, WEI-CHIEH
%   Send bug reports or comments to <602430307@s02.tku.edu.tw>
%   Check https://github.com/addischang1991/QPPA for the latest version
%
% DATE
%   15-Apr-2015
%
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global GeoAlt g AirRho AirTmp AirPre
global Vc Vf
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global NumBat NumPrp NumMot BatCap PrpRad Mass Weight
global V1h V1c

for i = 1: 1: LghGeh
    indv( i, : ) =  ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h( 1, 1 )^2 );
end

V1c = indv;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vc, V1c( CutGeh, : ) );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Induced velocity (m/s) ' );
grid on;
end

