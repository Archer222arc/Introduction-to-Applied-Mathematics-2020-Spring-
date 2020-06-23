function output = mySOR(A,b,opt,x_0)
%³¬ËÉ³Úµü´ú·¨
tic;
[m,n] = size(A);
if nargin < 4;      x_0 = zeros(n,1);           end
if ~isfield(opt,'ite'); opt.ite = 100;              end
if ~isfield(opt,'tol'); opt.tol = 1e-8;             end
if ~isfield(opt,'theta');opt.theta = 1.5;           end
L = -tril(A,-1);
U = -triu(A,1);
D = diag(diag(A));
L_theta = D-opt.theta*L;
x = x_0;
g = opt.theta*(L_theta\b);
U_theta = (1-opt.theta)*D+opt.theta*U;
y = U_theta*x;
res = b-A*x;
l = norm(res);
for i = 1:opt.ite
    x = L_theta\y+g;
    res = -y;
    y = U_theta*x;
    res = res+y;
    if norm(res)/l < opt.tol
        output.step = i;
        output.x = x;
        output.res = b-A*x;
        output.cost = toc;
        return;
    end
end
output.x = x;
output.res = b-A*x;
output.step = opt.ite;
output.cost = toc;