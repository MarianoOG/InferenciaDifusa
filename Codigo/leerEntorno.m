function [ va, vl, der, izq, r ] = leerEntorno( region, orientacion )
%% Lee el entorno y regresa las variables de control
% Obtiene la distancia a la que se encuentra un objeto hacia adelante del 
% carrito y una diferencia entre el objeto mas proximo a la derecha y el
% mas proximo a la izquierda del carrito.
%   region := es el area son los pixel del carrito y su vecindad.
%   orientacion := es como esta acomodado el carrito
%% Programa:
    r = rgb2gray(region);
    if (sum(orientacion==[5,4])~=0)
        r = rot90(r);
    elseif (sum(orientacion==[7,6])~=0)
        r = rot90(rot90(r));
    elseif (sum(orientacion==[1,8])~=0)
        r = rot90(rot90(rot90(r)));
    end
    der = true;
    izq = true;
    r2 = r;
    if (sum(orientacion==[1,3,5,7])~=0)
        temp = 255;
        for i = 1:20
            temp = min(min(r(61:94-i,80+i)),temp);
        end
        if temp<250; der = false; end
        temp = 255;
        for i = 1:20
            temp = min(min(r(61:75+i,40+i)),temp);
        end
        if temp<250; izq = false; end
        visiona = max(r(1:60,61:80),[],2);
        r(1:60,61:80) = r(1:60,61:80)+100;
        r(1:60,61:80) = r(1:60,61:80)-50;
        va = 60;
        for i = 60:-1:1
            if visiona(i) < 250; 
                va = 61-i; 
                break; 
            end
        end
        visionli = min(r(41:100,31:60),[],1);
        visionld = min(r(41:100,81:110),[],1);
        r(41:100,31:60) = r(41:100,31:60)+200;
        r(41:100,31:60) = r(41:100,31:60)-100;
        r(41:100,81:110) = r(41:100,81:110)+200;
        r(41:100,81:110) = r(41:100,81:110)-100;
        vli = 30;
        for i = 1:30
            if visionli(31-i) < 250
                vli = i;
                break
            end
        end
        vld = 30;
        for i = 1:30
            if visionld(i) < 250
                vld = i;
                break;
            end
        end
        vl = vld - vli;
    else
        temp = 255;
        for i = 1:24
            temp = min(min(r(76+i,61:60+i)),temp);
        end
        if temp<250; der = false; end
        temp = 255;
        for i = 1:24
            temp = min(min(r(60+i,76+i:100)),temp);
        end
        if temp<250; izq = false; end
        va = 58;
        for i = 1:58
            visiona = 255;
            for j = 1:14
                visiona = min(r(58+j-i,73-j-i),visiona);
                r(58+j-i,73-j-i) = r(58+j-i,73-j-i) + 100;
                r(58+j-i,73-j-i) = r(58+j-i,73-j-i) - 50;
                if j~=14
                    visiona = min(r(58+j+i,72-j-i),visiona);
                    r(58+j-i,72-j-i) = r(58+j-i,72-j-i) + 100;
                    r(58+j-i,72-j-i) = r(58+j-i,72-j-i) - 50;
                end
            end
            if visiona < 250 && va == 58
                va = i;
            end
        end
        vld = 30;
        for i = 1:30
            visionld = 255;
            for j = 1:47
                visionld = min(r(86-j-i,100-j+i),visionld);
                r(86-j-i,100-j+i) = r(86-j-i,100-j+i) + 200;
                r(86-j-i,100-j+i) = r(86-j-i,100-j+i) - 100;
                if j~=47
                    visionld = min(r(85-j-i,100-j+i),visionld);
                    r(85-j-i,100-j+i) = r(85-j-i,100-j+i) + 200;
                    r(85-j-i,100-j+i) = r(85-j-i,100-j+i) - 100;
                end
            end
            if visionld < 250 && vld == 30
                vld = i;
            end
        end
        vli = 30;
        for i = 1:30
            visionli = 255;
            for j = 1:47
                visionli = min(r(100-j+i,86-j-i),visionli);
                r(100-j+i,86-j-i) = r(100-j+i,86-j-i) + 200;
                r(100-j+i,86-j-i) = r(100-j+i,86-j-i) - 100;
                if j~=47
                    visionli = min(r(100-j+i,85-j-i),visionli);
                    r(100-j+i,85-j-i) = r(100-j+i,85-j-i) + 200;
                    r(100-j+i,85-j-i) = r(100-j+i,85-j-i) - 100;
                end
            end
            if visionli < 250 && vli == 30
                vli = i;
            end
        end
        vl = vld - vli;
    end
    vl = vl + 31;
end