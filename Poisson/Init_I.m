function I = Init_I(size)
% Ã·…˝æÿ’Û
m = size(1);    n = size(2);
% weighted_matrix = [1/16,1/8,1/16;1/8,1/4,1/8;1/16,1/8,1/16];
u_1 = ones(m,1);    u_1(2:2:m) = 0;
u_2 = ones(m,1);    u_2(1:2:m) = 0;
v_1 = ones(n,1);    v_1(2:2:m) = 0;
v_2 = ones(n,1);    v_2(1:2:m) = 0;
% I_1 = kron(spdiags(u_2,-1,m,m),weighted_matrix(1,1))+kron(spdiags(u_2,1,m,m),weighted_matrix(1,3))+kron(spdiads(u_1,0,m,m),weighted_matrix(1,2));
I_1 = kron(spdiags(u_1,-1,m,m),1/16)+kron(spdiags(u_1,1,m,m),1/16)+kron(spdiags(u_2,0,m,m),1/8);
I_2 = kron(spdiags(u_1,-1,m,m),1/8)+kron(spdiags(u_1,1,m,m),1/8)+kron(spdiags(u_2,0,m,m),1/4);
I_3 = kron(spdiags(u_1,-1,m,m),1/16)+kron(spdiags(u_1,1,m,m),1/16)+kron(spdiags(u_2,0,m,m),1/8);
I = sparse(kron(spdiags(v_1,1,n,n),I_1)+kron(spdiags(v_1,-1,n,n),I_3)+kron(spdiags(v_2,0,n,n),I_2));
Indicator = logical(kron(v_2,u_2));
I = I(Indicator,:);
