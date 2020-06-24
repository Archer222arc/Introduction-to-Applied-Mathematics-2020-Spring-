function output = relative_err(f,U)
%计算相对误差
% f = @(x,y) exp(-2*pi^2)*sin(pi*x)*sin(pi*y);
grid_size = size(U);
n = grid_size(1);
h = 1/(n+1);
u = zeros(n);
err1 = 0;
err2 = 0;
for i = 1:n
    for j = 1:n
        u(i,j) = f(h*j,h*i);
    end
end
for i = 1:n-1
    for j = 1:n-1
        opt.h = h;
        g = @(x,y) interpolation(x,y,opt,U);
        interval.x = [j*h,j*h+h];
        interval.y = [i*h,i*h+h];
        err1 = err1+sqrt(myint_2d(@(x,y)(f(x,y)-g(x,y))^2,opt,interval));
        err2 = err2+myint_2d(f,opt,interval);
    end
end
output.rel = err1/err2;
output.e1 = err1;
output.e2 = err2;