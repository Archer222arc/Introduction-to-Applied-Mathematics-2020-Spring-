function output = Explicit(U_0,opt)
%œ‘ Ω∏Ò Ω
tic;
if ~isfield(opt,'h');       opt.h = 1/128;         end
if ~isfield(opt,'k');       opt.k = 1/512;        end
if ~isfield(opt,'time');    opt.time = 1/16;       end
grid_size = size(U_0);
vec_size = [prod(grid_size),1];
x = (1:grid_size(2))'*opt.h;
y = (1:grid_size(1))'*opt.h;
U_kron = reshape(U_0,vec_size);
Dif = Generate_Dif_2d(grid_size,opt.h);
for i = 1 : floor(opt.time/opt.k)
    U_kron = U_kron+opt.k*(Dif*U_kron);
    surf(x,y,reshape(U_kron,grid_size));
    shading interp;
    drawnow;
end
output.cost = toc;
output.U = reshape(U_kron,grid_size);