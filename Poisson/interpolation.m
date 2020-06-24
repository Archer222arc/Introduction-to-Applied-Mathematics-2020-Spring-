function u = interpolation(x,y,opt,U)
%分片线性插值
[m,n] = size(U);
h = opt.h;
i = floor(y/opt.h);
j = floor(x/opt.h);
b.x = x-(j-1)*h;
b.y = y-(i-1)*h;
if i < m && j < n
    u = (U(i,j)*(h-b.x)*(h-b.y)+U(i,j+1)*b.x*(h-b.y)+U(i+1,j)*(h-b.x)*b.y+U(i+1,j+1)*b.x*b.y)/(h^2);
elseif i < m
    u = (U(i,j)*(h-b.y)+U(i+1,j)*b.y)/h;
elseif j < n
    u = (U(i,j)*(h-b.x)+U(i,j+1)*b.x)/h;
else ;u = U(i,j);    end
