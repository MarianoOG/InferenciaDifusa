function [ pista ] = crearPista( pieza, giro )
%% Crea imagenes de la pista de carreras:
% Funcion que crea una imagen correspondiente a la pista donde podran
% moverse los automoviles
%   pieza := es una matriz con el numero de pieza que se eligio para ese 
%           tramo
%   giro := es una matriz con cuantas veces deber? rotarse en 90? ese tramo
%   pista := es la imagen final.
%% Programa:
    % Asegurar valores posibles:
    pieza = round(pieza);
    pieza(pieza<1) = 1;
    pieza(pieza>8) = 8;
    giro = mod(round(giro),4);
    % Lee imagenes:
    p = cell(1,8);
    for i = 1:8
        p{i} = rgb2gray(imread(['Imagenes/p',num2str(i),'.bmp']))~=0;
    end
    % Genera pista:
    [a,b] = size(pieza);
    pista = false(a*200+200,b*200+200);
    for i = 1:a
        for j = 1:b
            temp = p{pieza(i,j)};
            for k = 1:giro(i,j)
                temp = rot90(temp);
            end
            pista(i*200-99:i*200+100,j*200-99:j*200+100) = temp;
        end
    end
    temp = uint8(pista*255);
    pista = temp;
    pista(:,:,2) = temp;
    pista(:,:,3) = temp;
end