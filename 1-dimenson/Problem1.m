n = 10;
L = 1;
x = 0:L/n:L;
% 方程一
% f = @(x) exp(-100*(x-0.5)^2);
% opt.int = [0,1];
% opt.ka = [1e+6,0];
% opt.g = [0,0];
% opt.size = n;
% opt.solver = 'adap';
% if opt.solver == 'diff' ;handle_solver = @(f1,opt1) Unidimension_diff(f1,opt1); 
% elseif opt.solver == 'even';handle_solver = @(f1,opt1) Unidimension_even(f1,opt1);
% else handle_solver = @(f1,opt1) Unidimension_adap(f1,opt1);    
% end
% output = handle_solver(f,opt);
% x = output.x;
% u = output.u;
% [x1,k] = sort(x,'ascend');
% u1 = [];
% for i = 1:size(u);  u1(i) = u(k(i));    end
% plot(x1,u1,'--ro','LineWidth',0.1)
% grid on;
% set(gca, 'GridLineStyle', ':');  
% set(gca, 'GridAlpha',0.5);
% set(gca, 'XTick', 0:0.1:1);  
% set(gca, 'YTick', min(output.u):0.01:max(output.u));

% 方程二
% f = @(x) exp(-100*(x-0.5)^2);
% opt.ka = [1e+6,1e+5];
% opt.g = [0,0];
% opt.int = [0,1];
% opt.size = n;
% opt.L = L;
% opt.solver = 'adap';
% if opt.solver == 'diff' ;handle_solver = @(f1,opt1) Unidimension_diff(f1,opt1); 
% elseif opt.solver == 'even';handle_solver = @(f1,opt1) Unidimension_even(f1,opt1);
% else handle_solver = @(f1,opt1) Unidimension_adap(f1,opt1);    
% end
% output = handle_solver(f,opt);
% x = output.x;
% u = output.u;
% [x1,k] = sort(x,'ascend');
% u1 = [];
% for i = 1:size(u);  u1(i) = u(k(i));    end
% plot(x1,u1,'--ro','LineWidth',0.1)
% grid on;
% set(gca, 'GridLineStyle', ':');  
% set(gca, 'GridAlpha',0.5);
% set(gca, 'XTick', 0:0.1:1);  
% set(gca, 'YTick', min(output.u):0.01:max(output.u));
% 
% %方程三
f = @(x) 0.03*(x-6)^4;
opt.ka = [1e+6,0];
opt.int = [0,1];
opt.g = [-1,0];
opt.size = n;
opt.L = L;
opt.solver = 'adap';
opt.num = 80;
if opt.solver == 'diff' ;handle_solver = @(f1,opt1) Unidimension_diff(f1,opt1); 
elseif opt.solver == 'even';handle_solver = @(f1,opt1) Unidimension_even(f1,opt1);
else handle_solver = @(f1,opt1) Unidimension_adap(f1,opt1);    
end
output = handle_solver(f,opt);
x = output.x;
u = output.u;
[x1,k] = sort(x,'ascend');
u1 = [];
for i = 1:size(u);  u1(i) = u(k(i));    end
plot(x1,u1,'--or','LineWidth',0.1)
grid on;
set(gca, 'GridLineStyle', ':');  
set(gca, 'GridAlpha',0.5);
set(gca, 'XTick', 0:0.1:1);  
% set(gca, 'YTick', min(output.u):0.01:max(output.u));
