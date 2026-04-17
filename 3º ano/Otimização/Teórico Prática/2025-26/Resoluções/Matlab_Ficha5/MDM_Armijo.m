function [w_opt,Fval_opt,output]=MDM_Armijo(F,Fwithgrad,w0,epsilon,Kmax)
%

k=0;  %contador de iterações
wk=w0;
output=[];
while (k <= Kmax)
    [Fk,gradk]=Fwithgrad(wk);
    norma=norm(gradk,inf);
    if (norma <= epsilon)
        output=[output; k wk' Fk gradk' etak norma];
        break;
    end
    %direção
    sk=-gradk;
    %% calcular eta com procura de Armijo com backtracking: F(wk+eta*sk)<=...
    etak= ArmijoBacktracking(F,Fk,gradk,wk,sk);
   
    %% para guardar informação
    output=[output;k wk' Fk gradk' etak norma];
    
    %% novo ponto
    wk=wk+etak*sk;
    k=k+1;
end
w_opt=wk;
Fval_opt=Fk;
end


