function [c,ceq] = nonlconHS39(w)

syms w1 w2 w3 w4

% nonlinear inequality c(w) <=0 
c=[];
% nonlinear equality ceq(w)=0
ce=[w2-w1^3-w3^2;w1^2-w2-w4^2];

%calcular no ponto w
ceq=double(subs(ce,[w1;w2;w3;w4],w));
end