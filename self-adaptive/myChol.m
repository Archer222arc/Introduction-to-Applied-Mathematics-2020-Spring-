function L = myChol(A,opt)
%·Ö¿é
if nargin < 2
    opt.minima = 64;
    opt.subnumber = 32;
end
if ~isfield(opt,'minima');      opt.minima = 64;        end
if ~isfield(opt,'subnumber');   opt.subnumber = 32;     end

[m,n] = size(A);
if (n < opt.minima);    L = chol(A)';    
else
    subsize = ceil(n/opt.subnumber);
    for i = 1:subsize:n
        if i+subsize > n
            A(i:n,i:n) = myChol(A(i:n,i:n),opt);
        else
            tmp = tril(myChol(A(i:i+subsize-1,i:i+subsize-1),opt));
            A_res = (Tril_eq(tmp,A(i:i+subsize-1,i+subsize:n)))';
            A(i:n,i:i+subsize-1) = [tmp;A_res];
            A(i+subsize:n,i+subsize:n) = A(i+subsize:n,i+subsize:n) - A_res*A_res';
        end
    end
    L = tril(A);
end
