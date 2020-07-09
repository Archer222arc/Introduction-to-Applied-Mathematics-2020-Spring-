function s = int_adap(grid,u,opt)
%单位格上的误差，unit存储右上开始顺时针4个顶点坐标
s = 0;
opt.tol = 1e-6;
grid_unit = unitgrid(grid);
num = length(grid_unit);
if opt.err == 1
    f = @(x,y) (x^2+y^2)^(1/3)*sin(2*mod(atan2(y,x),2*pi)/3)*(1-x^2)*(1-y^2);
    for i = 1:num
        un = grid_unit{i};
        for j = 1:4
            t = find(ismember(grid,un(j,:),'rows'));
            if isempty(t);   u0(j) = 0;  
            else; u0(j) = u(t);
            end
        end      
        h = un(1,2)-un(2,2);
        interval.x = [un(3,1),un(1,1)];
        interval.y = [un(2,2),un(1,2)];
        x0 = un(3,1);   x1 = un(1,1);
        y0 = un(2,2);   y1 = un(1,2);
        g = @(x,y) ((x-x0)*(y-y0)*u0(1)+(x-x0)*(y1-y)*u0(2)+(x1-x)*(y1-y)*u0(3)+(x1-x)*(y-y0)*u0(4))/h^2-f(x,y);    
        g1 =@(x,y) g(x,y)^2;
        s = s+myint_2d(g1,opt,interval);
    end
else
    r = @(x,y)sqrt(x^2+y^2)+eps; 
    theta =@(x,y) mod(atan2(y,x),2*pi);
    rn = @(x,y)[cos(theta(x,y)),sin(theta(x,y))]; rt =@(x,y) [-sin(theta(x,y)),cos(theta(x,y))];
    f = @(x,y) rn(x,y)*((2*sin((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/(3*r(x,y)^(1/3)) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))^2*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*sin(theta(x,y))^2*(r(x,y)^2*cos(theta(x,y))^2 - 1))+rt(x,y)*((2*r(x,y)^(2/3)*cos((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/3 - 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*cos(theta(x,y))^2 - 1))/r(x,y);
    for i = 1:num
        un = grid_unit{i};
        for j = 1:4
            t = find(ismember(grid,un(j,:),'rows'));
            if isempty(t);   u0(j) = 0;  
            else; u0(j) = u(t);
            end
        end
        un = grid_unit{i};
        h = un(1,2)-un(2,2);
        interval.x = [un(3,1),un(1,1)];
        interval.y = [un(2,2),un(1,2)];
        x0 = un(3,1);   x1 = un(1,1);
        y0 = un(2,2);   y1 = un(1,2);
        g = @(x,y) [((y-y0)*u0(1)+(y1-y)*u0(2)-(y1-y)*u0(3)-(y-y0)*u0(4))/h^2,((x-x0)*u0(1)-(x-x0)*u0(2)-(x1-x)*u0(3)+(x1-x)*u0(4))/h^2];
        g1 = @(x,y)norm(f(x,y)-g(x,y))^2;
        s = s+myint_2d(g1,opt,interval);
    end
end
s = sqrt(s);