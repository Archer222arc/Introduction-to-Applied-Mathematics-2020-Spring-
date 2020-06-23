function [L,G] = Generate_Dif_L(N)
%生成单元长为2/N的L型差分矩阵
h = 2/N;
n = N/2-1;
G = zeros(N+1);
for j = 2:n+2
    for i = 2:n+1
        G(i,j) = (j-2)*n+i-1;
    end
end
for j = n+3:N
    for i = 2:N
        G(i,j) = (j-n-3)*(N-1)+i+n*(n+1)-1;
    end
end
G = fliplr(G);
L = delsq(G);   
L = L/h^2;