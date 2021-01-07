clc; clear all; close all;
%% Sistema de inferencia difuso:
% Dos entradas una salida, el usuario introduce el valor de las entradas y
% obtiene una salida en la grafica.
% La tabla que explica el comportamiento del sistema es:
%     y\x   A1    A2
%     B1    C1    C2
%     B2    C1    C2
%% Definicion de conjuntos:
% Conjunto de entrada x:
x = 20:0.1:30;
A1 = exp(-((x-20)/4).^2/2);
A2 = exp(-((x-30)/3.5).^2/2);
% Conjunto de entrada y:
y = -10:0.1:50;
B1 = exp(-((y+10)/23).^2/2);
B2 = exp(-((y-50)/9).^2/2);
% Conjunto de salida z:
z = 0:0.1:5;
C1 = exp(-((z)/1.5).^2/2);
C2 = exp(-((z-5)/2).^2/2);
%% Grafica de conjuntos:
figure('Name','Conjuntos difusos')
    subplot(1,3,1)
        plot(x,A1,'r',x,A2,'g')
        xlim([20,30])
        xlabel('x')
        ylabel('mu')
        legend('A1','A2',3)
        title('Conjunto X')
    subplot(1,3,2)
        plot(y,B1,'r',y,B2,'g')
        xlim([-10,50])
        xlabel('y')
        ylabel('mu')
        legend('B1','B2',3)
        title('Conjunto Y')
    subplot(1,3,3)
        plot(z,C1,'r',z,C2,'g')
        xlim([0,5])
        xlabel('z')
        ylabel('mu')
        legend('C1','C2',3)
        title('Conjunto Z')
%% Variables de entrada:
x0 = input('Introduce un valor para x: ');
y0 = input('Introduce un valor para y: ');
x0 = round(x0*10)/10;
y0 = round(y0*10)/10;
%% Evaluacion en conjuntos:
A1x0 = A1(x0==x);
A2x0 = A2(x0==x);
B1y0 = B1(y0==y);
B2y0 = B2(y0==y);
%% Reglas (bajo comparacion min-max):
r1 = min(A1x0,B1y0);
r2 = min(A1x0,B2y0);
r3 = min(A2x0,B1y0);
r4 = min(A2x0,B2y0);
C1z0 = max(r1,r2);
C2z0 = max(r3,r4);
%% Obtencion de conjuntos cortados en proyeccion y conjuncion:
C1c = C1.*(C1<=C1z0) + C1z0*(C1>C1z0);
C2c = C2.*(C2<=C2z0) + C2z0*(C2>C2z0);
Cc = max(C1c,C2c);
%% Defusificacion:
z0 = sum(Cc.*z)/sum(Cc);
disp(['El valor de salida es: z = ',num2str(z0)])
%% Grafica de resultados:
figure('Name','Defusificacion')
    plot(z,C1,'k--',z,C2,'k--',[z0,z0],[0,1],'r')
    hold on
    plot(z,Cc,'b','LineWidth',3)
    xlabel('z')
    ylabel('mu')
    legend('C1','C2','Valor','Defuzzy',3)
    title(['z = ',num2str(z0)])
%% Proyecciones de conjuntos:
xl = length(x);
yl = length(y);
A1p = ones(1,yl)'*A1;
A2p = ones(1,yl)'*A2;
B1p = (ones(1,xl)'*B1)';
B2p = (ones(1,xl)'*B2)';
%% Reglas (bajo comparacion min-max):
R1 = min(A1p,B1p);
R2 = min(A1p,B2p);
R3 = min(A2p,B1p);
R4 = min(A2p,B2p);
C1p = max(R1,R2);
C2p = max(R3,R4);
%% Obtencion de conjuntos cortados en proyeccion y conjuncion:
[a,b] = size(C1p);
Z = zeros(a,b);
for i = 1:a
    for j = 1:b
        C1c = C1.*(C1<=C1p(i,j)) + C1p(1,j).*(C1>C1p(i,j)); % Corte C1
        C2c = C2.*(C2<=C2p(i,j)) + C2p(i,j).*(C2>C2p(i,j)); % Corte C2
        Cc = max(C1c,C2c); % Conjuncion de cortes
        Z(i,j) = sum(Cc.*z)/sum(Cc); % Defusificacion
    end
end
%% Grafica de superficie:
figure('Name','Superficie difusa')
    [X,Y] = meshgrid(x,y);
    mesh(X,Y,Z)
    xlim([20,30])
    ylim([-10,50])
    zlim([0,5])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title('Superficie difusa')