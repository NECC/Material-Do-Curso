
%%%%%%%%% run Algoritmo de Método da Penalidade Quadrática %%%%%%%%%%%%

clear all;
clc;
format short e

%--- Problema a resolver HS32: 
% solução ótima w* =[0;0;1]  f*=1
n=3;
w0=[0.1;0.7;0.2];

mu0=10;  %1; 10 
   

% Usar o Método de Penalidade Quadrática para resolver o problema 
% 1º definir e função de penalidade quadrática passar como input ao algoritmo
[wopt,Qopt,violation,output1] = MetodoPenalidadeQuadratica(@penaltyQ_HS32,@HS32,w0, mu0)


% Display the results
k=output1(end,1);

disp(['Number of the subproblems solved:', num2str(k)]);
disp('Optimal Solution:'); 
wopt=wopt'
%calcular f e as restrições na solução ótima
[fopt,c_opt,ceq_opt]=HS32(wopt')
%mostar o valor da função de penalidade quadrática em wopt e a violação
disp(['Qopt = ', num2str(Qopt)]);
disp (['violation value = ', num2str(violation)]);






