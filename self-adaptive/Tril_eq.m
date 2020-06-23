function x = Tril_eq(A,b,opts)
%用分块法解下三角矩阵方程 Ax=b,默认A是方阵
if nargin < 3; opts = {};                                              end
if ~isfield(opts,'minima');    opts.minima = 64;                       end
if ~isfield(opts,'subnumber'); opts.subnumber = 16;   end

[m,n] = size(A);
subsize = ceil(n/opts.subnumber);
if n < opts.minima
    b = A\b;
else
    for i = 1 : subsize : n
        if  i+subsize > n
            b(i:n,:) = Tril_eq(A(i:n,i:n),b(i:n,:),opts);
        else
            b(i:i+subsize-1,:) = Tril_eq(A(i:i+subsize-1,i:i+subsize-1),b(i:i+subsize-1,:),opts);
            b(i+subsize:n,:) = b(i+subsize:n,:)-A(i+subsize:n,i:i+subsize-1)*b(i:i+subsize-1,:);
        end
    end
end
x = b;