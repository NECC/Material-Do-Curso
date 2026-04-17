function [w_opt,Fval_opt,output]=MN_eta1(FwithgradHess,w0,epsilon,Kmax)
%

k=0;  %contador de iterações
wk=w0;
output=[];
etak=1; %sempre constante
while (k <= Kmax)
    [Fk,gradk,hessk]=FwithgradHess(wk);
    norma=norm(gradk,inf);
    if (norma <= epsilon)
        output=[output; k wk' Fk gradk' etak norma];
        break;
    end
    %direção de Newton: resolver o sistema hessk*sk=-gradk
    sk=-hessk\gradk;
    %% sempre etak=1  
    %% para output
     output=[output;k wk' Fk gradk' etak norma];
    %% novo ponto
    wk=wk+etak*sk;
    k=k+1;
end
 w_opt=wk;
 Fval_opt=Fk;
end
