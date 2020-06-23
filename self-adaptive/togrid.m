function u = togrid(x,y,N)
%把坐标转化为矩阵形式，(1-h,1-h) -> (1,1)
h = 2/N;
j = floor((1-x)/h);
i = floor((1-y)/h);
u  =[i,j];