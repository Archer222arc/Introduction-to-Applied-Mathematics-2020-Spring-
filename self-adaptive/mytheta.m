function t = mytheta(x,y);
%½Ç¶È
if x == 0 && y > 0
    t = pi/2;
elseif x == 0 && y < 0
    t = 3/2*pi;
else
    t=mod(atan2(y,x),2*pi);
end