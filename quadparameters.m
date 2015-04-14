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
% COPYRIGHT
%   2015 by Avionics And Flight Simulation Laboratory

global Vc Vf
global CutGeh CutFig SizGeh SizVc SizVf
global AirRho AirTmp AirPre

% VRRIABLES LIST
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
%
%   ---- ATMOSPHERE ----
%   AirDat
%       The total data for air.
    AirDat = quadstdatm( input_args );
    
%   AirRho
%       The density for local air
    AirRho = AirDat( :, 6 );
    
%   AirTmp
%       The temperature for local air
    AirTmp = AirDat( :, 3 );
    
%   AirPre
%       The pressure for local air
    AirPre = AirDat( :, 5 );

%   ---- PROPULSION ----
%   PowTot
%   BatNum
%       Number of batter
    BatNum = 2;
    
%   BatCap
%       Number of batter
    BatCap = 5.4;
    
%   PrpNum
%       Number of propellers
    PrpNum = 4;
    
%   PrpRad
%       Radious of propellers
    PrpRad = 0.1543;

%   MotNum
%       Number of motors
    MotNum = 4

%   ---- SPECIFICTION ----



end

