
clear, clc, close all;
%format long;

%% problema
path(path,'Problemas')	% add path to directory with function 

%% F8
H0 = eye(2);
w0=[1;-1];   % ponto inicial
%%
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
gamma=1.e-12;
%% aplicar o algoritmo Método BFGS + estratégia skkiping + procura de Armijo com backtracking
[wopt,Fopt,output]=BFGS_Armijo(@F8,@F8withgrad,H0,w0,epsilon,Kmax,gamma)

