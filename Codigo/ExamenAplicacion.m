clc; clear all; close all;
%% Lee las variables e imagenes a utilizar:
load S1; 
load S2; 
load carros; 
load pista;
%% Encabezado:
disp('*******************************************************************')
disp('                         EXAMEN NEURODIFUSO                        ')
disp('*******************************************************************')
disp('Control de trafico a partir de sistema de inferencia difuso de tipo')
disp('Mamdami y sensores de proximidad laterales y frontales')
%% Presenta las pistas disponibles:
fig1 = figure('Name','Pista');
for i = 1:9
    subplot(3,3,i)
        imshow(pista{i})
        title(['Pista ',num2str(i)])
end
%% Muestra los carros disponibles:
fig2 = figure('Name','Carros');
for i = 1:6
    subplot(2,3,i)
    imshow(carros{i,1})
    title(['Carro ',num2str(i)])
end
%% Elige numero de pista:
disp('*******************************************************************')
p = input('Selecciona la pista a utilizar (1-9): ');
    % Verifica si el numero de pista seleccionado es valido
    p = round(p); 
    if p<1; p=1; end
    if p>9; p=9; end
%% Selecciona posiciones de carros:
disp('*******************************************************************')
disp('Ubica con un click donde ira cada carro. Un doble click coloca el ')
disp('ultimo carro. Se pueden colorar como m?ximo 6 carros.')
figure(fig1), % Selecciona figura previamente usada.
    subplot(1,1,1) 
        imshow(pista{p}), 
        title('Ubica los carros con un click sobre areas blancas.')
        [a,b,c] = impixel; % Permite obtener la poscion del click
n = length(a); 
    if n>6; n = 6; end; % Verifica numero de carros valido
%% Muestra imagen con posiciones de los carros:
figure(fig1), imshow(pista{p}), title('Posiciones de los carros'), hold on;
for i = 1:n; plot(a(i),b(i),'r*'); end; hold off;
%% Selecciona la orientacion que tendran los carros y los coloca:
disp('*******************************************************************')
disp('Selecciona la orientacion para los carritos:')
disp('     1.- Izquierda')
disp('     2.- Diagonal Izquierda-Arriba')
disp('     3.- Arriba')
disp('     4.- Diagonal Arriba-Derecha')
disp('     5.- Derecha')
disp('     6.- Diagonal Derecha-Abajo')
disp('     7.- Abajo')
disp('     8.- Diagonal Abajo-Izquierda')
disp('*******************************************************************')
% Inicia variables:
orientacion = zeros(1,n);
bordes = cell(1,n);
visible = pista{p};
% Coloca cada uno de los carros:
for i = 1:n
    % Obtiene orientacion:
    orientacion(i) = input(['Orientacion para carro ',num2str(i),': ']);
        % Verifica valor valido para orientacion de carro:
        orientacion(i) = round(orientacion(i));
        if orientacion(i)<1; orientacion(i)=1; end
        if orientacion(i)>8; orientacion(i)=8; end
    % Obtiene caja de los bordes donde se contiene la imagen:
    if (orientacion(i)==1||orientacion(i)==5) % Derecha e izquierda
        bordes{i} = [b(i)-9,b(i)+10,a(i)-19,a(i)+20];
    elseif (orientacion(i)==3||orientacion(i)==7) % Arriba y abajo:
        bordes{i} = [b(i)-19,b(i)+20,a(i)-9,a(i)+10];
    else
        bordes{i} = [b(i)-19,b(i)+20,a(i)-19,a(i)+20]; % Diagonales
    end
    % Coloca carros en la pista:
    visible(bordes{i}(1):bordes{i}(2),bordes{i}(3):bordes{i}(4),:) ...
        = carros{i,orientacion(i)};
    switch orientacion(i)
        case 2
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:);
          end
          for j = 1:24
            visible(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:);
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 4
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(4)-8+j:bordes{i}(4),:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(4)-8+j:bordes{i}(4),:);
          end
          for j = 1:24
            visible(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:) ...
             = pista{p}(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:);
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 6
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:);
          end
          for j = 1:24
            visible(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:);
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 8
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:);
          end
          for j = 1:24
            visible(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:);
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
    end
    % Muestra en pantalla el carro posicionado y lugares restantes:
    imshow(visible), title('Posiciones de los carros'), hold on;
    for j = i+1:n; plot(a(j),b(j),'r*'); end; hold off;
end
%% Sistema de control de transito:
while(1) % Siempre operando
    for i = 1:n % Para cada carro
        % Lee nuevos valores del entorno:
        [va,vl,der,izq,r] = ...
            leerEntorno(visible(bordes{i}(1)-60:bordes{i}(2)+60,...
            bordes{i}(3)-60:bordes{i}(4)+60,:),orientacion(i));
        % Borra carro de la pista:
        visible(bordes{i}(1):bordes{i}(2),bordes{i}(3):bordes{i}(4),:) ...
            = pista{p}(bordes{i}(1):bordes{i}(2),bordes{i}(3):...
            bordes{i}(4),:);
        % Actualiza bordes y orientacion del carro:
        u = 5; % Factor de giro
        switch orientacion(i)
            case 1
                bordes{i}(1) = bordes{i}(1)-S2(vl,va);
                bordes{i}(2) = bordes{i}(2)-S2(vl,va);
                bordes{i}(3) = bordes{i}(3)-S1(vl,va);
                bordes{i}(4) = bordes{i}(4)-S1(vl,va);
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 2;
                    bordes{i}(1) = bordes{i}(1)-20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 8;
                    bordes{i}(2) = bordes{i}(2)+20;
                end
            case 2
                bordes{i}(1) = bordes{i}(1)-S1(vl,va);
                bordes{i}(2) = bordes{i}(2)-S1(vl,va);
                bordes{i}(3) = bordes{i}(3)-S1(vl,va);
                bordes{i}(4) = bordes{i}(4)-S1(vl,va);
                if S2(vl,va)>0
                    bordes{i}(1) = bordes{i}(1)-S2(vl,va);
                    bordes{i}(2) = bordes{i}(2)-S2(vl,va);
                else
                    bordes{i}(3) = bordes{i}(3)+S2(vl,va);
                    bordes{i}(4) = bordes{i}(4)+S2(vl,va);
                end
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 3;
                    bordes{i}(3) = bordes{i}(3)+20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 1;
                    bordes{i}(1) = bordes{i}(1)+20;
                end
            case 3
                bordes{i}(1) = bordes{i}(1)-S1(vl,va);
                bordes{i}(2) = bordes{i}(2)-S1(vl,va);
                bordes{i}(3) = bordes{i}(3)+S2(vl,va);
                bordes{i}(4) = bordes{i}(4)+S2(vl,va);
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 4;
                    bordes{i}(4) = bordes{i}(4)+20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 2;
                    bordes{i}(3) = bordes{i}(3)-20;
                end
            case 4
                bordes{i}(1) = bordes{i}(1)-S1(vl,va);
                bordes{i}(2) = bordes{i}(2)-S1(vl,va);
                bordes{i}(3) = bordes{i}(3)+S1(vl,va);
                bordes{i}(4) = bordes{i}(4)+S1(vl,va);
                if S2(vl,va)>0
                    bordes{i}(3) = bordes{i}(3)+S2(vl,va);
                    bordes{i}(4) = bordes{i}(4)+S2(vl,va);
                else
                    bordes{i}(1) = bordes{i}(1)+S2(vl,va);
                    bordes{i}(2) = bordes{i}(2)+S2(vl,va);
                end
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 5;
                    bordes{i}(1) = bordes{i}(1)+20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 3;
                    bordes{i}(4) = bordes{i}(4)-20;
                end
            case 5
                bordes{i}(1) = bordes{i}(1)+S2(vl,va);
                bordes{i}(2) = bordes{i}(2)+S2(vl,va);
                bordes{i}(3) = bordes{i}(3)+S1(vl,va);
                bordes{i}(4) = bordes{i}(4)+S1(vl,va);
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 6;
                    bordes{i}(2) = bordes{i}(2)+20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 4;
                    bordes{i}(1) = bordes{i}(1)-20;
                end
            case 6
                bordes{i}(1) = bordes{i}(1)+S1(vl,va);
                bordes{i}(2) = bordes{i}(2)+S1(vl,va);
                bordes{i}(3) = bordes{i}(3)+S1(vl,va);
                bordes{i}(4) = bordes{i}(4)+S1(vl,va);
                if S2(vl,va)>0
                    bordes{i}(1) = bordes{i}(1)+S2(vl,va);
                    bordes{i}(2) = bordes{i}(2)+S2(vl,va);
                else
                    bordes{i}(3) = bordes{i}(3)-S2(vl,va);
                    bordes{i}(4) = bordes{i}(4)-S2(vl,va);
                end
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 7;
                    bordes{i}(4) = bordes{i}(4)-20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 5;
                    bordes{i}(2) = bordes{i}(2)-20;
                end
            case 7
                bordes{i}(1) = bordes{i}(1)+S1(vl,va);
                bordes{i}(2) = bordes{i}(2)+S1(vl,va);
                bordes{i}(3) = bordes{i}(3)-S2(vl,va);
                bordes{i}(4) = bordes{i}(4)-S2(vl,va);
                if der && (S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 8;
                    bordes{i}(3) = bordes{i}(3)-20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 6;
                    bordes{i}(4) = bordes{i}(4)+20;
                end
            case 8
                bordes{i}(1) = bordes{i}(1)+S1(vl,va);
                bordes{i}(2) = bordes{i}(2)+S1(vl,va);
                bordes{i}(3) = bordes{i}(3)-S1(vl,va);
                bordes{i}(4) = bordes{i}(4)-S1(vl,va);
                if S2(vl,va)>0
                    bordes{i}(3) = bordes{i}(3)-S2(vl,va);
                    bordes{i}(4) = bordes{i}(4)-S2(vl,va);
                else
                    bordes{i}(1) = bordes{i}(1)-S2(vl,va);
                    bordes{i}(2) = bordes{i}(2)-S2(vl,va);
                end
                if der &&(S2(vl,va)>=u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 1;
                    bordes{i}(2) = bordes{i}(2)-20;
                elseif izq && (S2(vl,va)<=-u||S2(vl,va)==0&&S1(vl,va)==0)
                    orientacion(i) = 7;
                    bordes{i}(3) = bordes{i}(3)+20;
                end
        end
        % Coloca carro actualizado en la pista:
        visible(bordes{i}(1):bordes{i}(2),bordes{i}(3):bordes{i}(4),:) ...
            = carros{i,orientacion(i)};
        switch orientacion(i)
        case 2
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:);
          end
          for j = 1:24
            visible(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:);
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 4
          for j = 1:8
            visible(bordes{i}(1)+j-1,bordes{i}(4)-8+j:bordes{i}(4),:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(4)-8+j:bordes{i}(4),:);
          end
          for j = 1:24
            visible(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:) ...
             = pista{p}(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:);
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 6
          for j = 1:8
            visible(bordes{i}(2)-j+1,bordes{i}(4)-8+j:bordes{i}(4),:) ...
              = pista{p}(bordes{i}(2)-j+1,bordes{i}(4)-8+j:bordes{i}(4),:);
          end
          for j = 1:24
            visible(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3)+15+j:bordes{i}(4),:);
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        case 8
          for j = 1:8
            visible(bordes{i}(2)-j+1,bordes{i}(3):bordes{i}(3)+8-j,:) ...
              = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+8-j,:);
          end
          for j = 1:24
            visible(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:) ...
             = pista{p}(bordes{i}(2)-24+j:bordes{i}(2),bordes{i}(4)+1-j,:);
            visible(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:) ...
             = pista{p}(bordes{i}(1)+j-1,bordes{i}(3):bordes{i}(3)+24-j,:);
          end
        end
        % Muestra en pantalla la actualizacion de posicion:
        figure(fig1)
            imshow(visible)
        % Muestra en pantalla carracteristicas del carro:
        figure(fig2)
          subplot(2,3,i)
            imshow(r)
            title(['Carro ',num2str(i)])
            xlabel(['pixel: ',num2str(va),', vel: ',num2str(S1(vl,va))])
            ylabel(['pixel: ',num2str(vl-31),', vel: ',num2str(S2(vl,va))])
%             xlabel(['der: ',num2str(der),', izq: ',num2str(izq)])
    end
    pause(0.05)
end