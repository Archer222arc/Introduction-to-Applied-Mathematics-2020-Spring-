function y = interpolation_L(x,y,N,u)
%L-区域分片线性插值
[m,n] = size(u);
h = 2/N;
if x >= -h && y >= 0
    i = floor((1-y)/h);
    j = floor((1-x)/h);
    k = (j-1)*(N/2-1)+i;
    %b是右上角格子的坐标
    b.x = 1-x-j*h;
    b.y = 1-y-i*h;
    if y == h
        k = k-1;
        b.y = h;
    end
    y = u(k)*(h-b.x)*(h-b.y)+u(k+1)*(h-b.x)*b.y+u(k+N/2-1)*b.x*(h-b.y)+u(k+N/2)*b.x*b.y;
    y = y/h^2;
else
    i = floor((1-y)/h);
    j = floor((1-x)/h);
    if i == N-1;  i = i-1;    end
    if j == N-1;  j = j-1;    end
    k = (j-N/2-1)*(N-1)+i+N/2*(N/2-1);
    b.x = 1-x-j*h;
    b.y = 1-y-i*h;
    if y == -1+h
        k = k-1;
        b.y = h;
    end
    y = u(k)*(h-b.x)*(h-b.y)+u(k+1)*(h-b.x)*b.y+u(k+N-1)*b.x*(h-b.y)+u(k+N)*b.x*b.y;
    y = y/h^2;
end