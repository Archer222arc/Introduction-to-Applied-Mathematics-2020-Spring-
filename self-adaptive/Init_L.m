function U_0 = Init_L(N)
%单元长为2/N的拉普拉斯值
f = @(x,y) power(x^2+y^2,1/3)*sin(2/3*mod(atan2(y,x),2*pi))*(1-x^2)*(1-y^2);
% r = @(x,y)x^2+y^2;
% theta = @(x,y)mod(atan2(y,x),2*pi);
% f = @(r,theta)((2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(3*r^(1/3)) + 2*r^(5/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(5/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/r - ((4*r^(2/3)*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/9 - 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*cos(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1) + 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1) - 2*r^(8/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*sin(theta)^2 - 1) + 8*r^(14/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2 - (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*cos(theta)^2 - 1))/3 + (8*r^(8/3)*cos((2*theta)/3)*cos(theta)*sin(theta)*(r^2*sin(theta)^2 - 1))/3)/r^2 - (2*sin((2*theta)/3)*(r^2*cos(theta)^2 - 1)*(r^2*sin(theta)^2 - 1))/(9*r^(4/3)) + (14*r^(2/3)*sin((2*theta)/3)*cos(theta)^2*(r^2*sin(theta)^2 - 1))/3 + (14*r^(2/3)*sin((2*theta)/3)*sin(theta)^2*(r^2*cos(theta)^2 - 1))/3 + 8*r^(8/3)*sin((2*theta)/3)*cos(theta)^2*sin(theta)^2;
n = N*(N/2-1)/2+(N-1)*(N/2-1);
h = 2/N;
U_0 = zeros(n,1);
for j = 1:N/2
    for i = 1:N/2-1
        x = 1-j*h;  y = 1-i*h;
        r = sqrt(x^2+y^2);
        theta = mod(atan2(y,x),2*pi);
        U_0((j-1)*(N/2-1)+i) = f(r,theta);
    end
end
for j = N/2+1:N-1
    for i = 1:N-1
        x = 1-j*h;  y = 1-i*h;
        r = sqrt(x^2+y^2);
        theta = mod(atan2(y,x),2*pi);
        U_0((j-N/2-1)*(N-1)+i+N*(N/2-1)/2) = f(r,theta);
    end
end