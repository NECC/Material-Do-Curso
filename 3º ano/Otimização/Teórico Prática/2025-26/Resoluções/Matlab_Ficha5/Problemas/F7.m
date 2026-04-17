function [f] = F7(w)

syms w1 w2 w3;
%----------------------
fun = w1^2+w2^2+w3^2;
%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2 w3],[w(1) w(2) w(3)]));
end