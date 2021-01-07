%% Celda con carros:
carros = cell(6,8);
for i = 1:6
    carros{i,1} = imread(['Imagenes/c',num2str(i),'.bmp']);
    carros{i,2} = imread(['Imagenes/c',num2str(i),'d.bmp']);
end
for j = 1:6
    c1 = carros{j,1}(:,:,1);
    c2 = carros{j,1}(:,:,2);
    c3 = carros{j,1}(:,:,3);
    cd1 = carros{j,2}(:,:,1);
    cd2 = carros{j,2}(:,:,2);
    cd3 = carros{j,2}(:,:,3);
    for i = 3:-1:1
        c1 = rot90(c1);
        c2 = rot90(c2);
        c3 = rot90(c3);
        temp = c1;
        temp(:,:,2) = c2;
        temp(:,:,3) = c3;
        carros{j,(i)*2+1} = temp;
        cd1 = rot90(cd1);
        cd2 = rot90(cd2);
        cd3 = rot90(cd3);
        temp = cd1;
        temp(:,:,2) = cd2;
        temp(:,:,3) = cd3;
        carros{j,(i)*2+2} = temp;
    end
end
save carros;