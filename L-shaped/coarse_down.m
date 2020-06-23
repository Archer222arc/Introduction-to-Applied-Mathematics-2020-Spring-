function u = coarse_down(u_0,N)
%生成N/2的小L型网格
n = N/2;
u = zeros(n/2*(n/2-1)+(n-1)*(n/2-1),1);
for j = 1:n/2
    for i = 1:n/2-1
        k = (N-2)*(j-1)+2*i+N/2-1;
        u((j-1)*(n/2-1)+i) = 1/4*(u_0(k)+(u_0(k-1)+u_0(k+1)+u_0(k+n-1)+u_0(k-n+1))/2+(u_0(k-n)+u_0(k-n+2)+u_0(k+n)+u_0(k+n-2))/4);
    end
end
for j = n/2+1:n-1
    for i = 1:n-1
        k = (j-n/2-1)*(2*N-2)+2*i+N-1+(N/2-1)*N/2;
        u((j-n/2-1)*(n-1)+i+(n/2-1)*n/2) = 1/4*(u_0(k)+(u_0(k-1)+u_0(k+1)+u_0(k-N+1)+u_0(k+N-1))/2+(u_0(k-N)+u_0(k-N+2)+u_0(k+N)+u_0(k+N-2))/4);
    end
end