function [f,gradf] = F2withgrad(w)

syms w1 w2;
%----------------------
fun = 4*w1^2+2*w2^2+4*w1*w2-3*w1;
grad = gradient(fun,[w1 w2]);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2],[w(1) w(2)]));
gradf=double(subs(grad,[w1 w2],[w(1) w(2)]));
%----------------------
end