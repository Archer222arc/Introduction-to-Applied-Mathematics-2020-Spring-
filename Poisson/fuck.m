M = 10;
ld = 0.1;
E = reshape(U_0,vec_size);
U1 = E;
for i = 1 : M
    E(1) = 4 * U1(1) - (U1(2) + U1(N));
    for j = 2 : N-2
        E(j) = 4 * U1(j) - (U1(j-1) + U1(j+1) + U1(j+N-1));
    end
    E(N-1) = 4 * U1(N-1) - (U1(N-2) + U1(2*N-2));
    for k = 2 : N-2
        t = (k-1)*(N-1);
        E(t+1) = 4 * U1(t+1) - (U1(t+2) + U1(t+N) + U1(t-N+2));
        for j = t+2 : t+N-2
            E(j) = 4 * U1(j) - (U1(j-1) + U1(j+1) + U1(j+N-1) + U1(j-N+1));
        end
        E(t+N-1) = 4 * U1(t+N-1) - (U1(t+N-2) + U1(t+2*N-2) + U1(t));
    end    
    t = (N-2)*(N-1);
    E(t+1) = 4 * U1(t+1) - (U1(t+2) + U1(t-N+2));
    for j = t+2 : t+N-2
        E(j) = 4 * U1(j) - (U1(j-1) + U1(j+1) + U1(j-N+1));
    end
    E(t+N-1) = 4 * U1(t+N-1) - (U1(t+N-2) + U1(t));
    U1 = U1 - ld * E;
end