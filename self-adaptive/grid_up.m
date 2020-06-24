function output = grid_up(grid,u,opt)
%输入单元格，进行剖分
if nargin < 3
    opt.tol = 1e-6;
    opt.theta = 0.3;
end
dir = [1,0;0,-1;-1,0;0,1];
grid0 = grid;
grid_unit = unitgrid(grid);
num = length(grid_unit);
eta = zeros(num,1);
for i = 1:num
    U  = grid_unit{i};
%     patch('Faces',[1,2,3,4],'Vertices',U,'EdgeColor','blue','FaceColor','none','LineWidth',1);
    eta(i) = uniterr(grid,grid_unit,U,u);
end
s = sum(eta);
if s < opt.tol
    output.grid = grid;
    output.grid_unit = grid_unit;
    output.flag = 1;
    return;
end
s0 = 0;
[eta,k] = sort(eta,'descend');
g = {};
for i = 1:num
    g{i} = grid_unit{k(i)};
    s0 = s0+eta(i);
    if s0 > opt.theta*s
        break;
    end
end
num0  =length(g);
i = 0;
while i < num0
    i = i+1;
    unit = g{i};
    if isempty(find(ismember(grid0,(unit(1,:)+unit(3,:))/2,'rows')))
    grid0 = [grid0;(unit(1,:)+unit(3,:))/2];
    end
    for di = 1:4
        j = di+1;  if j > 4; j = 1; end
        if isedge(unit(j,:)) && isedge(unit(di,:)); continue; end
        if isempty(find(ismember(grid0,(unit(j,:)+unit(di,:))/2,'rows')))
            grid0 = [grid0;(unit(j,:)+unit(di,:))/2];
        end
    end
end
for i = 1:num
    unit = grid_unit{i};
    flag = 0;
    for di = 1:4
        j = di+1;  if j > 4; j = 1; end
        if isedge(unit(j,:)) && isedge(unit(di,:)); continue; end
        if ~isempty(find(ismember(grid0,(unit(j,:)+3*unit(di,:))/4,'rows'))) || ~isempty(find(ismember(grid0,(unit(j,:)*3+unit(di,:))/4,'rows')))
            flag = 1;
            break;
        end
    end
    if flag == 1
        if isempty(find(ismember(grid0,(unit(1,:)+unit(3,:))/2,'rows')))
           grid0 = [grid0;(unit(1,:)+unit(3,:))/2];
        end
        for di = 1:4
            j = di+1;  if j > 4; j = 1; end
            if isedge(unit(j,:)) && isedge(unit(di,:)); continue; end
            if isempty(find(ismember(grid0,(unit(j,:)+unit(di,:))/2,'rows')))
                grid0 = [grid0;(unit(j,:)+unit(di,:))/2];
            end
        end
    end
end
grid_unit = unitgrid(grid0);
num = 0;
while num ~= length(grid_unit)
    num = length(grid_unit);
    for i = 1:num
        unit = grid_unit{i};
        flag = 0;
        for di = 1:4
            j = di+1;  if j > 4; j = 1; end
            if isedge(unit(j,:)) && isedge(unit(di,:)); continue; end
            if ~isempty(find(ismember(grid0,(unit(j,:)+3*unit(di,:))/4,'rows'))) || ~isempty(find(ismember(grid0,(unit(j,:)*3+unit(di,:))/4,'rows')))
                flag = 1;
                break;
            end
        end
        if flag == 1
            if isempty(find(ismember(grid0,(unit(1,:)+unit(3,:))/2,'rows')))
               grid0 = [grid0;(unit(1,:)+unit(3,:))/2];
            end
            for di = 1:4
                j = di+1;  if j > 4; j = 1; end
                if isedge(unit(j,:)) && isedge(unit(di,:)); continue; end
                if isempty(find(ismember(grid0,(unit(j,:)+unit(di,:))/2,'rows')))
                    grid0 = [grid0;(unit(j,:)+unit(di,:))/2];
                end
            end
        end
    end
    grid_unit = unitgrid(grid0);
end
output.grid = grid0;
output.grid_unit = grid_unit;
output.flag = 0;
output.eta = s;