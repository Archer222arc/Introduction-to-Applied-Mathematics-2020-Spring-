function [L,D] = myLDL(A,opt)
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
    L = tril(A,-1)+speye(n); D = diag(A);
else
    subsize = ceil(n/opt.subnumber);
    for i = 1:subsize:n
        if i+subsize > n
            [L,D] = myLDL(A(i:n,i:n),opt);
            A(i:n,i:n) = L; 
            for j = 1:n-i+1
                  A(j+i-1,j+i-1) = D(j);
            end
        else
            [L,D] = myLDL(A(i:i+subsize-1,i:i+subsize-1));
            A_res = Tril_eq(L,A(i:i+subsize-1,i+subsize:n))';
            A(i:i+subsize-1,i:i+subsize-1) = L;
            B = A_res;
            for j = 1:subsize
                 A_res(:,j) = A_res(:,j)/D(j);
                 A(i+j-1,i+j-1) = D(j);
            end
%             A_res = Triu_eq(L',A(i:i+subsize-1,i+subsize:n))';
%             A(i+subsize:n,i:i+subsize-1) = A_res*L;
            A(i+subsize:n,i:i+subsize-1) = A_res;
            A(i+subsize:n,i+subsize:n) = A(i+subsize:n,i+subsize:n) - B*A_res';
        end
    end
    L = tril(A,-1)+speye(n); D = diag(A);
end
