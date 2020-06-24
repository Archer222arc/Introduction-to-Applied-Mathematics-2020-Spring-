% grid = zeros(9,2);
% for i = 1:3
%     for j = 1:3
%         grid(i+j*3-3,:) = toreal(i,j,4);
%     end
% end
% m = [];
% for i = 1:9
%     if isinregion(grid(i,1),grid(i,2))
%         m = [m;i];
%     end
% end
t = 0;
grid = [];
for i = 1 :31
    for j = 1:31
        if isinregion(1-i/16,1-j/16)
            t = t+1;
            grid(t,:) = [1-i/16,1-j/16];
        end
    end
end
[L,u] = Generate_Dif_adap(grid);
v = L\u';
% a = zeros(4,1);
%  for i = 1:4
%     a(i) = find(ismember(grid,un(i,:),'rows'));
%     if a(i) == 0;   u0(i) = 0;  
%     else u0(i) = 1;
%     end
% end