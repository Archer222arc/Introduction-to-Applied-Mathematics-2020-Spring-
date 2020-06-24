function output = ishang(grid,unit_grid,x,y)
%检查是否悬点,type 类型，bool 为是否悬点， d为最短距离， n为邻居(关联点)排列为东南西北
%type 1 为 4个细单元的公共顶点
%type 2 为 悬点 逆时针输出方向
%type 3 为 有两个细距离，两个粗距离,返回的dis是2倍单元格,dis为细网格位置
%所有的边界点都是type 3
if nargin < 3;   c = x;x=c(1);y=c(2);end
dir = [1,0;0,-1;-1,0;0,1];
[d_min,n] = mydistance(grid,x,y);
output.n = n;
d = min(d_min);
u = [x,y];

flag = 1;
for i = 1:4
    v = u;
    for j = i:i+3
        k = mod(j,4); if k==0;k=4;end
        v = v+d*dir(k,:);
        if isempty(find(ismember(grid,v,'rows'))) && ~isedge(v); flag = 0; break; end
    end
    if flag == 0;   break; end
end
if flag == 1
    output.type = 1;
    output.dis = d;
%     output.dir = dir;
    return;
end
%下面判定是否为悬点
if length(find(d_min==d)) ~= 3
    output.type = 3;
    output.dis = d;
    return;
end
m = find(d_min==max(d_min));
v = u; unit =[];
for i = m:-1:m-3
    j = mod(i,4);if j==0;j = 4;end
    unit = [unit;v];
    v = v+2*d*dir(j,:);
end
unit = repair(unit);
flag = 0;
for i = 1:length(unit_grid)
    if isequal(unit,unit_grid{i})
        flag = 1; break; 
    end
end
if flag == 0
    output.type = 2;
    output.dis = d;
else
    output.type = 3;
    output.dis = d;
end
