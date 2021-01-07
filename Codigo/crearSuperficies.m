function [ superficies, cortes ] = crearSuperficies( entradas, salidas )
%% Crea las superficies de control:
%   Utiliza las reglas establecidas para cada salida.
%   entradas:= es una celda con los conjuntos y su rango = {Conjunto,rango}
%   salidas:= es una celda con los conjuntos de salida, rango y reglas
%       {Conjunto,rango,reglas}
%   cada fila de entradas y salidas es una variable diferente del sistema.
%   superficies es una celda de una columna con los valores de la respuesta
%   La matriz de reglas tiene n filas donde n es el numero de conjuntos en
%   la primer variable, m columnas donde m es el numero de conjuntos en la
%   segunda variable, (solo funciona para 2 variables de entrada)
%   El programa supone en las reglas que 1 es el primer conjunto difuso de
%   la salida y 2 el segundo etc...
%   El programa supone que todas las variables tienen una correcta sintaxis
%   y son posibles
%% Programa:
    % Inicio de variables y lectura de datos:
    c = zeros(1,2);
    l = zeros(1,2);
    for i = 1:2
        c(i) = size(entradas{i,1},1); % numero de conjuntos de las entradas
        l(i) = size(entradas{i,2},2); % tamano de rangos de las entradas
    end
    % Proyecciones bidimensionales de conjuntos de primer variable:
    A = cell(1,c(1));
    for i = 1:c(1)
        A{i} = ones(l(2),1)*entradas{1,1}(i,:);
    end
    % Proyecciones bidimensionales de conjuntos de segunda variable:
    B = cell(1,c(2));
    for i = 1:c(2)
        B{i} = entradas{2,1}(i,:)'*ones(1,l(1));
    end
    % Minimos de proyecciones:
    minimos = cell(c(1),c(2));
    for i = 1:c(1)
        for j = 1:c(2)
            minimos{i,j} = min(A{i},B{j});
        end
    end
    % Obtener superficies por cada variable de salida:
    n_s = size(salidas,1); % Numero de variables de salida
    superficies = cell(n_s,1);
    cortes = cell(n_s,1);
    for i = 1:n_s
        c_s = size(salidas{i,1},1); % Numero de conjuntos de salida
        % Obtener maximo segun reglas de esta variable:
        maximos = cell(1,c_s);
        for j = 1:c_s
            indices = find(salidas{i,3}==j);
            maximos{j} = minimos{indices(1)};
            for k = 2:length(indices)
                maximos{j} = max(maximos{j},minimos{indices(k)});
            end
        end
        superficies{i} = zeros(l(2),l(1));
        cortes{i} = cell(l(2),l(1));
        for k1 = 1:l(2)
            for k2 = 1:l(1)
                C = cell(1,c_s);
                for j = 1:c_s
                    C{j} = salidas{i,1}(j,:).*(salidas{i,1}(j,:)<=maximos{j}(k1,k2)) + maximos{j}(k1,k2).*(salidas{i,1}(j,:)>maximos{j}(k1,k2)); % Terminar
                end
                cortes{i}{k1,k2} = C{1};
                for k = 2:c_s
                    cortes{i}{k1,k2} = max(cortes{i}{k1,k2},C{k});
                end
                superficies{i}(k1,k2) = sum(cortes{i}{k1,k2}.*salidas{i,2})/sum(cortes{i}{k1,k2});                    
            end
        end
    end
end