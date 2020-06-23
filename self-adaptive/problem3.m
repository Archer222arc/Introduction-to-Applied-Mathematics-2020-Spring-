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
while flag == 0
    k = k+1;
    [L,u] = Generate_Dif_adap(grid);
    u = u';
    x = -L\u;
    output = grid_up(grid,x,opt);
    flag = output.flag;
    grid = output.grid;
 end