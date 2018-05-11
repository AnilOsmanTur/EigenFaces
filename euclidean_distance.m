function [dis] = euclidean_distance (M1, M2)
    % 1, n matrises
    dis = M1 - M2;
    dis = sum(dis.^2, 2);
    dis = sqrt(dis);    
end
