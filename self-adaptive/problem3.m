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
opt.theta = 0.1;
flag = 0;
f = @(x,y) power(x^2+y^2,1/3)*sin(2*mod(atan2(y,x),pi*2)/3)*(1-x^2)*(1-y^2);
while flag == 0
    k = k+1;
    [L,u] = Generate_Dif_adap(grid);
    u = u';
    x = -L\u;
    z = zeros(max(size(x)),1);
    for i = 1:max(size(x))
        z(i) = f(grid(i,1),grid(i,2));
    end
    err = z-x;
    e = norm(err);
    output = grid_up(grid,x,opt);    
    flag = output.flag;
    grid = output.grid;
    if k == 20
        c = 1;
    end
 end