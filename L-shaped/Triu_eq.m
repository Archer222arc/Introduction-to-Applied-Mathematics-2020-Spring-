function x = Triu_eq(A,b,opts)
%用分块法解上三角矩阵方程 Ax=b,默认A是方阵
if nargin < 3; opts = {};                                     end
if ~isfield(opts,'minima'); opts.minima = 64;                 end
if ~isfield(opts,'subnumber'); opts.subnumber = 16;           end

[m,n] = size(A);
subsize = ceil(n/opts.subnumber);
if n < opts.minima
    b = A\b;
else
    for i = n : -subsize : 1
        if i - subsize <= 0
            b(1:i,:) = Triu_eq(A(1:i,1:i),b(1:i,:),opts);
        else
            b(i-subsize+1:i,:) = Triu_eq(A(i-subsize+1:i,i-subsize+1:i),b(i-subsize+1:i,:),opts);
            b(1:i-subsize,:) = b(1:i-subsize,:)-A(1:i-subsize,i-subsize+1:i)*b(i-subsize+1:i,:);
        end
    end
end
x = b;
