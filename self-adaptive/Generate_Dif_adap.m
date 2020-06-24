function [L,f] = Generate_Dif_adap(grid)
%生成差分矩阵和函数值
num = max(size(grid));
L = sparse(num,num);
g = @(x,y) Lap(x,y);
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
        f(i) = g(x,y);
    elseif type == 2
        L(i,i) = 2;
        m = 1;
%         if x == -0.25 && y == 0; 
%             c = 1;
%         end
        while m < 5
            if isempty(find(ismember(grid,u+h*dir(m,:),'row'))) && isedge(u+h*dir(m,:)) == 0;break; end
            m = m+1;
        end
        k = mod(m+1,4); if k == 0;k=4; end
        t = find(ismember(grid,u+h*dir(k,:),'rows'));
        if ~isempty(t);   L(i,t) = -1;        end
        t = find(ismember(grid,u-h*dir(k,:),'rows'));
        if ~isempty(t);   L(i,t) = -1;        end
        f(i) = 0;
    else
        flag = 1;
        for j = 1:4
            if isempty(find(ismember(grid,u+h*dir(j,:),'row'))) && isedge(u+h*dir(j,:)) == 0;flag = 0;break; end
        end
        if flag == 1
            for j =  1:4
                t = find(ismember(grid,n(j,:),'rows'));
                if isempty(t)
                    continue;
                else
                    L(i,t) = -1/h^2;
                end
            end
        else
            h = h*2;
            for j =  1:4
                t = find(ismember(grid,u+h*dir(j,:),'rows')) ;
                if isempty(t)
                    continue;
                else
                    L(i,t) = -1/h^2;
                end
            end
            L(i,i) = 4/h^2;           
        end
        f(i) = g(x,y);
    end
end