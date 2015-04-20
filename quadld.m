function [ output_args ] = quadld( input_args )
%QUADLD
%   quadld( input_args ) is a function to figure out the equivent lift over
%   drag.
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
    
    Lift( i, : ) = ThrustF( i, : ) ;
    Drag( i, : ) = ThrustF( i, : ) .*  PitchAngle( i, : );
    LOVD( i, : ) = Lift( i, : ) ./ Drag( i, : ) ;
    
end


figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vf, LOVD( CutGeh, : ) );
set( h, 'linewidth', 1.9 );
xlabel( ' Forward Velocity (m/s) ' );
ylabel( ' Thrust (N) ' );
grid on;


end