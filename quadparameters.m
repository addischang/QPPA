function [ output_args ] = quadparameters( input_args )
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
%   15-Apr-2015
%
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global GeoAlt g AirRho AirTmp AirPre
global Vc Vf
global CutGeh CutFig SizGeh SizVc SizVf LghGeh LghVc LghVf
global PowTot NumBat NumPrp NumMot BatCap PrpRad Mass Weight

% VRRIABLES LIST
%   ---- ATMOSPHERE ----
%   AirDat
%       The total data for air. 
%   GeoAlt
%       The geometry altitude
%   AirRho
%       The density for local air  
%   AirTmp
%       The temperature for local air
%   AirPre
%       The pressure for local air
%
%   ---- BASICS ----
%   Vc
%       The row data for vertical velocity.
%   Vf
%       The row data for forward velocity.
%
%   ---- COUNTER ----
%   CutGeh
%       The counter for geometry altitude.
%   CutFig
%       The counter for figure plot.
%   SizGeh
%       The size for geometry altitude.
%   SizVc
%       The size for vertical velocity.
%   SizVf
%       The size for forward vertical.
%   LghGeh 
%       The length for geometry altitude.  
%   LghVc 
%       The length for vertical velocity.
%   LghVf 
%       The length for forward velocity.
%
%   ---- PROPULSION ----
%   PowTot
%       Total Power which motor can supply.
%   BatNum
%       Number of batter
%   BatCap
%       Number of batter
%   PrpNum
%       Number of propellers    
%   PrpRad
%       Radious of propellers
%   MotNum
%       Number of motors

%   ---- SPECIFICTION ----


AirDat = quadstdatm( input_args );
GeoAlt = AirDat( :, 1 );
g      = AirDat( :, 2 );
AirTmp = AirDat( :, 3 );
AirPre = AirDat( :, 5 );
AirRho = AirDat( :, 6 );
Vc = linspace( 0, 20, 20 );
Vf = linspace( 0, 20, 20 );
CutGeh = 1; 
CutFig = 1; 
SizGeh = size( GeoAlt );
LghGeh = length( GeoAlt );
LghVc = length( Vc );  
LghVf = length( Vf );

PowTot = 180;
NumBat = 2;
BatCap = 5.4;
NumPrp = 4;
PrpRad = 0.1543;
NumMot = 4;
MassMot = 0.18;
MassBat = 0.45;
MassFrm = 0.55;
Mass = MassMot * NumMot + MassBat * NumBat + MassFrm;
Weight = Mass .* g;

output_args = 0;

end

