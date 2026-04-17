function [etak] = ArmijoBacktracking(Fun,Fk,gradk,wk,sk)

%
%% parâmetros
c=0.0001; 
rho=0.5;
%% valor inicial
eta0=1;  
%%
eta=eta0;
waux=wk+eta*sk;
Faux=Fun(waux);
while (Faux>Fk+c*eta*(gradk'*sk))
    eta=rho*eta;
    waux=wk+eta*sk;
    Faux=Fun(waux);
end
etak=eta;
end
