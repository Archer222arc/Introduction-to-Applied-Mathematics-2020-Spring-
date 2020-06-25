% err = zeros(7,3);
% for i = 3:7
%     N = 2^i;
    N = 128;
    opt.h = 1/N;
    opt.k = 1/512;
%     opt.k = 1/(4*N^2);
    opt.time = 1;
%     n = N-1;
    U_0 = Init(opt.h);
    grid_size = size(U_0);
    vec_size = [prod(grid_size),1];
    A = speye(prod(grid_size))-opt.k*Generate_Dif_2d(grid_size,opt.h);
%     U_Kron = reshape(U_0,vec_size);
%     opt.recursive = 0;
%     f=@(x,y)exp(-2*pi.^2).*sin(pi*x).*sin(pi*y);
%     output = Implicit(U_0,opt);    
    tic;
%     output = V_cycle(A,U_0,U_0,opt);    
%     output = Implicit_Chol(U_0,opt);
      output = Implicit_GS(U_0,opt);
    cost = toc;
%     output = myGS(A,U_Kron,opt,U_Kron);
  

    % U = reshape(output.u,[n,n]);
%     U1 = zeros(n+2,n+2);
%     U1(2:n+1,2:n+1) = U;
%     x = (1:grid_size(2)+2)'*opt.h;
%     y = (1:grid_size(1)+2)'*opt.h;    
%     output = Explicit(U_0,opt);
%     U = output.U;
%     err(i,1) = relative_err(f,U).e1;
%     output = Implicit(U_0,opt);
%     U = output.U;
%     err(i,2) = relative_err(f,U).e1;
%     output = myCN(U_0,opt);
%     U = output.U;
%     err(i,3) = relative_err(f,U).e1;
%     surf(x,y,reshape(U1,grid_size+2));
%     shading interp;
%     drawnow;
% end