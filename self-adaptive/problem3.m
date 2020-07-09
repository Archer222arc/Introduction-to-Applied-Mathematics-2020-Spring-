grid = zeros(9,2);
for i = 1:3
    for j = 1:3
        grid(i+j*3-3,:) = toreal(i,j,4);
    end
end
m = [];
for i = 1:9
    if isinregion(grid(i,1),grid(i,2))
        m = [m;i];
    end
end
grid = grid(m,:);
k = 0;
opt.tol = 1e-6;
opt.theta = 0.8;
flag = 0;
% N = 100;
f = @(x,y) power(x^2+y^2,1/3)*sin(2*mod(atan2(y,x),pi*2)/3)*(1-x^2)*(1-y^2);
% F = zeros(201);
% h = 2/N
% for j = 1:201
%     for i = 1:201
%         x = 1.01-i*0.01; y = 1.01-i*0.01;
%         if isinregion(x,y)
%             F(i,j) = f(x,y);
%         end
%     end
% end
% x = -1:h:1;
% y = -1:h:1;
% z = zeros(N+1);
% for i = 1:N+1
%     for j = 1:N+1
%         z(i,j) = Lap(y(j),x(i));
%     end
% end
%     surf(x,y,z);
%     shading interp;
%     drawnow;
while flag == 0
    k = k+1;
    [L,u] = Generate_Dif_adap(grid);
    u = u';
    x = -L\u;
    opt.err = 1;
    err(k) = int_adap(grid,x,opt);
    num(k) = length(grid);
    output = grid_up(grid,x,opt);    
    flag = output.flag;
    grid = output.grid;
    if k == 10 || k == 15
        c = 1;
    end
 end