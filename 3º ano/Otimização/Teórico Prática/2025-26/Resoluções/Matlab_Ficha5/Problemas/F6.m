function [f] = F6(w)

syms w1 w2 w3;
%----------------------
fun = (5*w1^2+7*w2^2+9*w3^2+4*w1*w2+2*w1*w3+6*w2*w3)/2+8*w1+9*w1+8*w3;
%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2 w3],[w(1) w(2) w(3)]));
end