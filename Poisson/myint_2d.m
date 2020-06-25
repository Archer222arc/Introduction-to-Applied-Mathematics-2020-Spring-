function I = myint_2d(f,opt,interval)
% 2维二重积分
if ~isfield(opt,'tol');     opt.tol = 1e-6;             end
if ~isfield(opt,'solver');  opt.solver = 1;             end
if opt.solver == 1
    I = integral2(f,interval.x(1),interval.x(2),interval.y(1),interval.y(2),'RelTol',opt.tol);
    return
end
g = @(x)myInt_1d(@(y)feval(f,x,y),interval.y,opt);
I = myInt_1d(g,interval.x,opt);
