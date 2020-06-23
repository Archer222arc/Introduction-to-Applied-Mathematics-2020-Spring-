function L = myLDL(A,opt)
%分块,返回下三角部分
if nargin < 2
    opt.minima = 64;
    opt.subnumber = 32;
end
if ~isfield(opt,'minima');      opt.minima = 64;        end
if ~isfield(opt,'subnumber');   opt.subnumber = 32;     end

[m,n] = size(A);
if (n < opt.minima)
    for i = 1:n-1 
        A(i+1:n,i) = A(i+1:n,i)/A(i,i);
        A(i+1:n,i+1:n) = A(i+1:n,i+1:n)-A(i+1:n,i)*A(i,i+1:n);
    end
    L = triu(A)';
else
    subsize = ceil(n/opt.subnumber);
    for i = 1:subsize:n
        if i+subsize > n
            A(i:n,i:n) = myLDL(A(i:n,i:n),opt);
        else
            tmp = tril(myLDL(A(i:i+subsize-1,i:i+subsize-1),opt));
            A_res = (Tril_eq(tmp,A(i:i+subsize-1,i+subsize:n)))';
            A(i:n,i:i+subsize-1) = [tmp;A_res];
            A(i+subsize:n,i+subsize:n) = A(i+subsize:n,i+subsize:n) - A_res*A(i:i+subsize-1,i+subsize:n);
        end
    end
    L = tril(A);
end
