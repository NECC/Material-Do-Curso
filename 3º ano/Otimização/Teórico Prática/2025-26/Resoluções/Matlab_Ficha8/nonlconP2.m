function [c,ceq] = nonlconP2(w)

syms w1 w2 w3

% nonlinear inequality c(w) <=0 
ci=-6*w2-4*w3+w1^3+3;
%calcular no ponto w
c=double(subs(ci,[w1;w2;w3],w));

% nonlinear equality ceq(w)=0
ceq=[];

end