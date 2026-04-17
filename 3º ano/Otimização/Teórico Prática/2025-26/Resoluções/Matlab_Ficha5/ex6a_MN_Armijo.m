
clear, clc, close all;
%format long;
%% problema
path(path,'Problemas')	% add path to directory with function 

%% F11
w0=sqrt(2/5);   % ponto inicial
%% para o critério de paragem
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
%% aplicar o algoritmo Método de Newton com procura de Armijo com backtracking
[w_opt,Fval_opt,output]=MN_Armijo(@F11,@F11withgradHess,w0,epsilon,Kmax)

%% gráfico das curvas de nível de F
% criar linha de pontos
w = linspace(-1, 1, 100);
vals_F = w.^2 -(w.^4)/4;

% gráfico de F
figure
plot(w,vals_F,'LineWidth',2);
xlabel('w');
ylabel('F');

hold on
% desenhar os pontos gerados e trajetória (wk,Fk)
vals_w=output(:,2); 
vals_F=output(:,3);
plot(vals_w,0,'ro','MarkerFaceColor','r');
plot(vals_w, vals_F, 'ko--','LineWidth', 0.5); % pontos (wk,Fk);
title('Gráfico de F, pontos gerados pelo NM e trajetória')
grid on
text(vals_w(1), 0+0.03,'w0')
text(vals_w(end), 0+0.04,'w*')
title('Pontos gerados pelo MN e trajetória')
grid on

%----------------------------------
