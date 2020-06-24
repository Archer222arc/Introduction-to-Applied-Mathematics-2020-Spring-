function eta = uniterr(grid,unit_grid,unit,u)
%单位格上的误差，unit存储右上开始顺时针4个顶点坐标
% f= @(x,y)g(r(x,y),theta(x,y))^2;
f = @(x,y) Lap(x,y)^2;
dir = [1,0;0,-1;-1,0;0,1];
un = unit;
h = un(1,2)-un(2,2);
opt.tol = 1e-6;
interval.x = [un(3,1),un(1,1)];
interval.y = [un(2,2),un(1,2)];
x0 = un(3,1);   x1 = un(1,1);
y0 = un(2,2);   y1 = un(1,2);
eta = h^2*myint_2d(f,opt,interval);
%每个点负责顺时针一侧的边
u0 = zeros(4,1);
for i = 1:4
    t = find(ismember(grid,un(i,:),'rows'));
    if isempty(t);   u0(i) = 0;  
    else; u0(i) = u(t);
    end
end
% p = @(x,y) ((x-x0)*(y-y0)*u0(1)+(x-x0)*(y-y1)*u0(2)+(x-x1)*(y-y1)*u0(3)+(x-x1)*(y-y0)*u0(4))/h^2; g = @(r,theta)((2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(3*r^(1/3)) + 2*r^(5/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(5/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/r - ((4*r^(2/3)*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/9 - 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*cos(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1) - 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*sin(theta)^2 - 1) + 8*r^(14/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2 - (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*cos(theta)^2 - 1))/3 + (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*sin(theta)^2 - 1))/3)/r^2 - (2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(9*r^(4/3)) + (14*r^(2/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1))/3 + (14*r^(2/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/3 + 8*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2; if nargin<4; return; end
for i = 1:4   
    j = mod(i+1,4); if j == 0; j = 4;end
    if isedge(un(i,1),un(i,2)) && isedge(un(j,1),un(j,2))
%         if i == 2 || i == 4
%             u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
%             u_h = @(x) (u_h1(x)^2)/h;
%             eta = eta+h*myInt_1d(u_h,interval.x,opt);
%         else
%             u_h1 = @(y)(u0(1)*(y-y0) + u0(2)*(y1-y) + u0(3)*(y-y1) + u0(4)*(y0-y))/h;
%             u_h = @(y) (u_h1(y))^2/h;
%             eta = eta+h*myInt_1d(u_h,interval.y,opt);
%         end
        continue;   
    end
    if ishang(grid,unit_grid,un(i,1),un(i,2)).type ~= 2 && ishang(grid,unit_grid,un(j,1),un(j,2)).type ~= 2
        %两侧都是短边
        if find(ismember(grid,(un(i,:)+un(j,:))/2,'rows')) == 0 
            v = un(i,:);
            unit0 = [];
            for j = i:i+3
                k = mod(j,4); if k == 0; k = 4; end
                unit0 = [unit0;v];
                v = v+h*dir(k);
            end
            unit0 = repair(unit0);
            u1 = zeros(4,1);
            for j = 1:4
                t = find(ismember(grid,unit0(j,:),'rows'));
                if isempty(t);  u1(i) = 0;
                else; u1(i) = u(t);
                end
            end
            x2 = unit0(3,1);    x3 = unit0(1,1);
            y2 = unit0(2,2);    y3 = unit0(1,2);
            if i == 2 || i == 4
                u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
                u_h2 = @(x)(u1(1)*(x-x2)+u1(2)*(x2-x)+u1(3)*(x-x3)+u1(4)*(x3-x))/h;
                u_h = @(x) (u_h1(x)+u_h2(x))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.x,opt);
            else
                u_h1 = @(y)(u0(1)*(y-y0) + u0(2)*(y1-y) + u0(3)*(y-y1) + u0(4)*(y0-y))/h;
                u_h2 = @(y)(u1(1)*(y-y2) + u1(2)*(y3-y) + u1(3)*(y-y3) + u1(4)*(y2-y))/h;
                u_h = @(y) (u_h1(y)+u_h2(y))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.y,opt);
            end
       else
        %该边为这一侧长边，对面的短边
            h1 = h/2;
            v = un(i,:);
            unit0 = [];
            for j = i:i+3
                k = mod(j,4); if k == 0; k = 4; end
                unit0 = [unit0;v];
                v = v+h1*dir(k);
            end
            unit0 = repair(unit0);
            u1 = zeros(4,1);
            for j = 1:4
                t = find(ismember(grid,unit0(j,:),'rows'));
                if isempty(t);  u1(i) = 0;
                else; u1(i) = u(t);
                end
            end
            x2 = unit0(3,1);    x3 = unit0(1,1);
            y2 = unit0(2,2);    y3 = unit0(1,2);
            if i == 2 || i == 4
                u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
                u_h2 = @(x)(u1(1)*(x-x2)+u1(2)*(x2-x)+u1(3)*(x-x3)+u1(4)*(x3-x))/h1;
                u_h = @(x) (u_h1(x)+u_h2(x))^2/h;
                if i == 2
                    eta = eta+h*myInt_1d(u_h,[(x0+x1)/2,x1],opt);
                else
                    eta = eta+h*myInt_1d(u_h,[x0,(x0+x1)/2],opt);
                end
            else
                u_h1 = @(y)(u0(1)*(y-y0)+u0(2)*(y1-y)+u0(3)*(y-y1)+u0(4)*(y0-y))/h;
                u_h2 = @(y)(u1(1)*(y-y2)+u1(2)*(y3-y)+u1(3)*(y-y3)+u1(4)*(y2-y))/h1;
                u_h = @(y) (u_h1(y)+u_h2(y))^2/h;
                if i == 1
                    eta = eta+h*myInt_1d(u_h,[(y0+y1)/2,y1],opt);
                else
                    eta = eta+h*myInt_1d(u_h,[y0,(y0+y1)/2],opt);
                end
            end
            j = i+1; if j > 4;  j = 1;  end
            v = (un(i,:)+un(j,:))/2;
            unit0 = [];
            for j = i:i+3
                k = mod(j,4); if k == 0; k = 4; end
                unit0 = [unit0;v];
                v = v+h1*dir(k);
            end
            unit0 = repair(unit0);
            u1 = zeros(4,1);
            for j = 1:4
                t = find(ismember(grid,unit0(j,:),'rows'));
                if isempty(t);  u1(i) = 0;
                else; u1(i) = u(t);
                end
            end
            x2 = unit0(3,1);    x3 = unit0(1,1);
            y2 = unit0(2,2);    y3 = unit0(1,2);
            if i == 2 || i == 4
                u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
                u_h2 = @(x)(u1(1)*(x-x2)+u1(2)*(x2-x)+u1(3)*(x-x3)+u1(4)*(x3-x))/h1;
                u_h = @(x) (u_h1(x)+u_h2(x))^2/h;
                if i == 4
                    eta = eta+h*myInt_1d(u_h,[(x0+x1)/2,x1],opt);
                else
                    eta = eta+h*myInt_1d(u_h,[x0,(x0+x1)/2],opt);
                end
            else
                u_h1 = @(y)(u0(1)*(y-y0) + u0(2)*(y1-y) + u0(3)*(y-y1) + u0(4)*(y0-y))/h;
                u_h2 = @(y)(u1(1)*(y-y2) + u1(2)*(y3-y) + u1(3)*(y-y3) + u1(4)*(y2-y))/h1;
                u_h = @(y) (u_h1(y)+u_h2(y))^2/h;
                if i == 3
                    eta = eta+h*myInt_1d(u_h,[(y0+y1)/2,y1],opt);
                else
                    eta = eta+h*myInt_1d(u_h,[y0,(y0+y1)/2],opt);
                end
            end
        end
    else
        %对面长边，这边短边     
        j = mod(i+1,4); if j == 0;  j = 4;  end
        v = un(i,:)+dir(i)*h;
        h1 = 2*h;
        if find(ismember(grid,v,'rows')) == 0
            % i 点为中点
            v = un(i,:)-h*dir(j,:);
            for j = i:i+3
                k = mod(j,4); if k == 0; k = 4; end
                unit0 = [unit0;v];
                v = v+h1*dir(k);
            end
            unit0 = repair(unit0);
            u1 = zeros(4,1);
            for j = 1:4
                t = find(ismember(grid,unit0(j,:),'rows'));
                if isempty(t);  u1(i) = 0;
                else; u1(i) = u(t);
                end
            end         
            x2 = unit0(3,1);    x3 = unit0(1,1);
            y2 = unit0(2,2);    y3 = unit0(1,2);
            if i == 2 || i == 4
                u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
                u_h2 = @(x)(u1(1)*(x-x2)+u1(2)*(x2-x)+u1(3)*(x-x3)+u1(4)*(x3-x))/h1;
                u_h = @(x) (u_h1(x)+u_h2(x))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.x,opt);
            else
                u_h1 = @(y)(u0(1)*(y-y0) + u0(2)*(y1-y) + u0(3)*(y-y1) + u0(4)*(y0-y))/h;
                u_h2 = @(y)(u1(1)*(y-y2) + u1(2)*(y3-y) + u1(3)*(y-y3) + u1(4)*(y2-y))/h1;
                u_h = @(y) (u_h1(y)+u_h2(y))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.y,opt);
            end
        else
            % i 为顶点
            v = un(i,:);
            unit0 = [];
            for j = i:i+3
                k = mod(j,4); if k == 0; k = 4; end
                unit0 = [unit0;v];
                v = v+h1*dir(k);
            end
            unit0 = repair(unit0);
            u1 = zeros(4,1);
            for j = 1:4
                t = find(ismember(grid,unit0(j,:),'rows'));
                if isempty(t);  u1(i) = 0;
                else; u1(i) = u(t);
                end
            end         
            x2 = unit0(3,1);    x3 = unit0(1,1);
            y2 = unit0(2,2);    y3 = unit0(1,2);
            if i == 2 || i == 4
                u_h1 = @(x)(u0(1)*(x-x0)+u0(2)*(x0-x)+u0(3)*(x-x1)+u0(4)*(x1-x))/h;
                u_h2 = @(x)(u1(1)*(x-x2)+u1(2)*(x2-x)+u1(3)*(x-x3)+u1(4)*(x3-x))/h1;
                u_h = @(x) (u_h1(x)+u_h2(x))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.x,opt);
            else
                u_h1 = @(y)(u0(1)*(y-y0)+u0(2)*(y1-y)+u0(3)*(y-y1)+u0(4)*(y0-y))/h;
                u_h2 = @(y)(u1(1)*(y-y2)+u1(2)*(y3-y)+u1(3)*(y-y3)+u1(4)*(y2-y))/h1;
                u_h = @(y) (u_h1(y)+u_h2(y))^2/h;
                eta = eta+h*myInt_1d(u_h,interval.y,opt);
            end
        end
    end
end