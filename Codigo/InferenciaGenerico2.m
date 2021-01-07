clc; clear all; close all;
%% Sistema de inferencia difuso:
% Dos entradas una salida, el usuario introduce el valor de las entradas y
% obtiene una salida en la grafica.
% La tabla que explica el comportamiento del sistema es:
%     x\y   B1    B2
%     A1    C1    C1
%     A2    C2    C2
%% Conjuntos de entrada:
x = 20:0.1:30;
X = crearConjuntos('gausiano',[4,20;3.5,30],x);
y = -10:0.1:50;
Y = crearConjuntos('gausiano',[23,-10;9,50],y);
entradas = {X,x;Y,y};
%% Conjuntos de salida:
z = 0:0.1:5;
Z = crearConjuntos('gausiano',[1.5,0;2,5],z);
Zreglas = [1,1;2,2];
salidas = {Z,z,Zreglas};
%% Crear superficies de control y graficarlas:
[superficies,cortes] = crearSuperficies(entradas,salidas);
[xg,yg] = meshgrid(x,y);
figure('Name','Superficie difusa')
    mesh(xg,yg,superficies{1})
    xlim([20,30])
    ylim([-10,50])
    zlim([0,5])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title('Superficie difusa')
%% Pedir valor al usuario y graficarlo:
x0 = input('Introduce un valor para x: ');
y0 = input('Introduce un valor para y: ');
x0 = round(x0*10)/10;
y0 = round(y0*10)/10;
a = find(x==x0);
b = find(y==y0);
z0 = superficies{1}(b,a);
disp(['El valor de salida es: z = ',num2str(z0)])
Cc = cortes{1}{b,a};
figure('Name','Defusificacion')
    plot(z,Z,'--',[z0,z0],[0,1],'r')
    hold on
    plot(z,Cc,'b','LineWidth',3)
    xlabel('z')
    ylabel('mu')
    legend('C1','C2','Valor','Corte',3)
    title(['z = ',num2str(z0)])