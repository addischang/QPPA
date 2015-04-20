function [ output_args ] = quadindvh( input_args )
%QUADINDVH 
%   quadindvh( input_args ) is a function to figure out the induced
%   velocity of hovering at different altitude.
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
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global NumBat NumPrp NumMot BatCap PrpRad Mass Weight
global V1h

V1h = sqrt( Weight ./ ( 2 .* AirRho .* ( NumPrp * pi * PrpRad^2  ) ) );

% figure( CutFig )
% CutFig = CutFig + 1;
% plot( V1h, GeoAlt, '-^' );
% grid on

end

