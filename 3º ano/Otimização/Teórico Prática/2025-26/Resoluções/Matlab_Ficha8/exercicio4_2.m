
%%%%%%%%% run Algoritmo de Método da Penalidade L1 %%%%%%%%%%%%

clear all;
clc;
format short e

%--- Problema a resolver P2: 
% solução ótima w* = [0;0;1] f*=1
n=3;
w0=[0;0;0];

mu0=1;  %1; 10 
   

% Usar o Método de Penalidade L1 para resolver o problema 
% 1º definir e função de penalidade L1 passar como input ao algoritmo
[wopt,penL1opt,violation,output1] = MetodoPenalidadeL1(@penaltyL1_P2,@P2, w0, mu0)


% Display the results
k=output1(end,1);

disp(['Number of the subproblems solved:', num2str(k)]);
disp('Optimal Solution:'); 
wopt=wopt'
%calcular f e as restrições na solução ótima
[fopt,c_opt,ceq_opt]=P2(wopt')
%mostar o valor da função de penalidade L1 em wopt e a violação
disp(['penL1opt = ', num2str(penL1opt)]);
disp (['violation value = ', num2str(violation)]);






