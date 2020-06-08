% pp_CalculaMM: programa principal (pp_) de Ejemplo de CalculaMM.
% jorge.ruizcruz@uam.es
% $Revision: 0.0 $  $Date: 2014/11/30 12:00:00 $
%================================================

%% Ejemplo 1: filtro a 11 GHz de 300 MHz de banda de orden 4
f = linspace(8e9, 12e9, 5001);
% 


%% Ejemplo 2: Calculo del inversor asociado a un iris

% Datos Usuario
a0 = 22.86 ; 
t = 2 ;  % grosor del iris
b0_mm = 10.16 ; 
lref = 0 ;
w = 10.499 ; % anchura del iris
f0d = 11 ; % frecuencia a la que se quiere ver el inversor equivalente
vfrec_GHz = linspace( 8 , 13 , 201); % vector de frecuencias del barrido

% Ejecucion
va_mm = [a0,w,a0];  % anchura guias 
vd_mm = [lref,t,lref];  % longitud guias    
pintaPerfil( va_mm , vd_mm  );
[ vS11 , vS21 , vS22 ] = calculaMM( vfrec_GHz , va_mm , vd_mm , b0_mm ) ;

% Representacion
hfig1 = figure;
hp = plot( vfrec_GHz , dB( vS11 ),'c', vfrec_GHz , dB( vS21 ), 'm' , 'Linewidth' , 2 ); grid on;
legend( hp, {'S_{11}','S_{21}'});
xlabel('Frecuencia (GHz)')
ylabel('|S_{ij}| (dB)')

% Inversor equivalente a la frecuencia calculada más cercana a la elegida
[~,indf0c] = min( abs( vfrec_GHz - f0d ));
f0c = vfrec_GHz(indf0c);
S11c = vS11( indf0c ) ;
K_equiv_nor = sqrt( ( 1 - abs(S11c) )/(1 + abs(S11c) ) ) ;
theta_equiv_rad = -angle(S11c)/2 + pi/2 ;
disp( sprintf('K=%4.4f y theta=%3.4f (rad) para f0c=%3.4f (GHz) (con a=%4.4f mm,t=%4.4f mm)' , K_equiv_nor , theta_equiv_rad , f0c , a0 , t  ));

% Variacion con la frecuencia del inversor
vK_equiv_nor = sqrt( ( 1 - abs(vS11) )./(1 + abs(vS11) ) );
vtheta_equiv_rad = -angle(vS11)/2 + pi/2 ;

% Representacion
hfig2 = figure;
subplot(2,1,1);
hp = plot( vfrec_GHz , vK_equiv_nor , 'r' , 'Linewidth' , 2 ); grid on;
xlabel('Frecuencia (GHz)')
ylabel(' K/Z_c (Inversor normalizado.)');
title(' Inversor normalizado del cto. equivalente formado por linea+inv+linea');
vline( f0c ); hline( K_equiv_nor );

subplot(2,1,2);
hp = plot( vfrec_GHz , vtheta_equiv_rad*180/pi , 'c' , 'Linewidth' , 2 ); grid on;
xlabel('Frecuencia (GHz)')
ylabel(' \theta (º) (longitud eléct.)')
title(' Longitud eléct. de la línea a cada lado del inversor')
vline( f0c ); hline( theta_equiv_rad*180/pi );




%% Ejemplo 3: Creacion Tabla de inversores a un frecuencia de diseño (tipicamente la central del filtro)

% Datos Usuario
a0 = 19.05 ; 
t = 1.5 ;  % grosor del iris
b0_mm = 9.525 ; 
lref = 0;
vw = linspace( 1 , 12 ,  251 ) ; % anchura del iris
f0d = 10 ; % frecuencia a la que se quiere hacer la tabla de inversores 

% Bucle para las distintas anchuras
Nw = numel(vw); % numero de puntos de la tabla (numero de anchuras)
vK_equiv_nor = nan(1,Nw);
vtheta_equiv_rad = nan(1,Nw);
for ii = 1 : numel(vw)
    w = vw(ii);
    va_mm = [a0,w,a0];  % anchura guias 
    vd_mm = [lref,t,lref];  % longitud guias    
    vfrec_GHz = f0d ;
    [ vS11 , vS21 , vS22 ] = calculaMM( vfrec_GHz , va_mm , vd_mm , b0_mm ) ;

    S11c = vS11 ;
    vK_equiv_nor(ii) = sqrt( ( 1 - abs(S11c) )/(1 + abs(S11c) ) ) ;
    vtheta_equiv_rad(ii) = -angle(S11c)/2 + pi/2 ;
end

% Representacion
hfig = figure;
subplot(2,1,1);
hp = plot( vw , vK_equiv_nor , 'r' , 'Linewidth' , 2 ); grid on;
xlabel('Anchura Iris (mm)')
ylabel(' K/Z_c (Inversor normalizado)');
title(' Inversor normalizado del cto. equivalente formado por linea+inv+linea');

subplot(2,1,2);
hp = plot( vw , vtheta_equiv_rad*180/pi  , 'c'  , 'Linewidth' , 2 ); grid on;
xlabel('Anchura Iris (mm)')
ylabel(' \theta (º) (longitud eléctrica en grados)')
title(' Longitud eléct. de la línea a cada lado del inversor')

% Buscar en la tabla un valor determinado
Kdis = 0.440224314012003; 
Kdis = 0.158869636351927; 
Kdis = 0.120271765194624; 
% Kdis = 0.115351231083418; 
% Kdis = 0.166580420176928; 
% Kdis = 0.467767299357704; 
[~,indKdis] = min( abs( vK_equiv_nor - Kdis ));
disp( sprintf('Kdis=%4.4f ; K=%4.4f y theta=%3.4f rad para w=%3.4f mm (en f0d=%4.4f GHz,a=%4.4f mm,t=%4.4f mm)' , Kdis , vK_equiv_nor(indKdis) , vtheta_equiv_rad(indKdis) , vw(indKdis) , f0d , a0 , t ) );
subplot(2,1,1);hline( vK_equiv_nor(indKdis) ); vline( vw(indKdis) );
subplot(2,1,2);hline(  vtheta_equiv_rad(indKdis)*180/pi  );  vline( vw(indKdis) );

