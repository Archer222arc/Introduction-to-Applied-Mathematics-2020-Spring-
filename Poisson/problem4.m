opt.h = 1/128;
opt.k = 1/512;
opt.time = 1/16;
U_0 = Init(opt.h);
grid_size = size(U_0);
vec_size = [prod(grid_size),1];
A = speye(prod(grid_size))-opt.k*Generate_Dif_2d(grid_size,opt.h);
U_Kron = reshape(U_0,vec_size);
opt.recursive = 0;
% output = Implicit(U_0,opt);
% output = myCN(U_0,opt);
% output_e = Explicit(U_0,opt);
% output = V_cycle(A,U_0,U_0,opt);
% output = myGS(A,U_Kron,opt,U_Kron);
output = Implicit_GS(U_0,opt);
% output = Implicit_Chol(U_0,opt);
U = reshape(output.u,[127,127]);