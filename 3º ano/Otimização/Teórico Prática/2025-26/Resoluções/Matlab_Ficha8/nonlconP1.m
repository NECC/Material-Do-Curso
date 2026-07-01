function [c,ceq] = nonlconP1(w)

syms w1 w2

% nonlinear inequality c(w) <=0 
c=[];
% nonlinear equality ceq(w)=0
ce=w1^2+w2^2-2;

%calcular no ponto w
ceq=double(subs(ce,[w1;w2],w));
end