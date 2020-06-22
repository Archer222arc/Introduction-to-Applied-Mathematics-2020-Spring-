function output = Implicit_GS(U_0,opt)
%G-S����ʽ����
tic;
if ~isfield(opt,'h');   opt.h = 1/128;                      end
if ~isfield(opt,'k');   opt.k = 1/512;                      end
if ~isfield(opt,'tol'); opt.tol = 1e-6;                     end
if ~isfield(opt,'time');opt.time = 1/16;                     end
grid_size = size(U_0);
vec_size = [prod(grid_size),1];
U_kron = reshape(U_0,vec_size);
A = speye(prod(grid_size))-opt.k*Generate_Dif_2d(grid_size,opt.h);
u = U_kron;
x = (1:grid_size(2))'*opt.h;
y = (1:grid_size(1))'*opt.h;
opt.ite = 100000;
for i = 1 : floor(opt.time/opt.k)
    output_sub = myGS(A,u,opt,u);
    u = output_sub.x;
    surf(x,y,reshape(u,grid_size));
    shading interp;
    drawnow;
end
output.u = u;
output.U = reshape(u,grid_size);
output.cost = toc;