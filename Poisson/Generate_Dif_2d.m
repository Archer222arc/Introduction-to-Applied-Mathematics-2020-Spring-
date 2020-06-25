function Dif = Generate_Dif_2d(matrix_size,h)
%生成二维的差分矩阵
%matrix_size为向量
m = matrix_size(1);
n = matrix_size(2);
Dif = kron(Generate_Dif_1d(n),speye(m))+kron(speye(n),Generate_Dif_1d(m));
Dif = Dif/h^2;