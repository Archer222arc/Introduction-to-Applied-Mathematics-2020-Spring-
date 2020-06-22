function output = V_cycle(A,U_0,F,opt)
% V-cycle
if ~isfield(opt,'h');   opt.h = 1/128;                      end
if ~isfield(opt,'k');   opt.k = 1/512;                      end
if ~isfield(opt,'tol'); opt.tol = 1e-6;                     end
if ~isfield(opt,'time');opt.time = 1/16;                     end
% if ~isfield(opt,'recursive');opt.recursive = 1;             end
grid_size = size(U_0);
vec_size = [prod(grid_size),1];
U_kron = reshape(U_0,vec_size);
% A = speye(prod(grid_size))-opt.k*Generate_Dif_2d(grid_size,opt.h);
u = U_kron;
if opt.recursive < 1
    tic;
    output.ite = 0;
    x = (1:grid_size(2))'*opt.h;
    y = (1:grid_size(1))'*opt.h;
    for i = 1 : floor(opt.time/opt.k)
        res = norm(A*u-u);
        opt_GS.ite = 2;
        opt_GS.tol = opt.tol;
        output_sub = myGS(A,u,opt_GS,u);
        res_sub = 1;
        while res_sub > opt.tol
            output.ite = output.ite+1;
            I = Init_I(grid_size);
            F_sub = I*output_sub.res;
            opt_sub.h = opt.h*2;
            opt_sub.k = opt.k;
            opt_sub.tol = opt.tol;
            opt_sub.recursive = 1;
            U_0_sub = zeros(floor((grid_size/2)));
            u_sub = output_sub.x+4*I'*V_cycle(A,U_0_sub,F_sub,opt_sub).u;
            opt_GS_sub.ite = 2;
            opt_GS_sub.tol = opt.tol;
            output_sub = myGS(A,u,opt_GS_sub,u_sub);
            res_sub = norm(output_sub.res)/res;
        end
        u = output_sub.x;
        surf(x,y,reshape(u,grid_size));
        shading interp;
        drawnow;
    end
else
    grid_size = 2*grid_size+1;
    opt_GS.ite = 2;
    opt_GS.tol = opt.tol;
    I = Init_I(grid_size);
    A = 4*I*A*I';
    output_sub = myGS(A,F,opt_GS,u);
    if grid_size(1) > 8        
        grid_size = (grid_size-1)/2;
        I = Init_I(grid_size);
        F_sub = I*output_sub.res;
        opt_sub.h = opt.h*2;
        opt_sub.k = opt.k;
        opt_sub.tol = opt.tol;
        opt_sub.recursive = opt.recursive+1;
        m = (grid_size(1)-1)/2;
        U_0_sub = zeros(m);
        u_sub = output_sub.x+4*I'*V_cycle(A,U_0_sub,F_sub,opt_sub).u;
        opt_GS_sub.ite = 2;
        opt_GS_sub.tol = opt.tol;
        output_sub = myGS(A,F,opt_GS_sub,u_sub);
    end
end
output.u = output_sub.x;
output.res = output_sub.res;
if opt.recursive < 1   
    output.cost = toc;  
end