function output = Unidimension_adap(f,opt,bound)
%一维自适应有限元
if ~isfield(opt,'num')
    if ~isfield(opt,'tol'); opt.tol = 1e-2;                 end
    tol = opt.tol;
    num = opt.num;
    n = opt.size;
    I_0 = opt.int(1);
    I_L = opt.int(2);
    h = (I_L-I_0)/n;
    if nargin < 3
        tic;
        output = Unidimension_even(f,opt);
    %     fprintf('fukc');
    else    
        output = Unidimension_even(f,opt,bound);
    end
    x = I_0:h:I_L;
    tmp_u = [];
    tmp_x = [];
    for i = 1:n
        if (f(x(i))+f(x(i+1)))*h/2 > tol
            opt_sub.int = [x(i),x(i+1)];    
            opt_sub.size = 2;
            opt_sub.recursive = 1;
            bound = [output.u(i),output.u(i+1)];
            output_sub = Unidimension_adap(f,opt_sub,bound);
            tmp_u = [tmp_u;output_sub.u];
            tmp_x = [tmp_x;output_sub.x];
        end
    end
    if ~isempty(tmp_x) && ~isempty(tmp_u)
        output.u = [output.u;tmp_u];
        output.x = [output.x;tmp_x];
    end
    if nargin < 3   
        output.cost = toc;
        fprintf('cost time \t:%2.1f sec\n',toc);
    end
else
    output = Unidimension_even(f,opt);
    u = output.u;
    x = output.x;
    num = opt.num-opt.size;
    while num > 0
        tmp_u = [];
        tmp_x = [];
        err = [];
        k = max(size(x));
        for i = 1 : k-1
            err(i) = (f(x(i))+f(x(i+1)))*(x(i+1)-x(i))/2;
        end
        if num < 4; num_ad = num;      else num_ad = 4;    end;
        [x1,t] = sort(err,'descend');
        for i = 1 : num_ad
            opt_sub.int = [x(t(i)),x(t(i)+1)];
            opt_sub.size = 2;
            bound = [u(t(i)),u(t(i)+1)];
            output_sub = Unidimension_even(f,opt_sub,bound);
            tmp_u = [tmp_u;output_sub.u(2)];
            tmp_x = [tmp_x;(x(t(i))+x(t(i)+1))/2];
        end
        u = [u;tmp_u];
        x = [x;tmp_x];
        [x,k] = sort(x,'ascend');
        u1 = u;
        for i = 1:size(u);  u(i) = u1(k(i));     end
        num = num-num_ad;
    end
    output.u = u;
    output.x = x;
    if nargin < 3   
        output.cost = toc;
        fprintf('cost time \t:%2.1f sec\n',toc);
    end
end