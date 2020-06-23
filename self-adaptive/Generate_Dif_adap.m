function [L,f] = Generate_Dif_adap(grid)
%生成差分矩阵和函数值
num = max(size(grid));
L = zeros(num);
dir = [1,0;0,-1;-1,0;0,1];
unit_grid = unitgrid(grid);
for i = 1 : num
    u = grid(i,:);
    x = u(1); y = u(2);
    output = ishang(grid,unit_grid,x,y);
    type = output.type;
    h = output.dis;
    n = output.n;
    if type == 1
        for j =  1:4
            t = find(ismember(grid,n(j,:),'rows'));
            if isempty(t)
                continue;
            else
                L(i,t) = -1/h^2;
            end
        end
        L(i,i) = 4/h^2;
        f(i) = Lap(x,y);
    elseif type == 2
        L(i,i) = 2;
        m = 1;
        while m < 5
            if isempty(find(ismember(grid,u+h*dir(j,:),'row')));break; end
            m = m+1;
        end
        k = mod(m+1,4); if k == 0;k=4; end
        t = find(ismember(grid,u+h*dir(k,:),'rows'));
        if ~isempty(t);   L(i,t) = -1;        end
        t = find(ismember(grid,u-h*dir(k,:),'rows'));
        if ~isempty(t);   L(i,t) = -1;        end
        f(i) = 0;
    else
        h = h*2;
        for j =  1:4
            t = find(ismember(grid,u+h*dir(j,:),'rows'));
            if isempty(t)
                continue;
            else
                L(i,t) = -1/h^2;
            end
        end
        L(i,i) = 4/h^2;
        f(i) = Lap(x,y);
    end
end