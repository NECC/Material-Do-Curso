
clear, clc, close all;
%format long;

%% problema
path(path,'Problemas')	% add path to directory with function 

%% F5
H0 = eye(3);
w0=[0;0;0];   % ponto inicial
%%
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
gamma=1.e-12;
%% aplicar o algoritmo Método BFGS + estratégia skkiping + procura de Armijo com backtracking
[wopt,Fopt,output]=BFGS_Armijo(@F5,@F5withgrad,H0,w0,epsilon,Kmax,gamma)

