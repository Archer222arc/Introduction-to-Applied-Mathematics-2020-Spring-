function output = V_cycle_L(F,N,opt)
if ~isfield(opt,'tol'); opt.tol = 1e-8;     end
if ~isfield(opt,'recursive');   opt.recursive = 0;  end
if opt.recursive == 0;
    tic;
    l = norm(F);
%     x = (1:grid_size(2))'*opt.h;
%     y = (1:grid_size(1))'*opt.h;
    A = Generate_Dif_L(N);
    opt_SOR1.ite = 2;
    opt_SOR1.tol = opt.tol;
    opt_SOR1.theta = 1;
    output_SOR = mySOR(A,F,opt_SOR1);
    u = output_SOR.x;
    res = output_SOR.res;
    output.ite = 0;
    opt_sub.tol = opt.tol;
    opt_sub.recursive = 1;
    n = N/2;
    while norm(res)/l > opt.tol
       output.ite = output.ite+1;
       F_sub = coarse_down(res,N);
       output_sub = V_cycle_L(F_sub,n,opt_sub);
       u = u+coarse_up(output_sub.u,n);
       opt_SOR2.ite = 2;
       opt_SOR2.tol = opt.tol;
       opt_SOR2.theta = 1;
       output_SOR = mySOR(A,F,opt_SOR2,u);
       res = output_SOR.res;
       u = output_SOR.x;
    end
%     surf(x,y,reshape(u,grid_size));
%     shading interp;
%     drawnow;
else
    A = Generate_Dif_L(N);
    opt_SOR1.ite = 2;
    opt_SOR1.tol = opt.tol;
    opt_SOR1.theta = 1;
    output_SOR = mySOR(A,F,opt_SOR1);
    u = output_SOR.x;
    res = output_SOR.res;
    if N > 16
        n = N/2;
        opt_sub.tol = opt.tol;
        opt_sub.recursive = 1;
        F_sub = coarse_down(res,N);
        output_sub = V_cycle_L(F_sub,n,opt_sub);
        u = u+coarse_up(output_sub.u,n);
        opt_SOR2.ite = 2;
        opt_SOR2.tol = opt.tol;
        opt_SOR2.theta = 1;
        output_SOR = mySOR(A,F,opt_SOR2,u);
        res = output_SOR.res;
        u = output_SOR.x;
    end
end
output.u = u;
output.res = res;
if opt.recursive == 0;  output.cost = toc;  end