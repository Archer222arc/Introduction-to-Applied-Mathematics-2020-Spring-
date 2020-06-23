function I = myInt_1d(f,interval,opt)
% 1维自适应积分
if ~isfield(opt,'tol');     opt.tol = 1e-6;            end
I_0 = interval(1);   I_1 = interval(2);
L = I_1-I_0;
I= (f(I_0)+4*f((I_0+I_1)/2)+f(I_1))*L/6;


