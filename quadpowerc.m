function [ output_args ] = quadpowerc( input_args )
%QUADTHRUSTC
%   quadpowerc( input_args ) is a function to figure out the power
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
global V1h V1c TRC PRC

ThrustRequired = TRC;

for i = 1: 1: LghGeh
    
    % Declarte the 
    Kappa( i, 1 ) =  AirRho( 1, 1 ) / ( AirRho( i, 1 ) * 0.9 * 0.8 ); 
    PowerRequired( i, : ) = Kappa( i, 1 ) .* ThrustRequired( i, : ) .* ( Vc + V1c( i, : ) ); 
    
       
end

PRC = PowerRequired;

figure( CutFig )
CutFig = CutFig + 1;
h = plot( Vc, PowerRequired( CutGeh, : ) );
set( h, 'linewidth', 1.9 );
xlabel( ' Climb Velocity (m/s) ' );
ylabel( ' Power (W) ' );
grid on;


end