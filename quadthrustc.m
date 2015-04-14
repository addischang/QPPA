function [ output_args ] = quadthrustc( input_args )
%QUADTHRUSTC
%   quadthrustc( input_args ) is a function to figure out the thrust
%   required in vertical climb
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
global V1h V1c TRC

Sref1 = 0.69e-3; 
CD1 = 0.48;
Sref2 = 0.74e-4;
CD2 = 0.98;

for i = 1: 1: LghGeh
    
    % Declare the thrust required from the forces act on the quadrotor.
    % The thrust have to elimiate drag, wake drag and weight. \
    DragParasi( i, : ) = 0.5 * AirRho( i, 1 ) * Sref1 * CD1 .* ( Vc.^2 );
    DragParasi2( i, : ) = 0.5 * AirRho( i, 1 ) * Sref2 * CD2 .* ( ( 2 .* V1c( i, : ) ).^2 );
    
    %
    ThrustRequired( i, : ) =  DragParasi( i, : ) +  DragParasi2( i, : ) + Weight( i, 1 );
    
end

TRC = ThrustRequired;


figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vc, ThrustRequired( CutGeh, : ) );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Thrust (N) ' );
grid on;









end