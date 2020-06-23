function u = toreal(i,j,N)
%把(1-h,1-h)转化为(1,1)
h = 2/N;
x = 1-j*h;
y = 1-i*h;
u = [x,y];