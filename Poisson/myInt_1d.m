function I = myInt_1d(f,interval,opt)
% 1维自适应积分
if ~isfield(opt,'tol');     opt.tol = 1e-6;            end
if ~isfield(opt,'solver');  opt.solver = 2;            end
if opt.solver == 1
    I = integral(f,interval(1),interval(2),'RelTol',opt.tol);
    return;
end
I_0 = interval(1);   I_1 = interval(2);
L = I_1-I_0;
Int{1} = (f(I_0)+f(I_1))*L/2;
k = 1;
while k < 10
    s = 0;
    for i = 1:2:2^k;    s = s+f(I_0+L*i/2^k);           end
    Int{k+1} = s*L/2^k+Int{k}/2;
    I = Int{k+1};
    if abs(Int{k+1}-Int{k}) < opt.tol*abs(Int{k+1});    break;  end
    k = k+1;
end
