function [f] = F10(w)

syms w1 w2;
%----------------------
fun = (1-w1)^2+(1-w2)^2+0.5*(2*w2-w1^2)^2;

%calcular a funcao e o gradiente no pto. w
f=subs(fun,[w1 w2],[w(1) w(2)]);
%----------------------
end