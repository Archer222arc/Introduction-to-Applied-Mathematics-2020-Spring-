function [d_min,n] = mydistance(grid,x,y)
%输出到最近点的距离，四个方向
h_min = 1/2^20;
k = 1;
dir = [1,0;0,-1;-1,0;0,1];
n = zeros(4,2);
d_min = ones(4,1)*h_min;
for i = 1:4
   u = [x,y]+d_min(i)*dir(i,:);
   a = u(1);    b = u(2);
   while ~isingrid(grid,a,b) && ~isedge(a,b)
        d_min(i) = d_min(i)*2;
        u = [x,y]+d_min(i)*dir(i,:);
        a = u(1);   b = u(2);
        if abs(a) > 1 || abs(b) > 1;   flag = 1; break;  end
    end
   n(i,:) = u;
end