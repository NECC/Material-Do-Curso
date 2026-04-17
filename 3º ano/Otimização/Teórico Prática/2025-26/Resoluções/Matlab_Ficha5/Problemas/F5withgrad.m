function [f,gradf] = F5withgrad(w)

syms w1 w2 w3;
%----------------------
fun = (2*w1^2+3*w2^2+4*w3^2)/2+8*w1+9*w2+8*w3;
grad = gradient(fun,[w1 w2 w3]);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2 w3],[w(1) w(2) w(3)]));
gradf=double(subs(grad,[w1 w2 w3],[w(1) w(2) w(3)]));
%----------------------

end