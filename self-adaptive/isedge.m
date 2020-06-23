function bool = isedge(x,y)
%检查是否为边界点
if nargin < 2
    c = x; x = c(1);y=c(2);
end
if abs(x) > 1 || abs(y) > 1;    bool = 0;
elseif x > 0 && y < 0; bool = 0;
elseif y == 0 && x >= 0;    bool = 1;       
elseif x == 1 && y >= 0;    bool = 1;
elseif y == 1 ;  bool = 1;
elseif x == -1; bool = 1;
elseif y == -1; bool = 1;
elseif x == 0 && y <= 0;    bool = 1;
else bool = 0;
end