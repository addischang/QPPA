function [ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu, Vf0, Vf1 )
% FORWARDFLIGHT
%     forwardflight( FM, Nu, Vc0, Vc1 ) is a co-function with
%     QUADAnalyser. The main propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the 


% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 17:21:33
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 3.0
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global AirDensity Power Gravity TotalMass Weight RotorNumber RotorRadious Sref1 Sref2 CD1 CD2


if nargin == 2
    Vf0 = 0;
    Vf1 = 18;
elseif nargin == 3
    Vf1 = 18;
end    
    

% 
RoterArea = pi * RotorRadious^2;
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );

%
Vf = linspace( Vf0, Vf1, 1000 );
V1f = sqrt( - ( Vf.^2 / 4 ) + sqrt( ( Vf.^2 / 4 ).^2 + V1h^4 ) );

% 
theta = quadpitch( Vf );

%
ThrustReqF = 0.5 * AirDensity .* ( ( 2 .* V1f ).^2 ) .* CD2 * Sref2...
           + 0.5* AirDensity .* Vf.^2 .* CD1 * Sref1 .* cos( theta ) .* sin(theta)...
           + Weight .* cos( theta ) ;
       

% Ther process to computing the power required for each term.
PowerAva = Power * FM .* ones( size( Vf ) );
PowerPro = ( ThrustReqF .* ( V1f + Vf .* sin( theta ) ) ./ FM ) ./ ( 1 - Nu );
PowerPra = 0.5 * AirDensity * Sref1 * CD1 .* cos( theta ) .*  Vf.^3  ;  
PowerTot = PowerPro + PowerPra;
PowerExc = PowerAva - PowerTot;
% 
[ PowerAmp PowerLoc ] = min( PowerTot );
[ MaxrcAmp MaxrcLoc ] = min( abs( PowerTot - PowerAva ) );

OPTFW = Vf( PowerLoc );
PORFW = PowerAmp;
MAXFW = Vf( MaxrcLoc );
EXCFW = max( PowerExc )

figure( 3 );
h3 = plot( Vf, PowerPra, '--g', Vf, PowerPro, '--b' , Vf, PowerTot, 'r', Vf, PowerAva, 'm');
title( ' Power Required in Forward Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h3, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 4 );
h4 = plot( Vf, PowerExc );
title( ' Excess Power in Forward Flight' );
legend( 'Excess' )
set( h4, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

{[ 'Opt. FW = ' num2str( round( OPTFW ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORFW ) ) ' W   ' ];
 [ 'Max. FW = ' num2str( round( MAXFW ) ) ' m/s ' ]}
