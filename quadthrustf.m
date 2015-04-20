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
global DragPa DragWa ThrustF


for i = 1: 1: LghGeh
    
    ThrustReqX( i, : ) = DragPa( i, : ) + DragWa( i, : ) .* PitchAngle( i, : );
    ThrustReqY( i, : ) = Weight( i, 1 ) .* ones( size( Vf ) ) + DragWa( i, : );
    ThrustReqF( i, : ) = sqrt( ThrustReqX( i, : ).^2 + ThrustReqY( i, : ).^2 );
    
end

PowTot * 0.7 / V1h( 1, 1)

EQLD = ThrustReqF( CutGeh, : ) ./ (  DragWa( CutGeh, : ) +  DragPa( CutGeh, : ) );

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, ThrustReqF( CutGeh, : ), '-.k' );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Thrust Required(N) ' );
grid on;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, ThrustReqY( CutGeh, : ), '-.k' );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Thrust (N) ' );
grid on;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, ThrustReqX( CutGeh, : ), '-.m' );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Thrust (N) ' );
grid on;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, EQLD, '-.g' );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' EQLD' );
grid on;



ThrustF = ThrustReqF;

end