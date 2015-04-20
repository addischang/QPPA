function [ output_args ] = quadpowerf( input_args )
% QUADPARAMETERS
%   quadparameters( input_args ) is a function to declare the necessary parameters
%   for the quadrotor.
%
% AUTHOR
%   CHANG, WEI-CHIEH
%   Send bug reports or comments to <602430307@s02.tku.edu.tw>
%   Check https://github.com/addischang1991/QPPA for the latest version
%
% DATE
%   20-Apr-2015
%
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global GeoAlt g AirRho AirTmp AirPre
global Vf V1h V1f PitchAngle PitchDrag
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global DragPa DragWa ThrustF

for i = 1: 1: LghGeh

    PPP( i, : ) =  ThrustF( i, : ) .* V1f( i, : ) ./ 0.7;
    
    PP2( i, : ) =  DragPa( i, : ) .* Vf.^2;
    
    ppT( i, : ) =  ( AirRho( i, 1 ) / AirRho( 1, 1 ) ) .* ( PPP( i, : )+PP2( i, : ) );
    
end    
   

% plot( Vf, ppT )

end