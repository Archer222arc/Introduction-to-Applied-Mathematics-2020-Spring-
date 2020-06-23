function s = Int_L(f,N,u)
%L型区域积分
h = 2/N;
s = 0;
g = @(x,y) (f(x,y)-interpolation_L(x,y,N,u))^2;
opt.tol = 1e-6;
for j = 1:N/2
    for i = 1:N/2-2
        interval.x = [1-(j+1)*h,1-j*h];
        interval.y = [1-(i+1)*h,1-i*h];
        s = s+myint_2d(g,opt,interval);
    end
end
for j = N/2+1:N-2
    for i = 1:N-2
        interval.x = [1-(j+1)*h,1-j*h];
        interval.y = [1-(i+1)*h,1-i*h];
        s = s+myint_2d(g,opt,interval);
    end
end