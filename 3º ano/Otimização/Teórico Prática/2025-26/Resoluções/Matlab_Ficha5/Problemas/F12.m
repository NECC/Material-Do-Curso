function [f] = F12(w)

syms w1 w2;

fun= sqrt(w1^2+1)+sqrt(w2^2+1);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1,w2],[w(1),w(2)]));

%----------------------
end