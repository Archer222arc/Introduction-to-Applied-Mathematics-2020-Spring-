function [L,D] = myLDL(A,opt)
%分块,返回下三角部分
if nargin < 2
    opt.minima = 64;
    opt.subnumber = 32;
    opt.solver = 1;
end
if ~isfield(opt,'minima');      opt.minima = 64;        end
if ~isfield(opt,'subnumber');   opt.subnumber = 32;     end
if ~isfield(opt,'solver');      opt.solver = 1;         end
if opt.solver == 1
   L = chol(A)';
   D = diag(L).^2;
   for i = 1:max(size(A))
      L(:,i) = L(:,i)/L(i,i);
   end
   return;
end
[m,n] = size(A);
if n < opt.minima
    for i = 1:n-1 
        A(i+1:n,i) = A(i+1:n,i)/A(i,i);
        A(i+1:n,i+1:n) = A(i+1:n,i+1:n)-A(i+1:n,i)*A(i,i+1:n);
    end
    L = tril(A,-1)+eye(n);
    D = diag(A);
else
    subsize = ceil(n/opt.subnumber);
    for i = 1:subsize:n
        if i+subsize > n
            [tmp,D] = myLDL(A(i:n,i:n),opt);
            tmp = tmp-eye(max(size(tmp)))+diag(D);
            A(i:n,i:n) = tmp;
        else
            [tmp,D] = myLDL(A(i:i+subsize-1,i:i+subsize-1),opt);
            A_res = (A(i:i+subsize-1,i:i+subsize-1)\A(i+subsize:n,i:i+subsize-1)')';
            A(i+subsize:n,i:i+subsize-1) = A_res;
            tmp = tmp+diag(D)-eye(subsize);
            A(i:i+subsize-1,i:i+subsize-1) = tmp;
            A(i+subsize:n,i+subsize:n) = A(i+subsize:n,i+subsize:n) - A_res*A_res';
        end
    end
    L = tril(A,-1)+eye(n);
    D = diag(A);
end
