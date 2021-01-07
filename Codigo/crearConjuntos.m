function [ S ] = crearConjuntos( tipo, param, v )
%% Crea los conjuntos difusos con los que se trabajara:
%   tipo:= es el tipo de conjunto que se creara
%   param:= son los parametros que necesita cada una de las curvas,
%       Su numero de filas determina el numero de conjuntos que habr?
%       El numero de columnas corresponde al numero de parametros
%   v es el vector de dominio donde se define la curva
%% Programa:
    [a,b] = size(param);
    l = length(v);
    S = zeros(a,l);
    if (strcmp(tipo,'gausiano') && b==2)
        % param = [varianza, media]
        for i = 1:a
            S(i,:) = exp(-((v-param(i,2))/param(i,1)).^2/2);
        end
    elseif (strcmp(tipo,'trapezoidal') && b==4) 
        % param = [inicio subida, final subida, inicio bajada, fin bajada]
        for i = 1:a
            temp1 = ( v-param(i,1) ) / ( param(i,2)-param(i,1) );
            temp1 = temp1.*and(v>param(i,1),v<=param(i,2));
            temp2 = and(v > param(i,2),v <= param(i,3));
            temp3 = ( param(i,4)-v ) / ( param(i,4)-param(i,3) );
            temp3 = temp3.* and(v>param(i,3),v<=param(i,4));
            S(i,:) = temp1 + temp2 + temp3;
        end
    else
        disp('No fue posible crear los conjuntos difusos')
        S = [];
    end
end