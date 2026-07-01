
%%%%%%%%% run Algoritmo de Método da Penalidade Quadrática %%%%%%%%%%%%

clear all;
clc;
format short e

%--- Problema a resolver HS6: 
% solução ótima w* = [1;1] f*=0
n=2;
w0=[-1.2;1];

mu0=10;  %1; 10 
   

% Usar o Método de Penalidade Quadrática para resolver o problema 
% 1º definir e função de penalidade quadrática passar como input ao algoritmo
[wopt,Qopt,violation,output1] = MetodoPenalidadeQuadratica(@penaltyQ_HS6,@HS6,w0, mu0)


% Display the results
k=output1(end,1);

disp(['Number of the subproblems solved:', num2str(k)]);
disp('Optimal Solution:'); 
wopt=wopt'
%calcular f e as restrições na solução ótima
[fopt,c_opt,ceq_opt]=HS6(wopt')
%mostar o valor da função de penalidade quadrática em wopt e a violação
disp(['Qopt = ', num2str(Qopt)]);
disp (['violation value = ', num2str(violation)]);






