function output = myGS(A,b,opt,x_0)
% Gauss-Seidel
[m,n] = size(A);
if nargin < 4;    x_0 = zeros(n,1);             end
if ~isfield(opt,'tol');     opt.tol = 1e-6;     end
if ~isfield(opt,'ite');     opt.ite = 500;      end
L = tril(A);
U = -triu(A,1);
x = x_0;
g = Tril_eq(L,b);
y = U*x;
res = b-A*x;
l = norm(res);
for i = 1:opt.ite
    x = Tril_eq(L,U*x)+g;
    res = -y;
    y = U*x;
    res = res+y;
    if norm(res)/l < opt.tol 
        output.step = i;
        output.x = x;
        output.res = res;
        return;
    end
end
output.x = x;
output.res = res;
output.ite = opt.ite;
