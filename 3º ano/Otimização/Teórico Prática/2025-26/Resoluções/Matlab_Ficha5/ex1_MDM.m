
clear, clc, close all;
%format long;
%% problema
path(path,'Problemas')	% add path to directory with function 

%% F9  
beta=1;
w0=[10;1];   % ponto inicial
%% para o critério de paragem
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
%% aplicar o algoritmo Método de Descida Máxima com procura exata do eta
[w_opt,Fval_opt,output]=MDM_procuraExata(@F9,@F9withgrad,w0,epsilon,Kmax)

%% gráfico das curvas de nível de F
% criar grelha de pontos
[w1,w2] = meshgrid(-5:0.01:10, -5:0.01:5);
vals_F = w1.^2 + beta*w2.^2;

% contornos
figure
contour(w1,w2,vals_F,10);
colorbar;

xlabel('w_1');
ylabel('w_2');
hold on
vals_w1=output(:,2);
vals_w2=output(:,3);
plot(vals_w1, vals_w2,'ro-','LineWidth',1,'MarkerFaceColor','r','MarkerSize', 4)
text(vals_w1(1), vals_w2(1)+0.2,'w0')
text(vals_w1(end), vals_w2(end)+0.5,'w*')
title('Trajetória dos pontos')
grid on



