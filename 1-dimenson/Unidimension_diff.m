function output = Unidimension_diff(f,opt)
%Ò»Î¬²î·Ö
tic;

ka_0 = opt.ka(1);
ka_L = opt.ka(2);
g_0 = opt.g(1);
g_L = opt.g(2);
n = opt.size;
h = opt.L/n;
A = Generate_Dif_1d(n+1,h);
A(1,1) = h*A(1,1)/2-ka_0;
A(1,2) = h*A(1,2);
A(n+1,n+1) = -h*A(n+1,n+1)/2+ka_L;
A(n+1,n) = -h*A(n+1,n);
b = zeros(n+1,1);   
b(1) =  -g_0*ka_0;
b(n+1) = g_L*ka_L;
for i = 2:n-1;    b(i) = -f((i-1)*h);             end
u = A\b;
fprintf('cost time \t:%2.1f sec\n',toc);
output.x = 0:h:1;
output.cost_time = toc;
output.u = u;
