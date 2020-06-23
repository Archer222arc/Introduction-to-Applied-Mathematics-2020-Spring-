function bool = isingrid(grid,x,y)
%查找(x,y)是否在网格中
bool = find(ismember(grid,[x,y],'rows'));
if isempty(bool);   bool = 0;   end