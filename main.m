% MAIN.M
%   First  edtion : 05-Dec-2014 01:37:56
%   Lasted edtion : 06-Apr-2015 17:18:09
%
% DESCRIPTION
%   This file is the main file for QPPA.
%
% COPPYRIGHT
%   Copy right 2015 ASFL, Dept. of Aerospace Engineering, Tamkang
%   University.
%
% AUTHOOR INFORMACTIONS
%   Chang, Wei-Chieh 
%    addischang1991@gmail.com

clear all
clf
clc

global CounterGeh DividorGeh;
CounterGeh = 1;
DividorGeh = 5;
k1 = quadparameters( linspace( 0, 7000, DividorGeh ) );
k2 = verticalflight( 0, 10 );
[ PORFW OPRFW POPRFW ] = forwardflight( 0.1, 25 );  

% Compute the forward parameters for quadrotor.
endurance = quadendurance( PORFW );
range = quadrange( OPRFW, POPRFW );
