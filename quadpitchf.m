function [ output_args ] = quadpitchf( input_args )
%QUADPITCHF
%   quadpitchf( input_args ) is a function to figure out pitch angle at
%   steady forward flight.
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
    
    DragPitch( i, : ) = 0.5 * AirRho( i, 1 ) .* ( Vf.^2 ) .* CD1 * Sref1;
    
    TremPitch( i, : ) =  Weight( i, 1 ) ./ DragPitch( i, : );
    %
    theta( i, : ) = asin( ( -TremPitch( i, : ) + sqrt( 4 + TremPitch( i, : ).^2 ) ) ./ 2 );
    
end

PitchAngle = theta;
PitchDrag = DragPitch;

end