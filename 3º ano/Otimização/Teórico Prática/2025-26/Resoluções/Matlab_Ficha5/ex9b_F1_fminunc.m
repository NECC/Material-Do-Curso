
clear, clc, close all;
%format long;

%% problema
path(path,'Problemas')	% add path to directory with function 

options=optimoptions('fminunc','Display','iter','SpecifyObjectiveGradient',true,'HessianApproximation','steepdesc','MaxFunctionEvaluations',1000); 
%% F1
w0=[-1.2;1];   % ponto inicial
%% aplicar o fminunc
[wopt,Fopt,exitflag,output]=fminunc(@F1withgrad,w0,options)


