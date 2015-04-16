function [ output_args ] = quadthrustf( input_args )
%QUADTHRUSTF
%   quadthrustf( input_args ) is a function to figure out thrust required
%   for forward flight.
%
% AUTHOR
%   CHANG, WEI-CHIEH
%   Send bug reports or comments to <602430307@s02.tku.edu.tw>
%   Check https://github.com/addischang1991/QPPA for the latest version
%
% DATE
%   17-Apr-2015
%
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global GeoAlt g AirRho AirTmp AirPre
global Vc Vf
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global PowTot NumBat NumPrp NumMot BatCap PrpRad Mass Weight
global V1h V1f PitchAngle PitchDrag

Sref1 = 0.69e-3;
CD1 = 0.48;
Sref2 = 0.74e-4;
CD2 = 0.98;

for i = 1: 1: LghGeh
    
    ThrustReqX( i, : ) = PitchDrag( i, : ) + ...
        0.5 * AirRho( i, : ) .* Vf.^2 * Sref2 * CD2 .* PitchAngle( i, : );
    ThrustReqY( i, : ) = Weight( i, 1 ) .* ones( size( Vf ) ) + ...
        0.5 * AirRho( i, : ) .* Vf.^2 * Sref2 * CD2;
    ThrustReqF( i, : ) = sqrt( ThrustReqX( i, : ).^2 + ThrustReqY( i, : ).^2 );
    
    PPP( i, : ) =  ( AirRho( i, 1 ) / AirRho( 1, 1 )) .* ...
        ThrustReqF( i, : ) .* ( V1f( i, : ) + Vf ) ./ 0.7;
end

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vc, ThrustReqF );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Thrust (N) ' );
grid on;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vc, PPP );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Power (P) ' );
grid on;

end