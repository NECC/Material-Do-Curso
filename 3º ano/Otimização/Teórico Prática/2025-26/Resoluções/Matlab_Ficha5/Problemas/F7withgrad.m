function [f,gradf] = F7withgrad(w)

syms w1 w2 w3;
%----------------------
fun = w1^2+w2^2+w3^2;
grad = gradient(fun,[w1 w2 w3]);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2 w3],[w(1) w(2) w(3)]));
gradf=double(subs(grad,[w1 w2 w3],[w(1) w(2) w(3)]));
%----------------------

end