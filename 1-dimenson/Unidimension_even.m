function output = Unidimension_even(f,opt,bound)
%均匀剖分有限元

n = opt.size;
I_0 = opt.int(1);
I_L = opt.int(2);
h = (I_L-I_0)/n;
if nargin < 3
%     tic;
    ka_0 = opt.ka(1);
    ka_L = opt.ka(2);
    g_0 = opt.g(1);
    g_L = opt.g(2);
    A = -h*Generate_Dif_1d(n+1,h);
    A(1,1) = A(1,1)/2+ka_0;
    A(n+1,n+1) = A(n+1,n+1)/2+ka_L;
    b = zeros(n+1,1);
    % b(1) = int(g,x,[0,h])+ka_0*g_0;
    % b(n+1) = int(g,x,[1-h,1])+ka_L*g_L;
    b(1) = (f(I_0)+f(h))*h/2+ka_0*g_0;
    b(n+1) = (f(I_L)+f(I_L-h))*h/2+ka_L*g_L;
    for i = 2:n; b(i) = (f(I_0+(i-2)*h)+4*f(I_0+(i-1)*h)+f(I_0+i*h))*h/6;   end
    u = A\b;
else
    A = -h*Generate_Dif_1d(n-1,h);
    b = zeros(n-1,1);
    for i = 1:n-1; b (i) = (f(I_0+(i-1)*h)+4*f(I_0+i*h)+f(I_0+(i+1)*h))*h/6;    end
    b(1) = b(1)+bound(1)/h;
    b(n-1) = b(n-1)+bound(2)/h;
    u = A\b;
    u = [bound(1);u;bound(2)];
end
% if nargin < 3
% fprintf('cost time \t:%2.1f sec\n',toc);
% output.cost = toc;
output.u = u;
output.x = I_0:h:I_L;
output.x = output.x';