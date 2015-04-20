function [ output_args ] = quaddragf( input_args )
% QUADDRAG
%   quaddragf( input_args ) is a function to figure out the drag at forward
%   flight.
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
global Sref1 CD1 Sref2 CD2 
global DragPa DragWa

for i = 1: 1: LghGeh

    ParasiteDrag( i, : ) = 0.5 .* AirRho( i, 1 ) .* Vf.^2 .* Sref1 * CD1;
    WakeDrag( i, : ) = 0.5 .* AirRho( i, 1 ) .* ( 2 .* V1f( i, : ) ).^2 .* Sref1 * CD1;
    
end    
    
DragPa = ParasiteDrag;
DragWa = WakeDrag;

end