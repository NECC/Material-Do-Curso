
clear, clc, close all;
%format long;
%% problema
path(path,'Problemas')	% add path to directory with function 

%% F10
w0=[-1;2];   % ponto inicial
%% para o critério de paragem
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
%% aplicar o algoritmo Método de Descida Máxima com procura exata do eta
[w_opt,Fval_opt,output]=MDM_procuraExata(@F9,@F9withgrad,w0,epsilon,Kmax)

%% gráfico das curvas de nível de F
% criar grelha de pontos
[w1,w2] = meshgrid(-2.5:0.01:2.5, -1:0.01:3);
vals_F = (1-w1).^2+(1-w2).^2+0.5*(2*w2-w1.^2).^2;

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
text(vals_w1(1), vals_w2(1)+0.2,'w0');
text(vals_w1(end), vals_w2(end)+0.2,'w*');
title('Trajetória dos pontos');
grid on

