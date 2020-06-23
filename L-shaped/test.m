N = 512;
[L,G] = Generate_Dif_L(N);
% u = ones(33,1);
% x = L\u;
u0 = Init_L(N);
h = 2/N;
vec_size = N*(N/2-1)/2+(N-1)*(N/2-1);
% spy(L);
opt.ite = 9999999999;
opt.theta = 1;
% output = mySOR(L,u0,opt);
% opt.tol = 1e-8;
output = V_cycle_L(u0,N,opt);
% y = interpolation_L(-1+1.5*h,1-h,N,u0);
u = -output.u;
% f = @(r,theta) power(r,2/3)*sin(2*theta/3)*(1-r^2*(cos(theta))^2)*(1-r^2*(sin(theta))^2);
f = @(x,y) power(x^2+y^2,1/3)*sin(2/3*mod(atan2(y,x),2*pi))*(1-x^2)*(1-y^2);
U_0 = zeros(vec_size,1);
for j = 1:N/2
    for i = 1:N/2-1
        x = 1-j*h;  y = 1-i*h;
        U_0((j-1)*(N/2-1)+i) = f(x,y);
    end
end
for j = N/2+1:N-1
    for i = 1:N-1
        x = 1-j*h;  y = 1-i*h;
        U_0((j-N/2-1)*(N-1)+i+N*(N/2-1)/2) = f(x,y);
    end
end
err = Int_L(f,N,u);
re = norm(U_0-u)/norm(U_0);
e = U_0-u;