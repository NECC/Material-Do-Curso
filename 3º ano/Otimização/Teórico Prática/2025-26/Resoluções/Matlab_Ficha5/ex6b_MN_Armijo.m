
clear, clc, close all;
%format long;
path(path,'Problemas')	% add path to directory with function 

%% F12
w0=[1;1];   % ponto inicial
%% para o critério de paragem
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
%% aplicar o algoritmo Método de Newton com procura de Armijo com backtracking
[w_opt,Fval_opt,output]=MN_Armijo(@F12,@F12withgradHess,w0,epsilon,Kmax)

%% gráfico das curvas de nível de F
% criar grelha de pontos
 [w1,w2] = meshgrid(-2.5:0.01:2.5, -3:0.01:3);
 vals_F = sqrt(w1.^2+1)+sqrt(w2.^2+1);
% contornos
figure
contour(w1,w2,vals_F,10);
colorbar;

xlabel('w_1');
ylabel('w_2');
hold on
%trajetória dos pontos wk obtidos pelo algoritmo
vals_w1=output(:,2);
vals_w2=output(:,3);
plot(vals_w1, vals_w2,'ro-','LineWidth',1,'MarkerFaceColor','r','MarkerSize', 4);
plot(w_opt(1),w_opt(2),'ko-','LineWidth',0.5,'MarkerFaceColor','r');
text(vals_w1(1), vals_w2(1)+0.2,'w0')
text(vals_w1(end), vals_w2(end)+0.2,'w*')
title('Pontos gerados pelo MN e trajetória')
grid on

