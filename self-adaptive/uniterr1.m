function eta = uniterr(grid,unit,u)
%单位格上的误差，unit存储右上开始顺时针4个顶点坐标
g = @(r,theta)((2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(3*r^(1/3)) + 2*r^(5/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(5/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/r - ((4*r^(2/3)*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/9 - 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*cos(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1) - 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*sin(theta)^2 - 1) + 8*r^(14/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2 - (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*cos(theta)^2 - 1))/3 + (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*sin(theta)^2 - 1))/3)/r^2 - (2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(9*r^(4/3)) + (14*r^(2/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1))/3 + (14*r^(2/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/3 + 8*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2;
r = @(x,y) sqrt(x^2+y^2);
theta = @(x,y)mytheta(x,y);
f = @(x,y) Lap(x,y);
dir = [1,0;0,-1;-1,0;0,1];
un = unit;
h = un(1,2)-un(2,2);
opt.tol = 1e-6;
interval.x = [un(3,1),un(1,1)];
interval.y = [un(2,2),un(1,2)];
x1 = un(3,1);   x2 = un(1,1);
y1 = un(2,2);   y2 = un(1,2);
u_x = @(x)(u0(1)*(x-x1) + u0(2)*(x-x1) + u0(3)*(x-x2) + u0(4)*(x -x2))/h^2;
u_y = @(y)(u0(1)*(y-y1) + u0(2)*(y-y2) + u0(3)*(y-y2) + u0(4)*(y-y2))/h^2;
eta = h^2*myint_2d(f,opt,interval);
u0  = zeros(4,1);
for i = 1:4
    t = find(ismember(grid,un(i,:),'rows'));
    if isempty(t);   u0(i) = 0;  
    else; u0(i) = u(t);
    end
end
for i = 1:4
   if isedge(un(i,1),un(i,2)) && isedge(un(i,1),un(i,2));  continue;   end
   u_mid = (un(i,1),un(i,2))/2;
   %相邻两条边长相等
   if isempty(find(ismember(grid,u_mid,'row')))
       for j = i:i+3
           k = mod(j,4);k = 
       