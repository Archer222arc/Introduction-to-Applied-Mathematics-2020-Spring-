function z = interpolation_grad(x,y,N,u)
%L-区域分片梯度插值,[dx,dy]
[m,n] = size(u);
h = 2/N;
if x >= -h && y >= 0
    i = floor((1-y)/h);
    j = floor((1-x)/h);
    k = (j-1)*(N/2-1)+i;
    %b是右上角格子的坐标
    b.x = 1-x-j*h;
    b.y = 1-y-i*h;
    z1 = -u(k)*(h-b.y)-u(k+1)*b.y+u(k+N/2-1)*(h-b.y)+u(k+N/2)*b.y; z1 = z1/h^2;
    z2 = -u(k)*(h-b.x)+u(k+1)*(h-b.x)-u(k+N/2-1)*b.x+u(k+N/2)*b.x; z2 = z2/h^2;
    z = [z1,z2];
else
    i = floor((1-y)/h);
    j = floor((1-x)/h);
    if i == N-1;  i = i-1;    end
    if j == N-1;  j = j-1;    end
    k = (j-N/2-1)*(N-1)+i+N/2*(N/2-1);
    b.x = 1-x-j*h;
    b.y = 1-y-i*h;
    z1 = -u(k)*(h-b.y)-u(k+1)*b.y+u(k+N-1)*(h-b.y)+u(k+N)*b.y; z1 =z1/h^2;
    z2 = -u(k)*(h-b.x)+u(k+1)*(h-b.x)-u(k+N-1)*b.x+u(k+N)*b.x; z2 =z2/h^2;
    z = [z1,z2];
end