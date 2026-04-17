
clear, clc, close all;
%format long;

%% problema
path(path,'Problemas')	% add path to directory with function 

%% F3
H0 = eye(2);
w0=[0;0];   % ponto inicial
%%
epsilon=0.000001;
Kmax=200;    % número máximo de iterações
gamma=1.e-12;
%% aplicar o algoritmo Método BFGS + estratégia skkiping + procura de Armijo com backtracking
[wopt,Fopt,output]=BFGS_Armijo(@F3,@F3withgrad,H0,w0,epsilon,Kmax,gamma)

%% gráfico das curvas de nível de F
% criar grelha de pontos
[w1,w2] = meshgrid(-3:0.01:3, -3:0.01:3);
vals_F = w1.^2+2*w2.^2-2*w1.*w2-2*w2;

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
plot(wopt(1),wopt(2),'ko-','LineWidth',0.5,'MarkerFaceColor','r');
text(vals_w1(1)-0.3, vals_w2(1)+0.2,'w0')
text(vals_w1(end), vals_w2(end)+0.2,'w*')
title('Pontos gerados pelo BFGS (Hk) e trajetória')
grid on

