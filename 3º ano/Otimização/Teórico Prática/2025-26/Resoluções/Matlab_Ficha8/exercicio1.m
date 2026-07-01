
clear, clc, close all;
%format long;


options=optimoptions('fminunc','Display','iter'); 
% exercício1 dos slides 

w0=[0;0];   % ponto inicial


mu=1  
% aplicar o fminunc
[wopt,Qopt,exitflag,output]=fminunc(@(w)penaltyQ_P1(w,mu),w0,options)

mu=10  
% aplicar o fminunc
[wopt,Qopt,exitflag,output]=fminunc(@(w)penaltyQ_P1(w,mu),w0,options)

mu=100  
% aplicar o fminunc
[wopt,Qopt,exitflag,output]=fminunc(@(w)penaltyQ_P1(w,mu),w0,options)

mu=1000 
% aplicar o fminunc
[wopt,Qopt,exitflag,output]=fminunc(@(w)penaltyQ_P1(w,mu),w0,options)

