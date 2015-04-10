clear; clc
m= 1.5;
T = linspace( 15, 7.5, 4 );
V = linspace( 0.5, 15.5, 10 );
for i = 1: 1: length( T )
    R( i, : ) = m.*(V.^2)./T( 1, i ) ;
end
plot( V, R );
grid on