clc; clear all; close all;
%% Sistema de inferencia difuso:
% Dos entradas dos salidas, el usuario introduce el valor de las entradas 
% y obtiene las salidas en la grafica.
%% Conjuntos de entrada:
grados = 0:359;
p = [-15,-10,25,55;35,65,115,145;125,155,205,235;215,245,295,325;...
    305,335,368,400];
C = crearConjuntos('trapezoidal',p,grados);
entradas = {C,grados;C,grados};
%% Conjuntos de salida:
revoluciones = 0:4:1200;
p2 = [-10,-5,200,350;250,500,700,950;850,1000,1300,1400];
velocidad = crearConjuntos('trapezoidal',p2,revoluciones);
velR = [1,2,3,2,1;2,1,2,3,2;3,2,1,2,3;2,3,2,1,2;1,2,3,2,1];
voltaje = 0:0.01:5;
p3 = [-2,-1,1,2;1.5,2.25,2.75,3.5;3,4,6,7];
giro = crearConjuntos('trapezoidal',p3,voltaje);
giroR = [2,1,3,3,2;3,2,1,3,3;1,3,2,1,3;1,1,3,2,1;2,1,1,3,2];
salidas = {velocidad,revoluciones,velR;giro,voltaje,giroR};
%% Crear superficies de control y graficarlas:
[superficies,cortes] = crearSuperficies(entradas,salidas);
[xg,yg] = meshgrid(grados,grados);
for i = 1:2
    figure('Name','Superficie difusa')
        mesh(xg,yg,superficies{i})
        xlim([0,259])
        ylim([0,259])
        xlabel('veleta (grados)')
        ylabel('generador (grados)')
        if i == 1
            zlim([0,1200])
            zlabel('Revoluciones por minuto')
            title('Velocidad')
        else
            zlim([0,5])
            zlabel('Sentido')
            title('Giro')
        end
end
%% Pedir valor al usuario y graficarlo:
x0 = input('Introduce un valor para veleta: ');
y0 = input('Introduce un valor para generador: ');
x0 = round(x0);
y0 = round(y0);
a = find(grados==x0);
b = find(grados==y0);
% Velocidad
z0 = superficies{1}(b,a);
Cc = cortes{1}{b,a};
disp(['La velocidad es: ',num2str(z0),' RPM'])
figure('Name','Defusificacion')
    plot(revoluciones,velocidad,'--',[z0,z0],[0,1],'r')
    hold on
    plot(revoluciones,Cc,'b','LineWidth',3)
    xlabel('velocidad')
    ylabel('mu')
    legend('Baja','Media','Alta','Valor','Corte',3)
    title(['Velocidad = ',num2str(z0)])
% Giro
z0 = superficies{2}(b,a);
Cc = cortes{2}{b,a};
disp(['El sentido es: ',num2str(z0)])
figure('Name','Defusificacion')
    plot(voltaje,giro,'--',[z0,z0],[0,1],'r')
    hold on
    plot(voltaje,Cc,'b','LineWidth',3)
    xlabel('voltaje')
    ylabel('mu')
    legend('Horario','Sin movimiento','Antihorario','Valor','Corte',3)
    title(['Giro = ',num2str(z0)])