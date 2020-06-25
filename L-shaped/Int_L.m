function s = Int_L(N,u,opt)
%L型区域积分  
h = 2/N;
s = 0;
opt.tol = 1e-6;
if opt.err == 1
    f = @(x,y) power(x^2+y^2,1/3)*sin(2/3*mod(atan2(y,x),2*pi))*(1-x^2)*(1-y^2);
    g = @(x,y) (f(x,y)-interpolation_L(x,y,N,u))^2;    
    for j = 1:N/2
        for i = 1:N/2-2
            interval.x = [1-(j+1)*h,1-j*h];
            interval.y = [1-(i+1)*h,1-i*h];
            s = s+myint_2d(g,opt,interval);
        end
    end
    for j = N/2+1:N-2
        for i = 1:N-2
            interval.x = [1-(j+1)*h,1-j*h];
            interval.y = [1-(i+1)*h,1-i*h];
            s = s+myint_2d(g,opt,interval);
        end
    end
else
    
    for j = 1:N/2
        for i = 1:N/2-2
            interval.x = [1-(j+1)*h,1-j*h];
            interval.y = [1-(i+1)*h,1-i*h];
            r = @(x,y)sqrt(x^2+y^2); 
            theta =@(x,y) mod(atan2(y,x),2*pi);
            rn = @(x,y)[cos(theta(x,y)),sin(theta(x,y))]; rt = @(x,y)[-sin(theta(x,y)),cos(theta(x,y))];
            f = @(x,y) rn(x,y)*((2*sin((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/(3*r(x,y)^(1/3)) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))^2*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*sin(theta(x,y))^2*(r(x,y)^2*cos(theta(x,y))^2 - 1))+rt(x,y)*((2*r(x,y)^(2/3)*cos((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/3 - 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*cos(theta(x,y))^2 - 1))/r(x,y);
            g = @(x,y) norm((f(x,y)+interpolation_grad(x,y,N,u)),1)^2;
            s = s+myint_2d(g,opt,interval);
        end
    end
    for j = N/2+1:N-2
        for i = 1:N-2
            interval.x = [1-(j+1)*h,1-j*h];
            interval.y = [1-(i+1)*h,1-i*h];
            r = @(x,y)sqrt(x^2+y^2); 
            theta =@(x,y) mod(atan2(y,x),2*pi);
            rn = @(x,y)[cos(theta(x,y)),sin(theta(x,y))]; rt =@(x,y) [-sin(theta(x,y)),cos(theta(x,y))];
            f = @(x,y) rn(x,y)*((2*sin((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/(3*r(x,y)^(1/3)) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))^2*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(5/3)*sin((2*theta(x,y))/3)*sin(theta(x,y))^2*(r(x,y)^2*cos(theta(x,y))^2 - 1))+rt(x,y)*((2*r(x,y)^(2/3)*cos((2*theta(x,y))/3)*(r(x,y)^2*cos(theta(x,y))^2 - 1)*(r(x,y)^2*sin(theta(x,y))^2 - 1))/3 - 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*sin(theta(x,y))^2 - 1) + 2*r(x,y)^(8/3)*sin((2*theta(x,y))/3)*cos(theta(x,y))*sin(theta(x,y))*(r(x,y)^2*cos(theta(x,y))^2 - 1))/r(x,y);
            g = @(x,y) norm((f(x,y)+interpolation_grad(x,y,N,u)))^2;
            s = s+myint_2d(g,opt,interval);
        end
    end
end

