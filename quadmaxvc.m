function [ output_args ] = quadmaxvc( input_args )
%QUADTHRUSTC
%   quadmaxvc( input_args ) is a function to figure out maximum climb
%   velocity at different altitude.
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
global V1h V1c TRC PRC

PowerRequired = PRC;

for i = 1: 1: LghGeh
    [ AmpMaxRc LocMaxRc ] = min( abs(PowTot - PowerRequired( i, : ) ) );
    MaximunRC( i, 1 ) = Vc( 1, LocMaxRc );
end


figure( CutFig )
CutFig = CutFig + 1;
h = plot( MaximunRC, GeoAlt );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Altitude (m) ' );
grid on;