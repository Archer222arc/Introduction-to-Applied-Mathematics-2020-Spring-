function I = myint_2d(f,opt,interval)
% 2维二重积分
if ~isfield(opt,'tol');     opt.tol = 1e-6;             end
g = @(x)myInt_1d(@(y)feval(f,x,y),interval.y,opt);
I = myInt_1d(g,interval.x,opt);