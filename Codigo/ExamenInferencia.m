clc; clear all; close all;
%% Sistema de inferencia difuso:
% Dos entradas dos salidas, el usuario introduce el valor de las entradas 
% y obtiene las salidas en la grafica.
%% Conjuntos de entrada:
visiona = 1:60;
parametrosa = [6,1;3,10;7.5,25;7.5,40;10,60];
adelante = crearConjuntos('gausiano',parametrosa,visiona);
visionl = -30:30;
parametrosl = [10,-30;6,-14;5,0;6,14;10,30];
lateral = crearConjuntos('gausiano',parametrosl,visionl);
entradas = {adelante,visiona;lateral,visionl};
%% Conjuntos de salida:
velav = 0:0.1:10;
parametrosav = [1,0;1.5,3;1.5,6;2,10];
avance = crearConjuntos('gausiano',parametrosav,velav);
avanceR = [1,2,2,3,4;1,2,3,3,4;1,2,3,4,4;1,2,3,3,4;1,2,2,3,4]';
velgiro = -10:0.1:10;
parametrosgiro = [2.5,-10;2,-4.5;1.5,0;2,4.5;2.5,10];
giro = crearConjuntos('gausiano',parametrosgiro,velgiro);
giroR = [1,1,1,1,2;1,2,2,2,3;3,3,3,3,3;5,4,4,4,3;5,5,5,5,4]';
salidas = {avance,velav,avanceR;giro,velgiro,giroR};
%% Crear superficies de control:
[superficies,cortes] = crearSuperficies(entradas,salidas);
%% Graficas:
superficies{3} = round(10*( ( superficies{1}-min(min(superficies{1})) )/max(max(superficies{1})) ) );
superficies{4} = round(10*( superficies{2}/max(max(superficies{2})) ) );
[xg,yg] = meshgrid(visiona,visionl);
figure('Name','Superficies difusas')
for i = 1:4    
    subplot(2,2,i)
    surf(xg,yg,superficies{i},'EdgeColor','None')
    xlim([1,60])
    ylim([-30,30])
    xlabel('Adelante (pixel)')
    ylabel('Lateral (pixel)')
    switch i
        case 1
            zlim([0,10])
            zlabel('pixel por decisegundo')
            title('Avance')
        case 2
            zlim([-10,10])
            title('Giro')
            zlabel('pixel por decisegundo')
        case 3
            zlim([0,10])
            zlabel('pixel por decisegundo')
            title('Avance ajustado')
        case 4
            zlim([-10,10])
            zlabel('pixel por decisegundo')
            title('Giro ajustado')
    end
end
S1 = superficies{3};
S2 = superficies{4};
save S1;
save S2;