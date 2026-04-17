function [w_opt,Fval_opt,output]=BFGS_Armijo(F,Fwithgrad,H0,w0,epsilon,Kmax,gamma)
%
k=0;  %contador de iterações
wk=w0;
Hk=H0;
[Fk,gradk]=Fwithgrad(wk);
output=[];
while (k <= Kmax)
    norma=norm(gradk,inf);
    if (norma <= epsilon)
        [k wk' Fk gradk' etak norma]
        output=[output; k wk' Fk gradk' etak norma];
        break;
    end
    %direção de BFGS: resolver a equação sk=-Hk*gradk
    sk=-Hk*gradk;
    %% calcular eta com procura de Armijo com backtracking: F(wk+eta*sk)<=...
    etak= ArmijoBacktracking(F,Fk,gradk,wk,sk);
   
    %% para guardar informação
    output=[output;k wk' Fk gradk' etak norma]
    %% novo ponto w_k+1
    wt=wk;
    gradt=gradk;
    wk=wt+etak*sk;
    %% Atualização de Hk por BFGS
    %calcular F e grad no novo ponto wk
    [Fk,gradk]=Fwithgrad(wk);
    pk=wk-wt;
    yk=gradk-gradt;

    %estratégia skipping
    a=yk'*pk;
    b=yk'*Hk*yk;
  
    if (abs(a)>=gamma)
        a=abs(a);  %caso a>0 OK; SENÃO abs(a)
        Hk=Hk-(Hk*yk*pk'+pk*yk'*Hk)/a+(1+b/a)*(pk*pk')/a;
    end 
    k=k+1;
end
w_opt=wk;
Fval_opt=Fk;
end
