function U_0 = Init(h);
n = 1/h-1;
U_0 = zeros(n);
for i = 1:n
    for j = 1:n
        U_0(i,j) = sin(pi*i*h)*sin(pi*j*h);
    end
end