function [ aa bb cc ] = forwardflight( Vf0, Vf1 )
% FORWARDFLIGHT
%     forwardflight( Vc0, Vc1 ) is a co-function with QUADAnalyser. The main
%     propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the
%
% COPPYRIGHT
%   Copy right 2015 ASFL, Dept. of Aerospace Engineering, Tamkang
%   University.
%
% AUTHOOR INFORMACTIONS
%   Chang, Wei-Chieh
%    addischang1991@gmail.com

global FM Nu SizeM LengM CounterFig CounterGeh DividorGeh
global GeoHeight AirDensity Power Gravity TotalMass Weight
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

if nargin == 0
    Vf0 = 0.5;
    Vf1 = 20;
elseif nargin == 1
    Vf1 = 20;
end

% Declare a row data for forward speed. From Vf0 to Vf1, divid into 1000
% steps.
Vf = linspace( Vf0, Vf1, 15 );

% Ther process to computing the power required for each term. The power
% avaliable is derived from the momentum method. With the forward speed
% increase, the thrust avaliable will decrease. The propeller power is the
% power which dispat at propeller, the parasite is the power to elimiate the
% drag. Thus, the total power is the summation of propeller and parasite
% power. Notice that, the power avaliable will be a constant.
PowerAva = Power .* ones( size( Vf ) );


for i = 1: 1: LengM
    
    % The induced velocity in hoveing, deriving from momemtum method.
    V1h( i, 1 ) = sqrt( Weight( i, 1 ) / ( 2 * AirDensity( i, 1 ) * RotorNumber * RoterArea ) );
    
    % Pitch angle estiamtion, if you want know more detail, please check my
    % master thesis. There have more dissucss.
    % Determinate the drag by standard drag equation.
    DragPitch( i, : ) = 0.5 * AirDensity( i, 1 ) .* ( Vf.^2 ) .* CD1 * Sref1 ...
        +  0.5 * AirDensity( i, 1 ) .* ( Vf.^2 ) .* CD2 * Sref2;
    %
    TremPitch( i, : ) =  Weight( i, 1 ) ./ DragPitch( i, : );
    %
    theta( i, : ) = asin( ( -TremPitch( i, : ) + ...
        sqrt( 4 + TremPitch( i, : ).^2 ) ) ./ 2 );
    
    % Here have three methods to figure out the induced velocity at propeller,
    % first method is based on my theory, but it still need be approved by my
    % thesis advisor. The second is to calculate the induced veloctity on
    % helicopter. The equation is exact solution. The third is an approximation
    % solution.
    Methods = 2;
    if Methods == 1
        V1f( i, : ) = -0.5 .* Vf .* sin( theta( i, : ) ) + ...
            sqrt( ( 0.5 .* Vf .* sin( theta( i, : ) ) ).^2 + V1h( i, 1 )^2 );
        V2f( i, : ) = 2 .* V1f( i, : );
    elseif Methods == 2
        V1f( i, : ) = sqrt( - ( Vf.^2 / 2 ) + ...
            sqrt( ( Vf.^2 / 2 ).^2 + V1h( i, 1 )^4 ) );
        V2f( i, : ) = 2 .* V1f( i, : );
    elseif Methods == 3
        V1f( i, : ) = ( V1h( i, 1 )^2 ) ./ Vf;
        V2f( i, : ) = 2 .* V1f( i, : );
    end
    
    % Calculate the nacessary thrust of the quadrotor which provided by
    % propeller. The equation is derived from the force diagram. The Parasite
    % drag is base on standard drag equation.
    saa = 1;
    if saa == 1
        DragParasi( i, : ) = 0.5 * AirDensity( i, 1 ) .* ( Vf.^2 ).* CD1 * Sref1;
        DragParasi2( i, : ) = 0.5 * AirDensity( i, 1 ) .* ( V2f( i, : ) + ...
            Vf .*  theta( i, : ) ).^2  * CD2 * Sref2;
    else
        DragParasi( i, : ) = 0.5 * AirDensity( i, 1 ) .* ( Vf.^2 ) ...
            .* CD1 * Sref1 .* cos( theta( i, : ) );
        DragParasi2( i, : ) = 0.5 * AirDensity( i, 1 ) .* ( V2f( i, : ) + ...
            Vf .* sin( theta( i, : ) ) ).^2  * CD2 * Sref2;
    end
    % Calculate the nacessary thrust of the quadrotor which provided by
    % propeller. The equation is derived from the force diagram.
    ThrustReqX( i, : ) = DragParasi( i, : );
    ThrustReqY( i, : ) = Weight( i, 1 ) .* ones( size( Vf ) );
    ThrustReqF( i, : ) = sqrt( ThrustReqX( i, : ).^2 + ThrustReqY( i, : ).^2 );
    ThrustAvaF( i, : ) = FM .* PowerAva ./ ( V1f( i, : ) + Vf .* sin( theta( i, : ) ) );
    ThrustExcF( i, : ) = ThrustAvaF( i, : ) - ThrustReqF( i, : );
    
    % Here are algorithms withch compute total change of inflow velocity
    % at propeller. You have three choice, the first one is apply small
    % angle assumption, second one is
    DvfMtd = 1;
    if DvfMtd == 1
        if saa == 1
            deltaVf( i, : ) = V1f( i, : ) + Vf .* theta( i, : );
        else
            deltaVf( i, : ) = V1f( i, : ) + Vf .* sin( theta( i, : ) );
        end
    else
        deltaVf( i, : ) = V1f( i, : ) + Vf;
    end
    PowerPro( i, : ) = ( ThrustReqF( i, : ) .* deltaVf( i, : ) ./ FM );

    % The process to figure out parasite power, propeller power
    %PowerPra( i, : ) = 0.5 * AirDensity * Sref1 * CD1 .*  Vf.^3  ;
    PowerPra( i, : ) = DragParasi( i, : ) .* Vf;
    PowerReq( i, : ) = PowerPro( i, : ) + PowerPra( i, : );
    PowerExc( i, : ) = PowerAva - PowerReq( i, : );
    PowerOpr( i, : ) = Vf ./ PowerReq( i, : );
    
    if( PowerExc( i, 1 ) <= 0 )
        OPTFW( i, 1 ) = 0;
        OPRFW( i, 1 ) = 0;
        MAXFW( i, 1 ) = 0;
    else
        % Seek the value and the address of minimum power required, where the
        % PowerAmp is the value and PowerLoc is the address. Using the address to
        % compare where the corresponding velocity is.
        [ PowerAmp( i, 1 ) PowerLoc( i, 1 ) ] = min( PowerReq( i, : ) );
        [ OprvfAmp( i, 1 ) OprvfLoc( i, 1 ) ] = max( PowerOpr( i, : ) );
        
        % Seek the valus and address for excess power.
        [ MaxrcAmp( i, 1 ) MaxrcLoc( i, 1 ) ] = min( abs( PowerExc( i, : ) ) );
        
        % The final answer for quadrotor perforamce parameters while in forward
        % flight. The detail shows as the following:
        % OPTFW : Optimal forward speed for minimum power.
        % OPRFW : Optimal forward speed for maximum range.
        % PORFW : The value power required.
        % MAXFW : The maximun forward speed.
        % EXCFW : The maximum excess power.
        OPTFW( i, 1 ) = Vf( PowerLoc( i, 1 ) );
        OPRFW( i, 1 ) = Vf( OprvfLoc( i, 1 ) );
        MAXFW( i, 1 ) = Vf( MaxrcLoc( i, 1 ) );
        PORFW( i, 1 ) = PowerAmp( i, 1 );
        POPRFW( i, 1 ) = OprvfAmp( i, 1 );
        EXCFW( i, 1 ) = Power - PowerAmp( i, 1 );
        
    end
    
end

% % Plot the figure
% figure( CounterFig );


% Plot the figure
figure( CounterFig );
CounterFig = CounterFig +1;
plot( Vf, ThrustReqX( CounterGeh, : ), 'g',...
    Vf, ThrustReqY( CounterGeh, : ), 'b',...
    Vf, ThrustReqF( CounterGeh, : ), 'r' );
title( { [ ' Thrust Required in Forward Flight ' ];
    [ ' At ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ] } );
legend( 'X-Axis', 'Y-Axis', 'Required' );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Thrust Required (N) ' );
grid on;


% Plot the figure
figure( CounterFig );
CounterFig = CounterFig +1;
plot( MAXFW, GeoHeight );
title( ' Flight Envolope in Forward Flight ' );
xlabel( ' Maximum Forwrad Speed (m/s) ' );
ylabel( ' Height (m) ' );
grid on


% Plot the figure
figure( CounterFig );
CounterFig = CounterFig +1;
plot( Vf, PowerPra( CounterGeh, : ), 'g',...
    Vf, PowerPro( CounterGeh, : ), 'b',...
    Vf, PowerReq( CounterGeh, : ), 'r',...
    Vf, PowerAva, 'm');
title( { [ ' Power Required in Forward Flight ' ];
    [ ' At ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ] } );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;


% Plot the figure
figure( CounterFig );
CounterFig = CounterFig +1;
plot( Vf, PowerExc( CounterGeh, : ) );
title( { [ ' Excess Power in Forward Flight ' ];
    [ ' At ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ] } );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;


% Plot the figure
figure( CounterFig );
CounterFig = CounterFig +1;
plot( Vf, PowerOpr( CounterGeh, : ) );
title( { [ ' Maximum Range Forward Speed ' ];
    [ ' At ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ] } );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power consuption (m/W)' );
grid on


% % Plot the figure
% figure( CounterFig );
% CounterFig = CounterFig +1;
% plot( Vf, rad2deg( theta( CounterGeh, : ) ) );
% title( ' Pitch Angle in Forward Flight  ' );
% xlabel( ' Forwrad Speed (m/s) ' );
% ylabel( ' Pitch Angle (Deg.) ' );
% grid on

% % Plot the figure
% figure( CounterFig );
% CounterFig = CounterFig +1;
% plot( Vf, PowerPro );
% title( ' Propeller Power Required in Different Height' );
% xlabel( ' Maximum Forwrad Speed (m/s) ' );
% ylabel( ' Power(W) ' );
% grid on

% % Plot the figure
% figure( CounterFig );
% CounterFig = CounterFig +1;
% plot( Vf, theta );
% title( ' Power Required in Different Height' );
% xlabel( ' Maximum Forwrad Speed (m/s) ' );
% ylabel( ' Height (m) ' );
% grid on




disp( [ 'Opt. FW  = ' num2str( round( OPTFW( CounterGeh, 1 ) ) ) ' m/s ' ] )
disp( [ 'Opr. FW  = ' num2str( round( OPRFW( CounterGeh, 1 ) ) ) ' m/s ' ] )
disp( [ 'Min. P.R = ' num2str( round( PORFW( CounterGeh, 1 ) ) ) ' W   ' ] )
disp( [ 'Max. FW  = ' num2str( round( MAXFW( CounterGeh, 1 ) ) ) ' m/s ' ] )

aa = PORFW( CounterGeh, 1 );
bb = OPRFW( CounterGeh, 1 );
cc = POPRFW( CounterGeh, 1 );

% fileID = fopen('forward.dat','w');
% fprintf(fileID,' %12.8 %12.8f \n', Vf' , PowerPro( CounterGeh, : )' );




