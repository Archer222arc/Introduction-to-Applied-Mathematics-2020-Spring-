function grid_unit = unitgrid(grid)
%找到所有的单元格，输出为4个顶点构成的集合
num = size(grid);
grid_unit = {};
len = 0;
dir = [1,0;0,-1;-1,0;0,1];
for i = 1:num
    u = grid(i,:);
    x = u(1);   y = u(2);
    dis = min(mydistance(grid,x,y));
    for di = 1:4
        if x == -0.5 && y == -0.5
            c = 1;
        end
        v = u;
        flag = 1;
        unit = [];
        for j = di:di+3
            k = mod(j,4); if k == 0 ; k = 4; end
            unit = [unit;v];
            v = v+dir(k,:)*dis;
            if isempty(find(ismember(grid,v,'rows'))) && ~isedge(v)
                flag = 0;
                break;
            end
        end
        if flag == 1
            len = len+1;
            v = repair(unit);
            v = v(:);
            grid_unit{len} = v';
        else
            j = di+1; if j == 5; j = 1; end
            for t = 1:2
                v = u+t*dis*(dir(j,:)+dir(di,:));
                if isinregion(2*v-u) == 0 && isedge(2*v-u) == 0;  break;  end
                if isempty(find(ismember(grid,v,'rows'))) && ~isedge(v) && (~isempty(find(ismember(grid,2*v-u,'rows')))||isedge(2*v-u))
                   if x == floor(x/(t*2*dis))*2*t*dis && y == floor(y/(t*2*dis))*2*t*dis
                      unit = repair([2*v-u;u;u+2*dir(j,:)*t*dis;u+2*dir(di,:)*t*dis]);
                      patch('Faces',[1,2,3,4],'Vertices',unit,'EdgeColor','blue','FaceColor','none','LineWidth',1);
%                       v = reshape(unit);
                      v = unit(:);
                      len = len+1;
                      grid_unit{len} = v';
                   end
                end
            end
        end
    end
end
grid_unit = cellfun(@num2str,grid_unit,'un',0);
grid_unit = unique(grid_unit);
grid_unit = cellfun(@str2num,grid_unit,'un',0); 
num = length(grid_unit);
for i = 1:num
    grid_unit{i} = reshape(grid_unit{i},[4,2]);
end
for i = 1:num
    patch('Faces',[1,2,3,4],'Vertices',grid_unit{i},'EdgeColor','blue','FaceColor','none','LineWidth',1);
end